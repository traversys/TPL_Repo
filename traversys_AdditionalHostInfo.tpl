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

pattern sanaware_aix_hbas_luns 1.0

    '''
    Author: Wes Moskal-Fitzpatrick

    Description:
    This pattern is used to build detail nodes of LUNs and HBAs for a host.

    Supported Platforms:
    AIX

    Change History:
    2013-03-01: 1.0 WMF - Clean-up.

    '''

    metadata
        publishers:="Traversys Ltd";
    end metadata;

    overview 
        tags traversys, sanaware, wwpn, target, local, aix, remotewwpn; 
    end overview; 

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