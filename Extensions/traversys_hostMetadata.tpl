tpl 1.20 module traversys_HostMeta;

metadata
   origin:="Traversys";
   tree_path:='Traversys', 'Extended', 'Host Metadata';
end metadata;


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

    triggers 
        on host := Host created, confirmed;
    end triggers;

    body

        if host.os_type matches 'Linux' then

            // Get resolve.conf
            resolve_conf:= discovery.fileGet(host, "/etc/resolv.conf");

            // Get passwd
            etc_passwd:= discovery.fileGet(host, "/etc/passwd");

            // Get groups
            etc_group:= discovery.fileGet(host, "/etc/group");

            // Get ifconfig
            if_config:= discovery.runCommand(host, "ip a");

            // TCP keepalive
            keepalive_nix := discovery.runCommand(host, 'sysctl net.ipv4.tcp_keepalive_time');
            keepalive_ora := discovery.runCommand(host, '/usr/sbin/ndd -get /dev/tcp tcp_keepalive_interval');

            // Mounted filesystems
            mt := discovery.fileGet(host, '/etc/mtab');

            // Interface details
            interface_name := search(in host traverse DeviceWithInterface:DeviceInterface:InterfaceOfDevice:NetworkInterface);
            if size(interface_name) > 0 then
                for NIC in interface_name do
                    int_cmd := discovery.runCommand(host, "/sbin/ifconfig %NIC.name%");
                end for;
            end if;

            // Domain name
            domain := discovery.runCommand(host, "domainname");

            // SCSI Info
            get_scsi_id:= discovery.runCommand(host, "ls -al /dev/disk/by-id");

            // Block info
            blocklist:= discovery.runCommand(host, "ls -al /sys/block/*/device");

            //open /etc/sysconfig/syslog file
            syslog_file := discovery.fileGet(host, "/etc/syslog.conf");

            last := discovery.runCommand(host, 'last -a -n 20');
            if last and last.result then
                host.last_login := last.result;
            end if;

            // Install date
            if host.os_type matches "AIX" then
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
            host.install_date := raw_date;

            
        elif host.os_class = "Windows" then
        
            // Get ipconfig
            ip_config:= discovery.runCommand(host, "ipconfig /all");

            //Get DNS details
            dns_wmi := discovery.wmiQuery(host, 'SELECT DNSDomain,DNSServerSearchOrder,DNSDomainSuffixSearchOrder FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = TRUE', 'root\CIMV2');

            // Get DiskDrive
            disk_drive:=discovery.wmiQuery(host, 'SELECT * from CIM_DiskDrive', 'root\cimv2');

            // Logical Disk
            logical_disk_run:=discovery.wmiQuery(host, "Select * from CIM_Logicaldisk", 'root\cimv2');

            // DD to DP
            assoc_query:=discovery.wmiQuery(host, "SELECT * from Win32_DiskDriveToDiskPartition", 'root\cimv2');
            
            // LD to DP
            wmi_logical_disks:=discovery.wmiQuery(host, "SELECT * from Win32_LogicalDiskToPartition", 'root\cimv2');

            // HBA Windows Dir
            win_root:=discovery.wmiQuery(host, "SELECT WindowsDirectory from Win32_OperatingSystem", 'root\cimv2');
            
            // Logical Disk
            wmiquery_res := discovery.wmiQuery(host, 'select * from Win32_LogicalDisk', 'root\CIMV2');

            // USB Devices
            usb_results := discovery.wmiQuery(host, "SELECT * FROM Win32_DiskDrive WHERE InterfaceType = 'USB'", "root\CIMV2" );

            // Uninstall list
            uninstall := discovery.registryKey(host, [ 'HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall' ]);

            // Last boot info
            wmi := discovery.wmiQuery(host, 'SELECT InstallDate,LastBootUpTime FROM Win32_OperatingSystem', 'root\CIMV2');
            if wmi then
                host.install_date := wmi[0].InstallDate;
                host.last_boot := wmi[0].LastBootUpTime;
            end if;

            // DNS Search order
            dns := discovery.wmiQuery(host, 'SELECT DNSServerSearchOrder,DNSDomainSuffixSearchOrder,WINSPrimaryServer,WINSSecondaryServer FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled=1', 'root\CIMV2');

            // Bios Info
            bios := discovery.wmiQuery(host, 'SELECT Name,SMBIOSBIOSVersion,Version FROM Win32_BIOS', 'root\CIMV2');

            // Paging file
            paging := discovery.wmiQuery(host, 'SELECT Name,FileSize,InitialSize,MaximumSize FROM Win32_PageFile', 'root\CIMV2');

            // Last patch
            last_patch:= discovery.runCommand(host, "powershell \"Get-HotFix | sort InstalledOn -Descending | select HotFixID, @{Name='Installed'; Expression={'{0:dd MMMM yyyy}' -f [datetime]$_.InstalledOn.Tostring()}} -First 1\"");
            reg_last:= discovery.registryKey(host, raw "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\Results\Install\LastSuccessTime");
        
            if last_patch and last_patch.result then
                host.last_hotfix := regex.extract(last_patch.result, regex "(KB\d+)", raw "\1");
                host.last_hotfix_date := regex.extract(last_patch.result, regex "KB\d+\s+(\d+\s\w+\s\d+)", raw "\1");
            elif reg_last and reg_last.result then
                host.last_hotfix_date := regex.extract(last_patch.result, regex "(\d+-\d+-\d+)", raw "\1");
            end if;

            // Install date
            build:= discovery.runCommand(host, 'systeminfo | find /i "date"');
            if build and build.result then
                raw_date:= regex.extract(build.result, regex "Original Install Date:\s+(.*)", raw "\1", no_match:= build.result);
                host.install_date := raw_date;
            end if;

            // Last login
            wmi_results := discovery.wmiQuery(host, 'select LastLogon, Name, UserType from Win32_NetworkLoginProfile', 'root\CIMV2');
            for wmiresult in wmi_results do
                if "LastLogon" not in wmiresult then
                    log.warn("No LastLogon detail returned from wmi query, skipping...");
                    continue;
                end if;
                // Obtain results and assign attributes to Detail node then relate to trigger Host
                wmiresultll:= wmiresult.LastLogon;
                wmilastlogon:= regex.extract(wmiresultll, regex "(\d+)\.", raw "\1");
                ydmhms:= regex.extractAll(wmilastlogon, regex "^(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})");
                if size(ydmhms) = 0 then
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
                end if;
                if last_logon_s and last_logon_s > last_time_stamp then
                    // Converts date to readable format yyyymmdd
                    last_time_stamp:= last_logon_s;
                end if;
            end for;
            host.last_login:= last_time_stamp;

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