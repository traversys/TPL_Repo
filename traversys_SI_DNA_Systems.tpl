tpl 1.6 module traversys_DNASystems;

metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'DNA Systems', 'OpenAdapter';
end metadata;



pattern OpenAdapter 1.0
    '''
    OpenOffice Server

    Change History:
    2013-10-07 | 1.0 | WF | Created.

    '''

    overview
        tags openadapter, dnasystems, custom, traversys;
    end overview;

    metadata
        products := 'DNA Systems', 'OpenAdapter';
        urls := 'https://sourceforge.net/projects/dnasystem/';
        categories := 'Deep Network Monitoring';
        known_versions := '0';
    end metadata;

    constants
        type:= "DNA Systems OpenAdapter";
    end constants;

    triggers
        on process := DiscoveredProcess where cmd matches regex '\bjava$' and
                       args matches regex '^.*org.openadaptor.adaptor.RunAdaptor';
    end triggers;

    body
        
        cmd := process.cmd;
        if "args" in process then
            args := process.args;
            cmd_args := "%cmd% %args%";
        else
            args := "";
            cmd_args := cmd;
        end if;

        host := model.host(process);
        hostname := host.hostname;
        name := "%type% on %hostname%";

        // Create or update SoftwareInstance with named attributes

        si_node := model.SoftwareInstance(
                                            key := text.hash("%type%/%host.name%")
                                            name := name,
                                            type := type,
                                            _traversys:= true
                                        );

        // Obtain all processes
        all_procs := discovery.allProcesses(process);

        // Relate child processes
        inference.associate(si_node, discovery.children(process));


    end body;

end pattern;

identify OpenOffice 1.0
    tags OpenOffice;
    DiscoveredProcess cmd, args -> set_by, simple_identity;
    unix_cmd 'java', regex "^.*org.openadaptor.adaptor.RunAdaptor" -> 'traversys', 'DNA Systems OpenAdapter';
end identify;