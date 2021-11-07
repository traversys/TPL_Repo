tpl 1.9 module traversys_OrgPlus;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Insperity', 'OrgPlus';
end metadata;

pattern Traversys_SI_Insperity_OrgPlus 1.0
    '''
    Insperity OrgPlus Service.
    
    Change History:
    2015-09-24 | 1.0 | WF | Created.
    
    '''

    metadata
        publishers      := 'Insperity';
        products        := 'OrgPlus';
        urls            := 'https://www.orgplus.com/';
        categories      := 'Organisational Charts';
        known_versions  := '0';
    end metadata;
	
	overview 
		tags orgplus, insperity, custom, traversys;
	end overview;
    
    constants
        type:= "Insperity OrgPlus";
	end constants;
	
	triggers
		on process:= DiscoveredProcess where cmd matches windows_cmd 'OPEService';
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

identify OrgPlus 1.0
    tags OrgPlus;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'OPEService' -> 'traversys', 'Insperity OrgPlus';
end identify;