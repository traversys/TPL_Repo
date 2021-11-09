tpl 1.9 module traversys_RIB_Lizenzmanagement;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'RIB Software AG', 'Lizenzmanagement';
end metadata;


pattern Traversys_SI_RIBLizenzmanagement 1.0
    '''
    RIB Lizenzmanagement
    
    Change History:
    2015-09-17 | 1.0 | WF | Created.
    '''

    metadata
        publishers      := 'RIB Software AG';
        products        := 'Lizenzmanagement';
        urls            := 'https://www.rib-software.com/en/home';
        categories      := 'License Management';
        known_versions  := '11.41 UPDATE 2';
    end metadata;

    overview
        tags rib, custom, traversys, lizenzmanagement;
    end overview;
    
    constants
        type:= "RIB Lizenzmanagement";
    end constants;

    triggers
        on process:= DiscoveredProcess where cmd matches windows_cmd 'NetCounterLM' 
                                    or cmd matches windows_cmd 'RIB\.License\.Server';
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

identify Lizenzmanagement 1.0
    tags Lizenzmanagement;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'NetCounterLM'          -> 'traversys', 'RIB Lizenzmanagement';
    windows_cmd 'RIB\.License\.Server'  -> 'traversys', 'RIB Lizenzmanagement';
end identify;