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

        // Baseline
        baseline:= discovery.runCommand(host, "%tw_path%/tw_baseline --no-highlight");
        if baseline and baseline.result then
            highest:= regex.extract(baseline.result,"Highest severity failure was (.*)",raw "\1",no_match:= none);
            if highest then
                disco.baseline_highest:= highest;
                model.addDisplayAttribute(disco, "baseline_highest");
            else
                disco.baseline_highest:= void;
                model.removeDisplayAttribute(disco, "baseline_highest");
            end if;
            not_ok:= regex.extractAll(baseline.result, "(.*: (CRITICAL|MAJOR|MINOR|INFO).*)");
            if size(not_ok) > 0 then
                for result in not_ok do
                    not_ok_results[result[0]]:= result[1];
                end for;
                //disco.baseline_warnings:= json.encode(not_ok_results);
                disco.baseline_warnings:= not_ok_results;
                print.data_type(false,"Results",not_ok_results);
                model.addDisplayAttribute(disco, "baseline_warnings");
            else
                disco.baseline_warnings:= void;
                model.removeDisplayAttribute(disco, "baseline_warnings");
            end if;
        else
            disco.baseline_warnings:= void;
            model.removeDisplayAttribute(disco, "baseline_warnings");
            disco.baseline_highest:= void;
            model.removeDisplayAttribute(disco, "baseline_highest");
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
                    disco.TKU_levels:= tku_levels;
                    model.addDisplayAttribute(disco, "TKU_levels");
                else
                    disco.TKU_levels:= void;
                    model.removeDisplayAttribute(disco, "TKU_levels");
                end if;
            else
                disco.TKU_levels:= void;
                model.removeDisplayAttribute(disco, "TKU_levels");
            end if;
        else
            disco.TKU_levels:= void;
            model.removeDisplayAttribute(disco, "TKU_levels");
        end if;

        // CMDB Sync

        // Vault Status

        // Licensing

        // NTP Status

        // Core Dumps

        // LDAP config

        // CLI Users

        // Syslog

        // Cluster Health

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