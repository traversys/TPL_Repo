tpl 1.6 module traversys_AdditionalHostInfo;

// TODO: Refactoring and merge similar functions

metadata
   origin:="Traversys";
   tree_path:='Traversys', 'Extended', 'Additional Host Info';
end metadata;

table command_list 1.0
  "etc_passwd" -> "sed 's/^/file passwd:/' /etc/passwd";
  "etc_group" -> "sed 's/^/file group:/' /etc/group";
  "getent_passwd" -> "getent passwd | sed -e 's/:[^:]*:/:*:/' -e 's/^/getent passwd:/'";
  "getent_group" -> "getent group | sed 's/^/getent group:/'";
  "nis_domain" -> "domainname | sed 's/^/domain:/'";
  "nis_master" -> "ypwhich -m passwd 2>/dev/null | sed 's/^/master:/'";
end table;

configuration diskCmds 1.0

    "Retrieve VPD Info"
    scsi_id:="ls -al /dev/disk/by-id";

    "Retrieve Blocks"
    blocklist:="ls -al /sys/block/*/device";

    "Query HBA Diskdrive"
    wmi_diskdrive:='SELECT * from CIM_DiskDrive';

    "Query HBA Logical Disk"
    wmi_logicaldisk:="Select * from CIM_Logicaldisk";

    "Query HBA Windows Directory"
    wmi_windir:='SELECT WindowsDirectory from Win32_OperatingSystem';

    "Query DD to Disk Partition"
    wmi_dddp:="SELECT * from Win32_DiskDriveToDiskPartition";

    "Query LD to Partition"
    wmi_ldp:="SELECT * from Win32_LogicalDiskToPartition";

end configuration;

pattern traversys_add_hostinfo 1.0

    '''
    Author: Wes Moskal-Fitzpatrick

    Description:
    Get additional info from a host.

    Supported Platforms:
    Unix

    Change History:
    2013-03-01 | 1.0 | WMF | Created.

    '''

    overview 
        tags traversys, storage, hostinfo, custom;
    end overview;
    
    constants
        oracle_ka_cmd := '/usr/sbin/ndd';
        linux_ka_cmd  := 'sysctl';
        namespace     := raw 'root\CIMV2';
        wmiquery      := 'select DeviceID, Size, Freespace from Win32_LogicalDisk';
    end constants;

    triggers 
        on host := Host created, confirmed;
    end triggers;

    body

        // get vpd info
        get_scsi_id:= discovery.runCommand(host, diskCmds.scsi_id);

        if get_scsi_id and get_scsi_id.result then
            for id in text.split(get_scsi_id.result, "\n") do
                scsi_serial:=regex.extract(id, regex 'scsi-(\S+)', raw '\1');
                scsi_block_key:=regex.extract(id, regex 'scsi-\S+ ->\W+(\S+)', raw '\1');
                scsi_id_tab[scsi_block_key]:=scsi_serial;
            end for;
        end if;

        dns_servers:= [];
  
        if host.os_type matches 'Linux' then
            // Get resolve.conf
            resolve_conf:= discovery.fileGet(host, "/etc/resolv.conf");

            // Get output of nmcli
            nmcli:= discovery.runCommand(host, "nmcli d list");
        
            // Get content of dhclient leases
            dhcl_lease:= discovery.fileGet(host, "/var/lib/dhclient/dhclient-eth0.leases");
        
            cmd_linux:= discovery.runCommand(host, "grep nameserver /etc/resolv.conf | awk '{print $2}'");

            // Extract the domain
            DNSDomain_output := regex.extract(resolve_conf.content, 'domain\s*(.*)', raw'\1');

            // Extract the search list
            DNSSearchList := regex.extract(resolve_conf.content, 'search\s*(.*)', raw'\1');
            if DNSSearchList then
            // Build list of searches
            DNSSearchList_output := text.split(DNSSearchList, " ");
            end if;

            // Extract all valid nameservers
            DNSNameServers_output := regex.extractAll(resolve_conf.content, regex '[^#]\s*nameserver\s*(\S+)');

            // Extract all excluded nameservers
            DNSNameServersExclude_output := regex.extractAll(resolve_conf.content, regex '#\s*nameserver\s*(\S+)');

            // Extract all options
            DNSOptions := regex.extract(resolve_conf.content, regex 'options\s*(.*)', raw'\1');
            if DNSOptions then
            // Build list of options
            DNSOptions_output := text.split(DNSOptions, " ");
            end if;

            // Extract all comments
            ResolvConfComments_output := regex.extractAll(resolve_conf.content, regex '#(.*)');

            //Write attributes to host node
            if ResolvConf_output = '' then model.withdraw(host,"ResolvConf"); else host.ResolvConf := ResolvConf_output; end if;
            if ResolvConfComments_output = '' then model.withdraw(host,"ResolvConfComments"); else host.ResolvConfComments := ResolvConfComments_output; end if;
            if DNSDomain_output = '' then model.withdraw(host,"DNSDomain"); else host.DNSDomain := DNSDomain_output; end if;
            if DNSSearchList_output = '' then model.withdraw(host,"DNSSearchList"); else host.DNSSearchList := DNSSearchList_output; end if;
            if DNSNameServers_output = '' then model.withdraw(host,"DNSNameServers"); else host.DNSNameServers := DNSNameServers_output; end if;
            if DNSNameServersExclude_output = '' then model.withdraw(host,"DNSNameServersExclude"); else host.DNSNameServersExclude := DNSNameServersExclude_output; end if;
            if DNSOptions_output = '' then model.withdraw(host,"DNSOptions"); else host.DNSOptions := DNSOptions_output; end if;
            
            // Legacy command
            if cmd_linux and cmd_linux.result then
                dns_servers:= cmd_linux.result;
            end if;
            
        elif host.os_class = "Windows" then
        
            ip_config:= discovery.runCommand(host, "ipconfig /all");
            
            if ip_config and ip_config.result then
                dns_entry:= regex.extractAll(ip_config.result, regex "DNS\sServers(\s\.)+\s:\s(\S+)(\s+(\S+))");
                log.debug("DNS server entry = %dns_entry%");
                if size(dns_entry) > 0 then
                    dns_extract:= dns_entry[0];
                    for i in dns_extract do
                        log.debug("i = %i%");
                        ip:= regex.extract(i, regex "((\d+\.?)+)", raw "\1");
                        if ip not in dns_servers and ip matches "^\d+\." then
                            list.append(dns_servers, ip);
                        end if;
                    end for;
                end if;
            end if;
            
        end if;

        //Declare ouput variables
        DNSDomain_output := '';
        DNSSearchList_output := '';
        DNSNameServers_output := '';

        //Run WMI Query
        wmi := discovery.wmiQuery(host, 'SELECT DNSDomain,DNSServerSearchOrder,DNSDomainSuffixSearchOrder FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = TRUE', 'root\CIMV2');
        
        if wmi then
        
            // Extract the domain
            DNSDomain_output := wmi[0].DNSDomain;
            
            // Extract all valid nameservers
            DNSNameServers_output := wmi[0].DNSServerSearchOrder;
            
            // Extract the search list
            DNSSearchList_output := wmi[0].DNSDomainSuffixSearchOrder;
        
        end if;
        
        //Write attributes to host node
        if DNSDomain_output = '' then model.withdraw(host,"DNSDomain"); else host.DNSDomain := DNSDomain_output; end if;
        if DNSSearchList_output = '' then model.withdraw(host,"DNSSearchList"); else host.DNSSearchList := DNSSearchList_output; end if;
        if DNSNameServers_output = '' then model.withdraw(host,"DNSNameServers"); else host.DNSNameServers := DNSNameServers_output; end if;
        
        if size(dns_servers) > 0 then
            host.DNSServers:= dns_servers;
            model.addDisplayAttribute(host, "DNSServers");
            //host._tw_meta_data_attrs:= [ 'DNSServers' ];
        else
            model.withdraw(host, "DNSServers");
            model.removeDisplayAttribute(host, "DNSServers");
        end if;

        // look for redhat4 blocks if none found via rhel5 method
        lun_blocklist:=discovery.runCommand(host, diskCmds.blocklist);

        if lun_blocklist and lun_blocklist.result then

            rh_four_cleaned_lun:=regex.extract(cleaned_lun, regex '(/devices/*.*)', raw '\1');

            for line in text.split(rh4_lun_blocklist.result, "\n") do
                get_block_end:= regex.extract(line, regex '/devices/\S+/\S+/\S+/\S+/(\S+)', raw '\1');
                get_block_end:=text.strip(get_block_end);
                get_clean:=regex.extract(rh_four_cleaned_lun, regex '\/(\d+:\d+:\d+:\d+)', raw '\1');
                get_clean:=text.strip(get_clean);
                if get_block_end = get_clean then
                    rh_block_letters:=regex.extract(line, regex '/(\w+)', raw '\1');
                    cleaned_block:=rh_block_letters;
                end if;
            end for;

            if cleaned_block and lun_capacity = 0 then
                get_sysfs_block_size:=discovery.runCommand(host, "cat /sys/block/%cleaned_block%/size");
                if get_sysfs_block_size and get_sysfs_block_size.result then
                    lun_capacity:=get_sysfs_block_size.result;
                    lun_capacity:=text.strip(lun_capacity);
                end if;
            end if;

        end if;

        wmi:=discovery.wmiQuery(host, diskCmds.wmi_diskdrive, 'root\cimv2');
        if not wmi then
            log.warn('wmi diskdrive not found');
        end if;

        logical_disk_run:=discovery.wmiQuery(host, diskCmds.wmi_logicaldisk, 'root\cimv2');

        if assoc_query and logical_disk_run and wmi_logical_disks then

        for line in logical_disk_run do
            stripped_id:=text.strip(line.DeviceID);
            logical_box[stripped_id]:=line.FreeSpace;
        end for;

        win_root:=discovery.wmiQuery(host, diskCmds.wmi_windir, 'root\cimv2');

        if win_root then
            wroot:=win_root[0].WindowsDirectory;
            for elements in win_root do
                wroot:=win_root[0].WindowsDirectory;
            end for;
        else
            checkdir:=discovery.listDirectory(host,"C:\WINNT");

            if checkdir then
                win_root:="C:\WINNT";
            else
                checkdir:=discovery.listDirectory(host,"C:\WINDOWS");
                win_root:="C:\WINDOWS";
            end if;
            for elements in win_root do
                wroot:=win_root;
            end for;
        end if;

        assoc_query:=discovery.wmiQuery(host, diskCmds.wmi_dddp, 'root\cimv2');

        if assoc_query and logical_disk_run and wmi_logical_disks then

        for line in logical_disk_run do
            stripped_id:=text.strip(line.DeviceID);
            logical_box[stripped_id]:=line.FreeSpace;
        end for;

        for line in assoc_query do
            assocs_id:=line.Dependent;
            assocs_map:=regex.extract(line.Antecedent, regex '=".\\\\\\.\\(\S+)"', raw '\1');
            assocs_map:=text.strip(assocs_map);
            assocs_id:=text.strip(assocs_id);
            drive_box[assocs_map]:=assocs_id;
        end for;

        wmi_logical_disks:=discovery.wmiQuery(host, diskCmds.wmi_ldp, 'root\cimv2');

        for line in wmi_logical_disks do
            getletter:=regex.extract(line.Dependent, regex '="(\S+)"', raw '\1');
            logicalid:=text.strip(line.Antecedent);
            large_box[logicalid]:=getletter;
        end for;

        tcp_keep_alive := '';

        log.info ('Running tcp_keep_alive cmd on %host.name%');
        if host.os_type matches regex "(?i)\bLinux" then
            command := discovery.runCommand(host, linux_ka_cmd + ' net.ipv4.tcp_keepalive_time');
        else
            command := discovery.runCommand(host, oracle_ka_cmd + ' -get /dev/tcp tcp_keepalive_interval');
            fls := model.FileSystem(host);
            wmiquery_res := discovery.wmiQuery(host, wmiquery, namespace); 
            wmiquery_devID := wmiquery_res.DeviceID;
            wmiquery_FreeSpace := wmiquery_res.FreeSpace;
            wmiquery_Size := wmiquery_res.Size;
            attributes := [0, 1, 2, 3, 4, 5, 6];
            for deviceID in wmiquery_devID do
                for attribute in attributes do
                    if deviceID[attribute] = "" then
                        deviceID[attribute] := 'None';
                    else
                        devID := deviceID[attribute];
                    end if;
                end for;
            end for;
            fls.df_output := "%wmiquery_res%";
        end if;

        if command then
            tcp_keep_alive := regex.extract(command.result, regex '= (\d+)', raw '\1');
        end if;

        host.tcp_keep_alive := tcp_keep_alive;

        resolv_conf := '/etc/resolv.conf';
        rc := discovery.fileGet(host, resolv_conf);
        if rc then
        // Extract attributes common to all Linux/Unixes
            host.DNS_domain := regex.extract(rc.content, 'domain (.*)', raw'\1');
            host.DNS_search_list := regex.extract(rc.content, 'search (.*)', raw'\1');
            host.DNS_name_servers := regex.extractAll(rc.content, regex 'nameserver\s+(\S+)');
        end if;
        
        if (device.os_type has subword 'Linux' or device.os_type has subword 'ESX') then
            mtab := '/etc/mtab';
            mt := discovery.fileGet(host, mtab);
            if mt then
                host.mtab_file := mt.content;
            end if;
        end if;

        interface_name := search(in host traverse DeviceWithInterface:DeviceInterface:InterfaceOfDevice:NetworkInterface);
  
        if size(interface_name) > 0 then
            for NIC in interface_name do
            int_cmd := discovery.runCommand(host, "/sbin/ifconfig %NIC.name%");
            if int_cmd then
                int := '%int_cmd.result%';
	            if int has substring "UP" and int has substring "RUNNING" then
	                NIC.state := "UP";
	            else
	                NIC.state :="DOWN";
	        end if;
        end if;

        usb_results := discovery.wmiQuery(host, "SELECT * FROM Win32_DiskDrive WHERE InterfaceType = 'USB'", "root\CIMV2" );
        count:= 0
        for result in usb_results do
            for key in result do
                count:= count+1
                host.['%key%_%count%']:=key[count];
            end for;
        end for;

        command_names := ["etc_passwd", "etc_group", "getent_passwd", "getent_group", "nis_domain", "nis_master"];

        for command_name in command_names do
            test_command := command_list[command_name];
            run_command := discovery.runCommand(host, test_command);
            if run_command then
                run_command_result := run_command.result;
                if run_command_result = '' then
                    //destroy host node attributes
                    model.withdraw(host,"%command_name%");
                else
                    //write results to host node attributes
                    log.info("Writing data to host.%command_name% on %hostname%.");
                    if command_name = 'etc_passwd' then
                        host.etc_passwd := run_command_result;
                    elif command_name = 'etc_group' then
                        host.etc_group := run_command_result;
                    elif command_name = 'getent_passwd' then
                        host.getent_passwd := run_command_result;
                    elif command_name = 'getent_group' then
                        host.getent_group := run_command_result;
                    elif command_name = 'nis_domain' then
                        host.nis_domain := run_command_result;
                    elif command_name = 'nis_master' then
                        host.nis_master := run_command_result;
                    end if;
                end if;
            end if;
        end for;

    end body;

end pattern;

pattern traversys_getUninstallList 1.0
  """
    Retrieves the uninstall list of software from the registry.

    Change History:
    2013-10-22 | 1.0 | WMF | Created.

  """

  overview
    tags wmi, custom, traversys;
  end overview;

  constants
    regkey := ['HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall'];
  end constants;

  triggers
    on device := DeviceInfo where os_type matches regex "(?i)Windows";
  end triggers;

  body

    host := model.host(device);

    if not host then
        log.error('No host node for: %device.name%');
        stop;
    end if;

    hostname := host.hostname;

    log.info ('%hostname%: Running Reg Query...');

    for regkeys in regkey do
    log.debug('%hostname%: Regkeys value: %regkeys%');

        uninstall := discovery.registryKey(host, regkeys);
        log.debug('%hostname%: Unistall key values retrieved: %uninstall%');
    
  end body;
  
end pattern;


pattern traversys_getSyslog 1.0
    """
    This pattern is used to determine the existance of the SYSLOG patch and test for 'inp-ibuslog' within it.
  
    This pattern returns 3 possible outputs to 1 attribute (syslogconfig) to the host node.
        1. Not found - the SYSLOG file could not be found
        2. Found: Configured - The SYSLOG file is found and the string 'inp-ibuslog' is contained within it.
        3. Found: Not Configured - The SYSLOG file is found but the string 'inp-ibuslog' is NOT contained within it.
    
    Author: Wes Fitzpatrick
    
    Change History:
    2009-06-09 | 1.0 | WMF | Created.

    Supported Platforms:
    Unix

    """
    overview
        tags traversys, syslog;
    end overview;

    triggers
        on dev := DeviceInfo where os_class = 'UNIX';
    end triggers;  

    body
	  
        host := model.host(dev);
        if not host then
            log.error('model.host did not return a host node. Stopping.');
            stop;
        end if;
    
        hostname := host.name;
        os_type := host.os_type;
        log.info('~SYSLOG discovery pattern running for %os_type% on %hostname%.'); 
    
        //declare output variables
        syslogconfig_output := '';
    
        //open /etc/sysconfig/syslog file to find ZONE
        syslog_file := "/etc/syslog.conf";
    
    
        get_syslog_file_cmd := discovery.fileGet(host, '%syslog_file%');
        log.info('Opening %syslog_file% file on %hostname%.');
   
        if get_syslog_file_cmd then
      
            //extract syslog file contents
            get_syslog_file := get_syslog_file_cmd.content;

            //extract 'inp-ibuslog' from syslog file
            syslog_ibuslog := regex.extract(get_syslog_file, regex '(inp-ibuslog)', raw '\1');
      
            if syslog_ibuslog then
                log.info('%syslog_ibuslog% extracted from %syslog_file% file on %hostname%.');
                syslogconfig_output := 'Found: Configured';
            else
                log.info('inp-ibuslog cannot be found in %syslog_file% file on %hostname%.');
                syslogconfig_output := 'Found: Not Configured';
            end if;
        else  
            syslogconfig_output := 'Not Found';
        end if;
     
        log.info('Writing SYSLOG discovery data to host node attributes for %hostname%.');

        if syslogconfig_output = '' then
            model.withdraw(host,"syslogconfig");
        else
            host.syslogconfig := '%syslogconfig_output%';
        end if;
    
	    log.info('~SYSLOG discovery pattern ended on %hostname%.');

  end body;
  
end pattern;



pattern getHostInfoWindows 1.0
    '''
    Get additional host info from Windows.

    Author: Wes Fitzpatrick
    
    Change History:
    2009-06-09 | 1.0 | WMF | Created.

    Supported Platforms:
    Windows

    '''
  
    overview
        tags traversys, hostinfo, windows;
    end overview;

    triggers
        on device := DeviceInfo where os_class matches regex'Windows';
    end triggers;

    body
        host := related.host(device);

        if not host then
            stop;
        end if;

        wmi := discovery.wmiQuery(host, 'SELECT InstallDate,LastBootUpTime FROM Win32_OperatingSystem', 'root\CIMV2');
        if wmi then
            host.install_date := wmi[0].InstallDate;
            host.last_Boot := wmi[0].LastBootUpTime;
        end if;

        wmi := discovery.wmiQuery(host, 'SELECT DNSServerSearchOrder,DNSDomainSuffixSearchOrder,WINSPrimaryServer,WINSSecondaryServer FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled=1', 'root\CIMV2');
        if wmi then
            host.DNS_server_search_order := wmi[0].DNSServerSearchOrder;
            host.DNS_domain_suffix_searchorder := wmi[0].DNSDomainSuffixSearchOrder;
            host.wins_primary_server := wmi[0].WINSPrimaryServer;
            host.wins_secondary_server := wmi[0].WINSSecondaryServer;
        end if;

        wmi := discovery.wmiQuery(host, 'SELECT IPXAddress FROM Win32_NetworkAdapterConfiguration WHERE IPXEnabled=1', 'root\CIMV2');
        if wmi then
            host.IPX_address := wmi[0].IPXAddress;
        end if;

        wmi := discovery.wmiQuery(host, 'SELECT Name,SMBIOSBIOSVersion,Version FROM Win32_BIOS', 'root\CIMV2');
        if wmi then
            host.smb_bios_name := wmi[0].Name;
            host.smb_bios_version := wmi[0].SMBIOSBIOSVersion;
            host.bios_version := wmi[0].Version;
        end if;

        wmi := discovery.wmiQuery(host, 'SELECT Name,FileSize,InitialSize,MaximumSize FROM Win32_PageFile', 'root\CIMV2');
        if wmi then
            host.page_name := wmi[0].Name;
            host.file_size := wmi[0].FileSize;
            host.initial_size := wmi[0].InitialSize;
            host.maximum_size := wmi[0].MaximumSize;
        end if;

        wmi := discovery.wmiQuery(host, 'SELECT Name, Manufacturer, Caption FROM Win32_NetworkClient', 'root\CIMV2');
        if wmi then
            host.net_cli_name := wmi[0].Name;
            host.net_manufacturer := wmi[0].Manufacturer;
            host.caption := wmi[0].Caption;
        end if;

        reg := discovery.registryKey(host, raw'HKEY_LOCAL_MACHINE\SOFTWARE\Traversys\BuildData\BootCDVersion');
        if reg then
            host.boot_version := reg.value;
        end if;

        reg := discovery.registryKey(host, raw'HKEY_LOCAL_MACHINE\SOFTWARE\Traversys\BuildData\DistCDVersion');
        if reg then
            host.dist_cd_version := reg.value;
        end if;
        
        reg := discovery.registryKey(host, raw'HKEY_LOCAL_MACHINE\SOFTWARE\Traversys\BuildData\LicenseDetail');
        if reg then
            host.license_detail := reg.value;
        end if;

        reg := discovery.registryKey(host, raw'HKEY_LOCAL_MACHINE\Software\JPMorgan\NT Build\CurrentVersion\MajorVersion');
        if reg then
            host.major_version := reg.value;
        end if;

        reg := discovery.registryKey(host, raw'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\RegisteredOwner');
        if reg then
            host.registered_owner := reg.value;
        end if;

        end body;

    end pattern;

pattern traversys_LastLogin 1.0
    '''
    Pattern to capture the output of the last command which shows last logged on users

    Supported Platforms:
    Unix

    '''

    overview
        tags traversys, custom, last;
    end overview;

    triggers
        on device := DeviceInfo where os_class = 'UNIX';
    end triggers;

    body
    
        host := related.host(device);
        if not host then
            stop;
        end if;

        last := discovery.runCommand(host, 'last -a -n 20');
        if last and last.result then
            host.last_login := last.result;
        end if;

    end body;

end pattern;

pattern Win2008Fix 1.0
    """
        This pattern fixes Windows Version 6.1.7601 which stands for both Windows 7 and Windows 2008 R2.
        If WMI and RemQuery fails - then the OS name string is not returned.
        Infra is not managed by CG acount team so WMI cannot be fixed.

        Change History:
        2018-05-01 1.0 WMF : Created.

        Validation Query:
        search Host where os = 'Microsoft Windows [Version 6.1.7601]'
        show name, type, os_version, os, age_count, #:::DiscoveryAccess.#:::DeviceInfo.os
        
    """

    overview
        tags Windows, Traversys;
    end overview;

    triggers
        on host:= Host created, confirmed where os = "Microsoft Windows [Version 6.1.7601]";
    end triggers;

    body
   
        sysinfo:= discovery.runCommand(host, 'systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"OS Manufacturer"');
        
        reqlist:= discovery.listRegistry(host, raw "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion");
        reg_product_name:= discovery.registryKey(host, raw "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProductName");
        reg_release_id:= discovery.registryKey(host, raw "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ReleaseId"); // doesn't seem to work
        
        host_os:= host.os;
   
        if sysinfo and sysinfo.result then
            host_os:= regex.extract(sysinfo.result, regex "OS Name:\s+(.*)", raw "\1");
            host_ver:= regex.extract(sysinfo.result, regex "OS Version:\s+(.*)", raw "\1");
            host_man:= regex.extract(sysinfo.result, regex "OS Manufacturer:\s+(.*)", raw "\1");
            host.os:= "%host_os% Version %host_ver%";
            host.os_version:= regex.extract(host_os, regex "Microsoft Windows (.*) (Enterprise|Standard)", raw "\1", no_match:= host_os);
            host.os_edition:= regex.extract(host_os, regex "Microsoft Windows (.*) (Enterprise|Standard)", raw "\2", no_match:= host_os);
        elif reg_product_name and reg_product_name.value then
            host_os:= reg_product_name.value;
            host.os:= host_os;
            host.os_version:= regex.extract(host_os, regex "Windows (.*) (Enterprise|Standard)", raw "\1", no_match:= host_os);
            host.os_edition:= regex.extract(host_os, regex "Windows (.*) (Enterprise|Standard)", raw "\2", no_match:= host_os);
        end if;
        
        if host_os matches "Windows 7" then
            host.host_type:= "Windows Desktop";
            host.type:= "Windows Desktop";
            host.tsys_os_modified:= true;
        end if;
        
    end body;

end pattern;


pattern LastPatch 1.0
    """
        Extract the last patch date of the server.

        Change History:
        2018-05-04 1.0 WMF : Created.
        
    """

    overview
        tags Patch, Windows, Traversys;
    end overview;
    
    constants
        registry_key := raw "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\Results\Install\LastSuccessTime";
    end constants;

    triggers
        on host:= Host created, confirmed where os_type = "Windows";
    end triggers;

    body
    
        last_patch:= discovery.runCommand(host, "powershell \"Get-HotFix | sort InstalledOn -Descending | select HotFixID, @{Name='Installed'; Expression={'{0:dd MMMM yyyy}' -f [datetime]$_.InstalledOn.Tostring()}} -First 1\"");
        
        reg_last:= discovery.registryKey(host, registry_key);
        
        if last_patch and last_patch.result then
            host.tsys_last_hotfix := regex.extract(last_patch.result, regex "(KB\d+)", raw "\1");
            host.tsys_last_hotfix_date := regex.extract(last_patch.result, regex "KB\d+\s+(\d+\s\w+\s\d+)", raw "\1");
        elif reg_last and reg_last.result then
            host.tsys_last_hotfix_date := regex.extract(last_patch.result, regex "(\d+-\d+-\d+)", raw "\1");
        end if;
        
    end body;

end pattern;


pattern BuildDate 1.0
    """
        Get the build date for the server.

        Change History:
        2018-06-15 1.0 WMF : Created.
        
    """

    overview
        tags Build, Traversys;
    end overview;
    
    constants
        registry_key := raw "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\Results\Install\LastSuccessTime";
    end constants;

    triggers
        on host:= Host created, confirmed;
    end triggers;

    body
    
        raw_date:= "";
    
        if host.os_class = "Windows" then
            build:= discovery.runCommand(host, 'systeminfo | find /i "date"');
            if build and build.result then
                raw_date:= regex.extract(build.result, regex "Original Install Date:\s+(.*)", raw "\1", no_match:= build.result);
            end if;
        elif host.os_type matches "AIX" then
            build:= discovery.runCommand(host, 'lslpp -h | grep -p bos.rte');
            if build and build.result then
                raw_date:= regex.extract(build.result, regex "(\d+/\d+/\d+\s+(\d+:?)+)", raw "\1", no_match:= build.result);
            end if;
        elif host.os_type matches "Solaris" then
            build:= discovery.runCommand(host, 'pkg info kernel');
            if build and build.result then
                raw_date:= regex.extract(build.result, regex "Packaging Date:\s+(.*)", raw "\1", no_match:= build.result);
            end if;
        elif host.os_type matches "HP-UX" then
            build:= discovery.runCommand(host, '/opt/ignite/bin/print_manifest | more');
            if build and build.result then
                raw_date:= regex.extract(build.result, regex "The system was created\s(.*)\.", raw "\1", no_match:= build.result);
            end if;
        else // Linux
            build:= discovery.runCommand(host, 'ls -ld --time-style=long-iso /var/log/anaconda 2> /dev/null || ls -ld --time-style=long-iso /var/log/installer 2> /dev/null');
            if build and build.result then
                raw_date:= regex.extract(build.result, regex "(\d{4}-\d+-\d+\s\d+:\d+)", raw "\1", no_match:= build.result);
            end if;
        end if;
        
        host.tsys_install_date := raw_date;
        
    end body;

end pattern;


pattern LastLogon 1.1

"""
    Last User Logged On
    
    Change History:
    2016-07-18 - 1.1 - WF: Fixed.

"""

metadata
    __name := 'UserLoggedOn';
    __description := 'This TPL discovers which user was last logged on to a desktop host';
end metadata;

overview
    tags COE, logon;
end overview;

constants
    lou_wmi_query := raw 'select LastLogon, Name, UserType from Win32_NetworkLoginProfile';
    wmi_namespace := raw 'root\CIMV2';
    detail_type := 'Last User Logon';
end constants;

triggers
    on host := Host created, confirmed where os_class = "Windows";
end triggers;

    body
        
        // initialise variables  
        last_time_stamp:= "";
        wmi_detail:= "";

        // Carry out WMI query 
        wmi_results := discovery.wmiQuery(host, lou_wmi_query, wmi_namespace);
        
        if not wmi_results then
            log.warn("WMI query failed or did not run, stopping....");
            stop;
        end if;

        for wmiresult in wmi_results do
            if "LastLogon" not in wmiresult then
                log.warn("No LastLogon detail returned from wmi query, skipping...");
                continue;
            end if;
            // Obtain results and assign attributes to Detail node then relate to trigger Host
            wmiresultll:= wmiresult.LastLogon;
            log.info("wmi LastLogon = %wmiresultll%");
            wmilastlogon:= regex.extract(wmiresultll, regex "(\d+)\.", raw "\1");
            log.debug("wmilastlogon = %wmilastlogon%");
            ydmhms:= regex.extractAll(wmilastlogon, regex "^(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})");
            log.debug("ydmhms = %ydmhms%");
            
            size_ydmhms:= size(ydmhms);
            
            if size_ydmhms = 0 then
                log.warn("Extraction failed, skipping...");
                continue;
            end if;
            
            // format 20160718071738
            yyyy:= ydmhms[0][0];
            mm:= ydmhms[0][1];
            dd:= ydmhms[0][2];
            hh:= ydmhms[0][3];
            m:= ydmhms[0][4];
            s:= ydmhms[0][5];
            last_logon_tmp:= "%yyyy%-%mm%-%dd% %hh%:%m%:%s%";
            log.debug("last_logon_tmp = %last_logon_tmp%");
            last_logon_s:= time.parseUTC(last_logon_tmp);
            log.debug("last_logon_s = %last_logon_s%");
            
            if not last_time_stamp then
                last_time_stamp:= last_logon_s;
                wmi_detail:= wmiresult;
            end if;
            
            if last_logon_s and last_logon_s > last_time_stamp then
                log.info("Updating timestamp and wmi detail");
                // Converts date to readable format yyyymmdd
                last_time_stamp:= last_logon_s;
                wmi_detail:= wmiresult;
            end if;
        end for;
        
        if wmi_detail then
            log.info("Creating WMI Detail");
            name := wmi_detail.Name;
            user_type := wmi_detail.UserType;
            dtl := model.Detail(
                                    key := text.hash("%host.key%/%host.hostname%/%wmi_detail.LastLogon%"),
                             last_logon := last_time_stamp,
                                   name := name,
                                   type := detail_type,
                              user_type := user_type
                              );
            
            model.setRemovalGroup(dtl, "last User Login");
            model.rel.Detail(ElementWithDetail := host, Detail := dtl);
            
        end if;
        
    end body;

end pattern;


pattern SI_OU 1.0
    '''
        Pattern to identify server based of OU group membership in the Microsoft Active Directory
        
        Change History:
        2015-06-26 1.0 WF : Fixed the orgunit_rels relationship destroy for ADDM v10.1
       
        Supported Platforms:
        Windows
        
    '''

    overview
        tags OU;
    end overview;
    
    constants
        // This is the list of OU groups to search for. Must be entered exactly as to be discovered (case sensitive).
        searchOUs := [ 'Member Servers', 'Application Servers', 'Exchange Servers',	'File Servers', 'Infrastructure Servers', 'Print Servers', 'Web Servers', 'SQL Servers', 'Database Servers', 'Management Servers', 'Reporting Servers' ];

	end constants;	
	
    triggers        
        // Trigger this patterno n the discovery of any Windows host
        on drv_host  := Host created, confirmed where host_type = 'Windows Server';
    end triggers;

    body
        // Temporary type name, this will be replaced
        type := 'Organization Unit - New Pattern Test';
        
        // Get host details
        host := model.host(drv_host);
        hostname := host.hostname;
		
		orgunit_rels:= host.#OwnedItem:Ownership;
        
        // Legacy 8.3 function
        // orgunit_rels := host.#OwnedItem:Ownership:Owner;
		
		// Destroy all the OrganisationUnit relationships, then rediscover them
        for orgunit_rel in orgunit_rels do
            owner:= search(in orgunit_rel step out Owner:OrganisationalUnit);
            if owner then
                model.destroy(orgunit_rel);
            end if;
        end for;
		
        for ou in searchOUs do;
            getRKey := discovery.registryKey(host, raw "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine\Distinguished-Name");
            if getRKey and getRKey.value then
                if "%getRKey.value%" matches expand(regex "OU=%ou%", ou) then                             
                            
                            orgunit_name := ou;
                            already_linked := false;
                            // orgunit_rels := host.#OwnedItem:Ownership:Owner;

                            for orgunit_rel in orgunit_rels do
                                owner:= search(in orgunit_rel step out Owner:OrganisationalUnit);
                              //if orgunit_rel.#:OrganisationalUnit.name = orgunit_name then
                              if owner.name = orgunit_name then
                                  already_linked := true;
                              end if;
                            end for;
                             
                            if not already_linked then
                               // Find the Organisational Unit node(s) for the OrgUnit
                               org_unit := search(OrganisationalUnit where name = %orgunit_name%);
                             
                               // Create relationship
							   model.rel.Ownership(OwnedItem := host, Owner := org_unit);
                            end if;                      

                end if;                
            end if;        
        end for;        
    end body;    
end pattern;  

// The MIT License (MIT)

// Copyright Wes Moskal-Fitzpatrick 2013-2021

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.