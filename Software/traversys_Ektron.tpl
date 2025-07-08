tpl 1.9 module traversys_ArcIMS;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Optimizely', 'Ektron CMS';
end metadata;

pattern Traversys_SI_EktronCMS 1.0
    '''
        Ektron CMS.
        
        Change History:
        2015-05-01 | 1.0 | WF | Created.

    '''

    metadata
        publishers      := 'Optimizely';
        products        := 'Ektron CMS';
        urls            := 'https://www.optimizely.com/ektron-cms/';
        categories      := 'Content Management System';
        known_versions  := '0';
    end metadata;

    overview
        tags optimizely, ektron, custom, traversys;
    end overview;
    
    constants
        type:= 'Optimizely Ektron CMS';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd "Ektron\.ASM\.EktronServices";
    end triggers;

    body

        host:= related.host(p);
        name:= '%type% on %host.name%';
        key := text.hash("%type%/%host.key%");

        si:= model.SoftwareInstance(
                                    key := key,
                                    name:= name,
                                    type:= type,
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "%type%_sis");
		
    end body;

end pattern;

identify Ektron 1.0
    tags Ektron;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'Ektron\.ASM\.EktronServices' -> 'traversys', 'Optimizely Ektron CMS';end identify;
