tpl 1.9 module traversys_MRI_Qube;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'MRI', 'Qube Property Management';
end metadata;


pattern Traversys_SI_MRI_Qube 1.0
    '''
    MRI Qube Property Management
    
    Change History:
    2015-09-23 | 1.0 | WF | Created.
    '''

    metadata
        publishers      := 'MRI';
        products        := 'Qube Property Management';
        urls            := 'https://www.rib-software.com/en/home';
        categories      := 'Facilities Management';
        known_versions  := '0';
    end metadata;

    overview
        tags qube, mri, custom, traversys;
    end overview;
    
    constants
        type:= "MRI Qube Property Management";
    end constants;

    triggers
     on process:= DiscoveredProcess where cmd matches windows_cmd 'ecs';
    end triggers;

    body

        host:= model.host(process);
		
		name:= '%type% on %host.name%';

        key:= "%name%/%host.key%";
	
        si:= model.SoftwareInstance(
                                    key:= key,
                                    name:= name,
                                    type:= type,
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "%type%_sis");

    end body;

end pattern;

identify Qube 1.0
    tags Qube;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'ecs' -> 'traversys', 'MRI Qube Property Management';end identify;
