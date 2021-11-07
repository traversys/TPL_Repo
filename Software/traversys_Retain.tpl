tpl 1.9 module traversys_OrgPlus;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Micro Focus', 'Retain Unified Archiving';
end metadata;

pattern Traversys_SI_RetainServer 1.0
    '''
        Micro Focus Retain.
        
        Change History:
        2015-10-02 | 1.0 | WF | Created.
    
    '''

    metadata
        publishers      := 'Micro Focus';
        products        := 'Retain Unified Archiving';
        urls            := 'https://www.microfocus.com/en-us/products/retain-unified-archiving/overview';
        categories      := 'Archival Service';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, retain, archiving, microfocus, traversys;
    end overview;
    
    constants
        type:= "Micro Focus Retain";
    end constants;

    triggers
        on process:= DiscoveredProcess where cmd matches windows_cmd 'RetainServer';
    end triggers;

    body
        
        host:= related.host(process);

        name:= "%type% on %host.name%";
        key := text.hash("%type%/%host.key%");
        
        si  := model.SoftwareInstance(
                                      key:= key,
                                      name:= name,
                                      type:= type,
                                      _traversys:= true
                                      );
        model.setRemovalGroup(si, "%type%_sis");
        
    end body;

end pattern;

identify Retain 1.0
    tags Retain;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'RetainServer' -> 'traversys', 'Micro Focus Retain';
end identify;