tpl 1.6 module traversys_AdditionalHostInfo;

metadata
   origin:="Traversys";
   tree_path:='Traversys', 'Extended', 'Additional Host Info';
end metadata;

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

// The MIT License (MIT)

// Copyright Wes Moskal-Fitzpatrick 2013

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