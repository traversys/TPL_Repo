tpl 1.6 module traversys_Alchemy;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Alchemy';
end metadata;


pattern Traversys_SI_Alchemy_License_Manager 1.0
    '''
    Alchemy License Manager.
    
    Change History:
    2015-09-30 | 1.0 | WF | Created
    
    '''

    metadata
        publishers      := 'OpenText';
        products        := 'Alchemy License Manager';
        urls            := 'https://captaris.com/';
        categories      := 'Software License Management';
        known_versions  := '8.2';
    end metadata;

    overview
        tags alchemy, license, custom, traversys;
    end overview;
    
    constants
        type := "Alchemy License Manager";
    end constants;

    triggers
        on process := DiscoveredProcess created, confirmed where cmd matches windows_cmd 'crypserv';
    end triggers;

    body

        host := related.host(process);
        name := "%type% on %host.name%";
        key  := text.hash("%type%/%host.key%");
        
        si:= model.SoftwareInstance(
                                    key:=key,
                                    name:=name,
                                    type:=type
                                    _traversys:= true
                                    );
        
    end body;

end pattern;

identify Alchemy 1.0
    tags Alchemy;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'crypserv' -> 'traversys', 'Alchemy License Manager';
end identify;
