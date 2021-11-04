tpl 1.9 module traversys_Correlsense;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Correlsense';
end metadata;

pattern Traversys_SI_Correlsense 1.0
    '''
        Correlsense Server

        Change History:
        2015-05-06 | 1.0 | WF | Created.

    '''

    metadata
        publishers     := "Correlsense";
        products       := 'Correlsense APM';
        urls           := "https://www.correlsense.com/";
        categories     := 'Application Performance Management';
        known_versions := '0';
    end metadata;


    overview 
        tags custom, traversys, correlsense;
    end overview;

    constants
        type:= "Correlsense APM";
    end constants;

    triggers
        on p:= DiscoveredProcess created, confirmed where cmd matches unix_cmd 'java'
                                                      and args matches regex '\b(?i)correlsense\b';

    end triggers;

    body

        host:= related.host(p);

        name:= '%type% on %host.name%';
        key:= text.hash("%type%/%host.key%");

        si:= model.SoftwareInstance(
                                    key := key,
                                    name:= name,
                                    type:= type,
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "%type%_sis");

    end body;
  
end pattern;

identify BroadcomARDS 1.0
    tags Broadcom, ARDS;
    DiscoveredProcess cmd, args -> set_by, simple_identity;
    unix_cmd 'java', regex "\b(?i)correlsense\b" -> 'traversys', 'Correlsense APM';
end identify;