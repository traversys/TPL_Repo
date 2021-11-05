tpl 1.9 module traversys_IBM_DOORS;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'IBM', 'Rational DOORS';
end metadata;

pattern Traversys_SI_IBM_DOORS 1.0
    '''
    IBM DOORS.
    
    Change History:
    2015-09-23 | 1.0 | WF | Created.

    '''

    metadata
        products       := 'Rational DOORS';
        urls           := "https://www.ibm.com/docs/en/ermd/9.6.1?topic=overview-rational-doors";
        publishers     := "IBM";
        categories     := 'Dynamic Object-Oriented Requirements System';
        known_versions := '8.1', '9.6.1';
    end metadata;

    overview
        tags ibm, doors, rational, custom, traversys;
    end overview;
    
    constants
        type    := "IBM Rational DOORS";
        wmiNS   := "root\CIMV2";
        wmiQuery:= """SELECT DisplayName, Name, State
                      from Win32_Service
                      where DisplayName like 'DOORS DB Server%'""";
    end constants;

    triggers
        on process:= DiscoveredProcess where cmd matches windows_cmd "doorsd";
    end triggers;

    body

        host:= related.host(process);

        wmi_results:= discovery.wmiQuery(host, wmiQuery, wmiNS);
        
        for result in wmi_results do
            if result.State and result.State = 'Running' then
            
                subname:= type;
            
                instance   := regex.extract(result.Name, regex "DOORS DB Server [0-9.]+ (.*)", raw "\1");
                version    := regex.extract(result.Name, regex "DOORS DB Server (\d+(\.\d+)+)", raw "\1");
                build      := regex.extract(result.DisplayName, regex "DOORS DB Server [0-9.]+ (.*)", raw '\1');
                
                if not version then
                    // Attempt to get from path
                    version := regex.extract(process.cmd, regex "DOORS\\(\d+(\.\d+)+)", raw "\1");
                end if;
                
                if not build then
                    // Attempt to get from args
                    build  := regex.extract(process.args, regex "-q (\d+)", raw '\1');
                end if;
                
                pr_version := regex.extract(version, regex "^(\d+(?:\.\d+)?)", raw '\1', no_match:= version);
                if pr_version then
                    subname:= "%type% %pr_version%";
                end if;
                
                name:= "%subname% on %host.name%";
                key := text.hash("%subname%/%host.key%");
                
                if instance then
                    name:= "%subname% %instance% on %host.name%";
                    key := text.hash("%subname%/%instance%/%host.key%");
                end if;
                
                si:= model.SoftwareInstance(
                                            key:= key,
                                            name:= name,
                                            type:= type,
                                            version:= version,
                                            product_version:= pr_version,
                                            instance:= instance,
                                            build:= build,
                                            _traversys:= true
                                            );
                model.setRemovalGroup(si, "%type%_sis");
                
            end if;

        end for;

    end body;
	
end pattern;

identify DOORS 1.0
    tags DOORS;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'doorsd' -> 'traversys', 'IBM Rational DOORS';
end identify;