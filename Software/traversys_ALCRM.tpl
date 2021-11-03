tpl 1.6 module traversys_NetworkRail_ALCRM;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Network Rail ALCRM';
end metadata;

pattern Traversys_SI_NRALCRM 1.0
    '''  
        The ALCRM is being used by Network Rail to assess the risk at their
        crossings and is a key part of its level crossing strategy.

        Change History:
        2015-05-06 | 1.0 | WF | Created.

    '''

    metadata
        products := 'All Level Crossing Risk Model';
        urls := 'https://safety.networkrail.co.uk/jargon-buster/alcrm/';
        publishers  := 'Network Rail';
        categories := 'Risk Management Software';
        known_versions := '0';
    end metadata;

    overview
        tags networkrail, alcrm, custom, traversys;
    end overview;

    constants
        type:= "Network Rail ALCRM Webserver";
    end constants;

    triggers
        on proc:= DiscoveredProcess created, confirmed
                      where cmd matches regex '\b(?i)alcrm\b.*/wrapper$';
    end triggers;

    body

        host:= related.host(proc);

        si:= model.SoftwareInstance(
                                    key := text.hash("%type%/%host.key%"),
                                    name:= "%type% on %host.name%",
                                    type:= type,
                                    _traversys:= true
                                    );

    end body;
  
end pattern;

identify ALCRM 1.0
    tags ALCRM;
    DiscoveredProcess cmd -> set_by, simple_identity;
    regex '\b(?i)alcrm\b.*/wrapper$' -> 'traversys', 'Network Rail ARCLM Webserver';
end identify;