tpl 1.20 module traversys_DiscoData;

metadata
   origin:="Traversys";
   tree_path:='Traversys', 'Extended', 'Discovery Data';
end metadata;

definitions print 1.0
    """
        Enhanced logging functions.

        Author: Wes Moskal-Fitzpatrick

        Change History:
        2022-04-27 | 1.0 | WMF | Created

    """

    define info(active, message)
        """Enhanced info."""
        if active then
            log.info(message);
        end if;
    end define;
    
    define debug(active, message)
        """Enhanced debug."""
        if active then
            log.debug(message);
        end if;
    end define;

    define critical(active, message)
        """Enhanced critical."""
        if active then
            log.critical(message);
        end if;
    end define;

    define warn(active, message)
        """Enhanced warn."""
        if active then
            log.warn(message);
        end if;
    end define;

    define error(active, message)
        """Enhanced error."""
        if active then
            log.error(message);
        end if;
    end define;

    define attribute(active, message, attribute)
        """Log an attribute in debug."""
        if active then
            log.debug("%message% = %attribute%");
        end if;
    end define;

    define data_type(active, message, attribute)
        """Log an attribute in debug."""
        if active then
            dt:= datatype(attribute);
            log.debug("%message% = %dt%");
        end if;
    end define;

    define list_size(active, message, _list_)
        """Get size of a list."""
        if active then
            sz:= size(_list_);
            log.debug("%message% = %sz%");
        end if;
    end define;

end definitions;

definitions node 1.0
    """
        Enhanced node functions.

        Author: Wes Moskal-Fitzpatrick

        Change History:
        2022-04-28 | 1.0 | WMF | Created

    """

    define addAttribute(node, attribute, value, display := false)
        """
            Add an attribute to a node and set display options.
        """
        if value then
            node[attribute]:= value;
            if display then
                model.addDisplayAttribute(node, attribute);
            end if;
        else
            node[attribute]:= void;
            model.removeDisplayAttribute(node, attribute);
        end if;
    end define;

    define removeAttributes(node, attributes)
        """
            Remove attributes.
        """
        for attribute in attributes do
            node[attribute]:= void;
            model.removeDisplayAttribute(node, attribute);
        end for;
    end define;

end definitions;

pattern traversys_discoData 1.0

    '''
    Author: Wes Moskal-Fitzpatrick

    Description:
    Get additional data about the state of the Discovery instance.

    Change History:
    2022-04-27 | 1.0 | WMF | Created.

    '''

    overview 
        tags traversys, custom;
    end overview;

    constants
        tw_path:= "/usr/tideway/bin";
    end constants;
    
    triggers 
        on disco := SoftwareInstance created, confirmed where type = "BMC Discovery";
    end triggers;

    body

        host            := related.host(disco);
        not_ok_results  := table();
        tku_levels      := table();
        cmdb_connections:= table();

        // Baseline
        baseline:= discovery.runCommand(host, "%tw_path%/tw_baseline --no-highlight");
        if baseline and baseline.result then
            highest:= regex.extract(baseline.result,"Highest severity failure was (.*)",raw "\1",no_match:= none);
            node.addAttribute(disco, "baseline_highest", highest, true);
            not_ok:= regex.extractAll(baseline.result, "(.*: (CRITICAL|MAJOR|MINOR|INFO).*)");
            if size(not_ok) > 0 then
                for result in not_ok do
                    not_ok_results[result[0]]:= result[1];
                end for;
                print.data_type(false,"Results",not_ok_results);
                node.addAttribute(disco, "baseline_warnings", not_ok_results, true);
            end if;
        else
            node.removeAttributes(disco, [ "baseline_highest", "baseline_warnings" ]);
        end if;

        // TKU Level - Local Only
        appliance_name:= system.getOption("APPLIANCE_NAME");
        hostname:= discovery.runCommand(host, "hostname");
        hostn:= regex.extract(hostname.result, "(\S+)", raw "\1");
        print.attribute(true,"Hostname",hostn);
        if host.hostname = hostn then
            print.attribute(true,"Appliance Name",appliance_name);
            if disco.appliance_name = appliance_name then
                tkus:= search(KnowledgeUpload where origin = "TKU" and modified = 0);
                if size(tkus) > 0 then
                    tku_levels['TKU']:= "Not Found!";
                    tku_levels['EDP']:= "Not Found!";
                    tku_levels['Storage']:= "Not Found!";
                    for tku in tkus do
                        if tku.package = "Technology Knowledge Update" then
                            tku_levels['TKU']:= tku.name;
                        end if;
                        if tku.package = "Extended Data Pack" then
                            tku_levels['EDP']:= tku.name;
                        end if;
                        if tku.package = "Technology Knowledge Update - Storage" then
                            tku_levels['Storage']:= tku.name;
                        end if;
                        if tku.package = "Technology Knowledge Update - ServiceNowSync" then
                            tku_levels['ServiceNow']:= tku.name;
                        end if;
                    end for;
                    node.addAttribute(disco, "TKU_levels", tku_levels, true);
                end if;
            else
                node.removeAttributes(disco, [ "TKU_levels" ]);
            end if;
        else
            node.removeAttributes(disco, [ "TKU_levels" ]);
            // -- API

        end if;

        // Config Dump
        config_dump:= discovery.runCommand(host, "%tw_path%/tw_config_dump");

        if config_dump and config_dump.result then
            config_xml:= xpath.openDocument(regex.extract(config_dump.result, regex '(?is)(<\?xml.*</config>)', raw '\1'));

            // CMDB Sync
            syncs := xpath.evaluate(config_xml, '/config/cmdbsync/cmdb/name');
            if syncs then
                for name in syncs do
                    cmdbs := xpath.evaluate(config_xml, '/config/cmdbsync/cmdb[name="%name%"]/host/text()');
                    ports := xpath.evaluate(config_xml, '/config/cmdbsync/cmdb[name="%name%"]/port/text()');
                    if cmdbs then
                        cmdb:= cmdbs[0];
                        port:= ports[0];
                        connection:= "%cmdb%:%port%";
                    else
                        port:= ports[0];
                        connection:= "%name%:%port%";
                    end if;
                    cmdb_connections[name]:= connection;
                end for;
                node.addAttribute(disco, "CMDB_connections", cmdb_connections, true);
            else
                node.removeAttributes(disco, [ "CMDB_connections" ]);
            end if;
        else
            node.removeAttributes(disco, [ "CMDB_connections" ]);
        end if;

        // Vault Status
        // -- API

        // Licensing
        // -- API

        // NTP Status
        ntp_stat:= discovery.runCommand(host, 'command -v timedatectl &> /dev/null && timedatectl status | grep "NTP" || ntpstat');
        timezone:= discovery.runCommand(host, 'command -v timedatectl &> /dev/null && timedatectl status | grep "Time zone" || cat /etc/sysconfig/clock && date +%Z');
        if ntp_stat and ntp_stat.result then
            ntp_enabled:= regex.extract(ntp_stat.result,"NTP enabled: (\w+)",raw "\1",no_match:= none);
            ntp_synced:= regex.extract(ntp_stat.result,"NTP synchronized: (\w+)",raw "\1",no_match:= none);
            node.addAttribute(disco, "NTP_enabled", ntp_enabled, true);
            node.addAttribute(disco, "NTP_synchronised", ntp_synced, true);
        else
            node.removeAttributes(disco, [ "NTP_enabled", "NTP_synchronised" ]);
        end if;
        if timezone and timezone.result then
            time_zone:= regex.extract(timezone.result,"Time zone: (.*)",raw "\1",no_match:= none);
            node.addAttribute(disco, "timezone", time_zone, true);
        else
            node.removeAttributes(disco, [ "timezone" ]);
        end if;

        // Core Dumps
        cores:= discovery.runCommand(host, 'command -v tw_check_cores &> /dev/null && tw_check_cores || ls -l /usr/tideway/cores');
        if cores and cores.result then
            result:= regex.extract(cores.result, regex "(\w.*)", raw "\1", no_match:= cores.result); // strip newline chars
            node.addAttribute(disco, "core_dumps", result, true);
        else
            node.removeAttributes(disco, [ "core_dumps" ]);
        end if;

        // LDAP config
        ldap:= discovery.runCommand(host, '%tw_path%/tw_secopts | grep LDAP_ENABLED');
        if ldap and ldap.result then
            result:= regex.extract(ldap.result, regex "(\w.*)", raw "\1", no_match:= ldap.result); // strip newline chars
            node.addAttribute(disco, "ldap", result, true);
        else
            node.removeAttributes(disco, [ "ldap" ]);
        end if;
        
        // Syslog
        syslog:= discovery.runCommand(host, 'command -v systemctl && systemctl is-active rsyslog');
        if syslog and syslog.result then
            result:= regex.extract(syslog.result, regex "systemctl\s+(\w+)", raw "\1", no_match:= syslog.result); // strip newline chars
            node.addAttribute(disco, "syslog", result, true);
        else
            node.removeAttributes(disco, [ "syslog" ]);
        end if;

        // Cluster Health
        cluster:= discovery.runCommand(host, '%tw_path%/tw_cluster_control --show-members');
        if cluster and cluster.result then
            members:= regex.extract(cluster.result, regex "Number of Members : (\d+)", raw "\1");
            membs:= text.toNumber(members);
            if membs > 0 then
                node.addAttribute(disco, "cluster_size", membs, true);
                faults:= regex.extract(cluster.result, regex "Fault Tolerance : (.*)", raw "\1");
                node.addAttribute(disco, "fault_tolerance", faults, true);
            end if;
        else
            node.removeAttributes(disco, [ "cluster_size", "fault_tolerance" ]);
        end if;

        // UI Errors

        // Depecrecated Taxonomy

        // VMWare tools

        // Non-default options

        // Config Dump

        // Crontab

        // List of Users

        // Consolidation

        // Outposts

        // Discovery Status

        // SSL Config

        // DNS settings

        // Compaction

        // Uname info

        // Version Info

    end body;

end pattern;

// The MIT License (MIT)

// Copyright Wes Moskal-Fitzpatrick 2013-2022

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