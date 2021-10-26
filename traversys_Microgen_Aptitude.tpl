tpl 1.6 module traversys_SwiftMQ;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Microgen Aptitude';
end metadata;


pattern Traversys_SI_MicrogenAptitude 1.0
    '''
    Microgen.
    
    Change History:
    2013-08-15 1.0 WF : Created.
    
    '''

    metadata
        products := 'Aptitude';
        urls := 'https://www.microgen.com/about-microgen/';
        publishers  := 'Microgen';
        categories := 'Enterprise Application Platform';
        known_versions := '0';
    end metadata;

    overview
        tags microgen, aptitude, custom, traversys;
    end overview;
    
    constants
        type := 'Microgen Aptitude';
    end constants;

    triggers
        on process:= DiscoveredProcess created, confirmed where cmd matches windows_cmd 'apt(exe|srv|bus|eng)';
    end triggers;

    body

		host    := related.host(process);
        name    := "%type% on %host.name%";
        key     := '%type%/%host.key%';

		si      := model.SoftwareInstance(
                                        key:= key,
                                        name:= name,
                                        type:= type,
                                        _traversys:= true
                                        );
		
    end body;

end pattern;

identify MicroGen 1.0
    tags MicroGen;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'apt(exe|srv|bus|eng)' -> 'traversys', 'MicroGen Aptitude';
end identify;