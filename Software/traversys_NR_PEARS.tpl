tpl 1.9 module traversys_PEARS;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Network Rail', 'Paladin Data Extract and Reporting System (PEARS)';
end metadata;

pattern Traversys_SI_PEARS 1.0
    '''  
        Network Rail PAIRS.

        Change History:
        2015-05-14 | 1.0 | WF | Created.

    '''

    metadata
        publishers      := 'Network Rail';
        products        := 'Paladin Data Extract and Reporting System (PEARS)';
        urls            := 'https://safety.networkrail.co.uk/jargon-buster/paladin/';
        categories      := 'Analysis Reporting';
        known_versions  := '0';
    end metadata;
    
    overview
        tags custom, networkrail, traversys, pairs, reporting, extract;
    end overview;
    
    constants
        type:= 'Network Rail PEARS';
    end constants;
    
    triggers
        on process:= DiscoveredProcess where cmd matches regex '\\SchedJobs\\PEARS'
                                          or args matches regex '\\SchedJobs\\PEARS';
    end triggers;
    
    body

        host:= related.host(process);
            
        si  := model.SoftwareInstance(
                                      key:= text.hash("%type%/%host.key%"),
                                      name:= '%type% on %host.name%',
                                      type:= type,
                                      _traversys:= true
                                      );
        model.setRemovalGroup(si, "%type%_sis");
    
  end body;
  
end pattern;

identify PAIRS_cmd 1.0
    tags PAIRS;
    DiscoveredProcess cmd -> set_by, simple_identity;
    regex '\\SchedJobs\\PEARS' -> 'traversys', 'Network Rail PAIRS';
end identify;

identify PAIRS_args 1.0
    tags PAIRS;
    DiscoveredProcess args -> set_by, simple_identity;
    regex '\\SchedJobs\\PEARS' -> 'traversys', 'Network Rail PAIRS';end identify;
