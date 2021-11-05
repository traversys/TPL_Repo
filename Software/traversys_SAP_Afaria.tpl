tpl 1.9 module traversys_SAP_Afaria;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'SAP Afaria';
end metadata;

pattern Traversys_SI_MBusiness 1.0
    '''
		Traversys M-Business Server SI
		
		Change History:
		2015-02-10 | 1.0 | WF | Created.

    '''

	metadata
        publishers      := 'SAP', 'Sybase';
        products        := 'Afaria', 'M-Business Anywhere';
        urls            := 'https://help.sap.com/viewer/product/SAP_AFARIA/7.0.33/en-US';
        categories      := 'Mobile Device Management';
        known_versions  := '6.6', '7.0';
    end metadata;
	
	overview 
		tags mbusiness, sybase, afaria, sap, custom, traversys;
	end overview;

	constants
        type:= "SAP Sybase M-Business Anywhere";
    end constants;
	
	triggers
		on process := DiscoveredProcess where cmd matches windows_cmd 'agd'
											or cmd matches windows_cmd 'agsoap';
    end triggers;
	
	body
		
		// Identify Software Instance details
		host := related.host(process);
		
		name := '%type% on %host.name%';
	
		si := model.SoftwareInstance(
										key:= text.hash("%type%/%host.key%"),
										name:= name,
										type:= type,
										_traversys:= true
									);
        model.setRemovalGroup(si, "%type%_sis");
	
	end body;
	
end pattern;

pattern Traversys_SI_Afaria 1.0
    '''
		SAP Afaria.
		
		Change History:
		2015-02-10 | 1.0 | WF | Created.

    '''

	metadata
        publishers      := 'SAP';
        products        := 'Afaria';
        urls            := 'https://help.sap.com/viewer/product/SAP_AFARIA/7.0.33/en-US';
        categories      := 'Mobile Device Management';
        known_versions  := '6.6', '7.0';
    end metadata;
	
	overview 
		tags afaria, sap, custom, traversys;
	end overview;

	constants
        type:= "SAP Afaria";
    end constants;
	
	triggers
		on process := DiscoveredProcess where cmd matches windows_cmd 'IMServer'
											and username matches regex '(?i)afaria';
    end triggers;
	
	body
		
		host := related.host(process);
		
		name := '%type% on %host.name%';
	
		si := model.SoftwareInstance(
										key:= text,hash("%type%/%host.key%"),
										name:= name,
										type:= type,
										_traversys:= true
									);
        model.setRemovalGroup(si, "%type%_sis");
	
	end body;
	
end pattern;

identify Afaria_user 1.0
    tags Afaria;
    DiscoveredProcess username, cmd -> set_by, simple_identity;
    regex '(?i)afaria', windows_cmd 'IMServer' -> 'traversys', 'SAP Afaria';
end identify;

identify Afaria 1.0
    tags Afaria;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'agd' -> 'traversys', 'SAP Sybase M-Business Anywhere';
	windows_cmd 'agsoap' -> 'traversys', 'SAP Sybase M-Business Anywhere';
end identify;