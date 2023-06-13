tpl 1.6 module traversys_Sudo;

// TODO: Refactoring

metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Extended', 'Sudo Evaluations';
end metadata;

table exit_codes 1.0
    '0'	    ->	true;
    default	->	false;
end table;

pattern traversys_sudo 1.0
    '''
    SUDO Evaluations.

    Author: Wes Fitzpatrick
    
    Change History:
    2013-10-13 | 1.0 | WF | Created.

    Captures and evaluates SUDO rules.
    '''

    overview
        tags sudo, custom, traversys, security;
    end overview;

    constants
        sudo_paths := [ "/usr/local/bin/sudo", "/bin/sudo", "/usr/bin/sudo", "/etc/sudo" ];
        linux_commands := ['lsof', 'dmidecode', 'ethtool'];
        solaris_commands := ['lsof', 'ndd', 'ifconfig', 'lputil'];
        aix_commands := ['lsof', 'lslpp'];
        hpux_commands := ['lanadmin', 'swlist', 'lsof'];
    end constants;

    triggers
        on host := Host created, confirmed where os_class = 'UNIX';
    end triggers;

    body

        for path in sudo_paths do
            test:= discovery.runCommand(host, 'if test -f %path%; then echo 0; else echo 1; fi');
            if not test then
                log.warn('No sudo found in the expected paths, stopping...');
                model.withdraw(host,"sudo_path");
                model.withdraw(host,"sudo_rules");
                stop;
            end if;
        end for;
        
        for path in sudo_paths do 
            if host.os_type = 'Solaris' then
                suexec_cmd:= '`[ -f %path% ]` echo $?';
                sudo_cmd  := '`[ -x %path% ]` echo $?';
            else
                suexec_cmd:= 'if test -f %path%; then echo 0; else echo 1; fi';
                sudo_cmd  := 'if test -x %path%; then echo 0; else echo 1; fi';
            end if;
            
            suexec:= discovery.runCommand(host, suexec_cmd);
            
            if suexec.result matches '0' then
                suexec := discovery.runCommand(host, sudo_cmd);
                if suexec and suexec.result matches '0' then
                    sudo:= discovery.runCommand(host, '%path% -l | grep -v a_tid');
                    if sudo then
                        if sudo.result matches 'ifconfig|ndd|ethtool' then
                            sudo_path := '%path%';
                            sudo_rules := sudo.result;
                        end if;
                    end if;
                end if;
            end if;
        end for;

        sudo_path := void;
        sudo_rules := void;
        for path in sudo_paths do 
            suexec := discovery.runCommand(host, 'ls %path%');
        
            if suexec and suexec.result matches '%path%[^:]' then
                sudo_installed_checked := '%path%';
                checked_paths := text.split(sudo_installed_checked, ",");
                for path in checked_paths do
                    sudo_check := discovery.runCommand(host, '%path% -l | grep -v a_tid');
                    if sudo_check then
                        if sudo_check.result matches 'ifconfig|ndd|ethtool' then
                            sudo_path := '%path%';
                            sudo_rules := sudo_check.result;
                        end if;
                    end if;
                end for;
            end if;
        end for;

        host.sudo_path  := '%sudo_path%';
        host.sudo_rules := '%sudo_rules%';

        da_method := search(in host traverse InferredElement:Inference:Associate:DiscoveryAccess
                                where _last_marker
							                      traverse DiscoveryAccess:DiscoveryAccessResult:DiscoveryResult:DeviceInfo
							                          show last_access_method);

        if size(da_method) > 0 and da_method[0] = 'snmp' then
            log.warn('Host last discovered via SNMP, stopping...');
            host.sudo_access := false;
            stop;
        end if;

        path_test := 'echo $PATH';
        path_check := discovery.runCommand(host, path_test);
        if path_check then
            path := text.strip(path_check.result);
            log.debug('Path: %path%');
        end if;

        sudo_all_commands_check := 'sudo -l';
        run_sudo_all_commands_check := discovery.runCommand(host, sudo_all_commands_check);
        if run_sudo_all_commands_check then
            log.debug('Commands we can run: %run_sudo_all_commands_check.result%');
        else
            log.debug('Cannot run sudu, stopping...');
            host.sudo_access := false;
            stop;
        end if;

        which_sudo_cmd := 'which sudo > /dev/null 2>&1; echo $?';
        which_sudo := discovery.runCommand(host, which_sudo_cmd);
        exit_c := text.strip(which_sudo.result);	
        sudo_found := exit_codes[exit_c];

        if sudo_found then;
            which_sudo := 'which sudo';
            run_which_sudo := discovery.runCommand(host, which_sudo_cmd);
            host.sudo := text.strip(run_which_sudo.result);
            sudo_check := host.sudo + ' -l > /dev/null 2>&1; echo $?';
            run_sudo := discovery.runCommand(host, sudo_check);
            run_sudo_ec := text.strip(run_sudo.result);
            host.sudo_access := exit_codes[run_sudo_ec];
        end if;

        if host.sudo_access then		
            lsof_check := host.sudo + ' -l | grep lsof > /dev/null 2>&1; echo $?';
            run_lsof := discovery.runCommand(host, lsof_check);
            lsof_result := text.strip(run_lsof.result);
            host.sudo_lsof_access := exit_codes[lsof_result];

            if host.os_type matches '(?i)linux' or host.os_type matches 'ESX' then

                ethtool_check := host.sudo + ' -l | grep ethtool > /dev/null 2>&1; echo $?';
                run_ethtool := discovery.runCommand(host, ethtool_check);
                ethtool_result := text.strip(run_ethtool.result);

                dmidecode_check := host.sudo + ' -l | grep dmidecode > /dev/null 2>&1; echo $?';
                run_dmidecode :=  discovery.runCommand(host, dmidecode_check);
                dmidecode_result := text.strip(run_dmidecode.result); 

                host.sudo_ethtool_access := exit_codes[ethtool_result];
                host.sudo_dmidecode_access := exit_codes[dmidecode_result];

                sudo_missing_commands:= [];

                if not host.sudo_lsof_access then 
                    sudo_missing_commands := ['lsof'];
                end if;
                if not host.sudo_ethtool_access then
                    sudo_missing_commands := sudo_missing_commands + ['ethtool'];
                end if;
                if not host.sudo_dmidecode_access then
                    sudo_missing_commands := sudo_missing_commands + ['dmidecode'];
                end if;

            end if;
            
        end if;

        all_users_command := 'awk -F":" \'{ print $1 }\' /etc/passwd';
        all_users_cmd := discovery.runCommand(host, all_users_command);
        all_users_cmd_output:= '';
        all_users:= '';

        if all_users_cmd then
            all_users_cmd_result := all_users_cmd.result;
            list_users := text.split(all_users_cmd_result, "\r\n");

            for user in list_users do
                if user <> '' then   
                    if all_users = '' then
                        all_users := "%user%";
                    else
                        all_users := "%all_users%,%user%";
                    end if;
                end if;
            end for;

            all_users_cmd_output := text.split(all_users, ",");
        end if;

        if all_users_cmd_output = '' then
            model.withdraw(host,"user_accounts");
        else
            host.user_accounts := all_users_cmd_output;
        end if;

        expired_users := '';
        user_accounts_expiry_output:= '';
        if sudo_rules matches '/usr/bin/awk.*/etc/shadow' then
            expiry_users_command := '%sudo_path% /usr/bin/awk -F: \'$5 != "" && $5 != "99999" { print $1 }\' /etc/shadow';
            expiry_users_cmd := discovery.runCommand(host, expiry_users_command);

            if expiry_users_cmd then
                expiry_users_cmd_result := expiry_users_cmd.result;
                if expiry_users_cmd_result matches regex '(?i)fatal|sorry' then
                    user_accounts_expiry_issue := 'Unable to check accounts';
                elif expiry_users_cmd_result matches regex '\w+' then
                    list_expired_users := text.split(expiry_users_cmd_result, "\r\n");
                    for expired_user in list_expired_users do
                        if expired_user <> '' then   
                            if expired_users = '' then
                                expired_users := "%expired_user%";
                            else
                                expired_users := "%expired_users%,%expired_user%";
                            end if;
                        end if;
                    end for;
                else
                    user_accounts_expiry_issue := 'No Expired Account';
                end if;
            else
                user_accounts_expiry_issue := 'Unable to check accounts';
            end if;
        else
            user_accounts_expiry_issue := 'Unable to check accounts';
        end if;

        if expired_users <> '' then
            user_accounts_expiry_output := text.split(expired_users, ",");
        end if;

        if user_accounts_expiry_output = '' then
            model.withdraw(host,"user_accounts_expiry");
        else
            host.user_accounts_expiry := user_accounts_expiry_output;
        end if;

        login_file := "/etc/login.defs";
        get_login_file_cmd := discovery.fileGet(host, '%login_file%');
        user_accounts_max_days_output := '';
        user_accounts_min_days_output := '';
        user_accounts_min_len_output := '';
        user_accounts_warn_age_output := '';
        if get_login_file_cmd then
            if get_login_file_cmd.content matches regex '(?i)permission|cannot' then
                log.error("Cannot open %login_file% file - Not Found");
            else
                get_login_file := get_login_file_cmd.content;
                controls := regex.extractAll(get_login_file, regex '([^#]PASS_\w+\s+\d+)');
                for control in controls do
                    if user_accounts_max_days_output = '' then
                        user_accounts_max_days_output := regex.extract(control, regex 'PASS_MAX_DAYS\s+(\d+)', raw '\1');
                    end if;
                    if user_accounts_min_days_output = '' then
                        user_accounts_min_days_output := regex.extract(control, regex 'PASS_MIN_DAYS\s+(\d+)', raw '\1');
                    end if;
                    if user_accounts_min_len_output = '' then
                        user_accounts_min_len_output := regex.extract(control, regex 'PASS_MIN_LEN\s+(\d+)', raw '\1');
                    end if;
                    if user_accounts_warn_age_output = '' then
                        user_accounts_warn_age_output := regex.extract(control, regex 'PASS_WARN_AGE\s+(\d+)', raw '\1');
                    end if;
                end for;
            end if;
        end if;

        if user_accounts_max_days_output = '' then
            model.withdraw(host,"user_accounts_max_days");
        else
            host.user_accounts_max_days := '%user_accounts_max_days_output%';
        end if;

        if user_accounts_min_len_output = '' then
            model.withdraw(host,"user_accounts_min_len");
        else
            host.user_accounts_min_len := '%user_accounts_min_len_output%';
        end if;

        shadow_rule := '/etc/shadow';
        sudo_shadow_rules_output := '';

        if sudo_path then
            if sudo_path = '/opt/boksm/bin/suexec' then
                sudo_shadow_rules_output := 'Yes';      
            else
                sudo_shadow_rules_cmd := discovery.runCommand(host, '%sudo_path% -l 2>/dev/null | grep -c %shadow_rule%');
                if sudo_shadow_rules_cmd then
                    if sudo_shadow_rules_cmd.result matches '[^\d+]0' then
                        sudo_shadow_rules_output := 'No';
                    else
                        sudo_shadow_rules_output := 'Yes';
                    end if;
                else
                    sudo_shadow_rules_output := 'No';
                end if;
            end if;
        else
            sudo_shadow_rules_output := 'No';
        end if;

        if sudo_shadow_rules_output = '' then
            model.withdraw(host,"sudo_shadow_rules");
        else
            host.sudo_shadow_rules := '%sudo_shadow_rules_output%';
        end if;

    end body;

end pattern;

