// Copyright 2014 Traversys Limited

tpl 1.9 module traversys_Cirrus_DartHR;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Cirrus', 'Dart HR';
end metadata;

definitions tsys_cirrus 1.0
	""" 
        Custom Functions for Cirrus.

        Author: Wes Moskal-Fitzpatrick

        Change History:
        2014-07-14 | 1.0 | WMF | Created
    """

    define process2si(process, type) -> si
        """
            Generate an SI based on DiscoveredProcess.
        """

        host:= related.host(process);

        version:= none;
        pr_version:= none;
        
        name := "%type% on %host.name%";
        key := text.hash("%type%/%host.key%");

        si:= model.SoftwareInstance(
                                    key:= key,
                                    type:= type,
                                    name:= name,
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "%type%_sis");
        
        return si;

    end define;
	
	define associates(si, process)
		"""
            Associate Cirrus processes.
        """

		ps:= discovery.allProcesses(process);

		if si.type matches regex "^Cirrus" then
			rp:= search(in ps where cmd matches "\b(?i)bf(Business|Dict|Security|Sys)CacheHost\.exe$"
					                or cmd matches "\b(?i)bfSynchro\.exe$"
					                    or cmd matches "\bb(?i)impuser\.exe$");
			inference.associate(si, rp);
		end if;
		
	end define;
	
end definitions;

pattern Traversys_SI_Dart_HR 1.0
    '''
        Author: Wes Fitzpatrick, Traversys Limited

        Dart HR Software Client.

        Change History:
        2014-07-14 | 1.0 | WF | Created.

    '''
    metadata
        publishers      := 'Cirrus';
        products        := 'Dart HR';
        urls            := 'https://www.cirrusit.com/hr-product-overview';
        categories      := 'HR Management';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, cirrus, dart, hr;
    end overview;

    constants
        t := 'Cirrus Dart HR Core';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd "HR";
    end triggers;

    body
		
        si:= tsys_cirrus.process2si(p, t);
        tsys_cirrus.associates(si, p);

    end body;

end pattern;


pattern Traversys_SI_Dart_Payroll 1.0
    '''
        Author: Wes Fitzpatrick, Traversys Limited

        Dart HR Payroll Client.

        Change History:
        2014-07-14 | 1.0 | WF | Created.

    '''
    metadata
        publishers      := 'Cirrus';
        products        := 'Dart HR';
        urls            := 'https://www.cirrusit.com/hr-product-overview';
        categories      := 'HR Management';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, cirrus, dart, hr, payroll;
    end overview;

    constants
        t := 'Cirrus Dart HR Payroll';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd "PAYROLL";
    end triggers;

    body
		
        si:= tsys_cirrus.process2si(p, t);
        tsys_cirrus.associates(si, p);

    end body;

end pattern;


pattern Traversys_SI_Dart_Admin 1.0
    '''
        Author: Wes Fitzpatrick, Traversys Limited

        Dart HR Administration Client.

        Change History:
        2014-07-14 | 1.0 | WF | Created.

    '''
    metadata
        publishers      := 'Cirrus';
        products        := 'Dart HR';
        urls            := 'https://www.cirrusit.com/hr-product-overview';
        categories      := 'HR Management';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, cirrus, dart, hr, administration;
    end overview;

    constants
        t := 'Cirrus Dart HR Administration';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches regex "\b(?i)(administrator|ams|administration)\.exe$";
    end triggers;

    body
		
        si:= tsys_cirrus.process2si(p, t);
        tsys_cirrus.associates(si, p);

    end body;

end pattern;


pattern Traversys_SI_Dart_Recruitment 1.0
    '''
        Author: Wes Fitzpatrick, Traversys Limited

        Dart HR Recruitment Client.

        Change History:
        2014-07-14 | 1.0 | WF | Created.

    '''
    metadata
        publishers      := 'Cirrus';
        products        := 'Dart HR';
        urls            := 'https://www.cirrusit.com/hr-product-overview';
        categories      := 'HR Management';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, cirrus, dart, hr, recruitment;
    end overview;

    constants
        t := 'Cirrus Dart HR Recruitment';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd "recruitment";
    end triggers;

    body
		
        si:= tsys_cirrus.process2si(p, t);
        tsys_cirrus.associates(si, p);

    end body;

end pattern;


pattern Traversys_SI_Dart_Training 1.0
    '''
        Author: Wes Fitzpatrick, Traversys Limited

        Dart HR Training Client.

        Change History:
        2014-07-14 | 1.0 | WF | Created.

    '''
    metadata
        publishers      := 'Cirrus';
        products        := 'Dart HR';
        urls            := 'https://www.cirrusit.com/hr-product-overview';
        categories      := 'HR Management';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, cirrus, dart, hr, training;
    end overview;

    constants
        t := 'Cirrus Dart HR Training';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd "training";
    end triggers;

    body
		
        si:= tsys_cirrus.process2si(p, t);
        tsys_cirrus.associates(si, p);

    end body;

end pattern;


pattern Traversys_BAI_Dart_HR 1.0
    '''
        Author: Wes Fitzpatrick, Traversys Limited

        Models Dart HR.

        Change History:
        2014-07-14 | 1.0 | WF | Created.

    '''

    metadata
        publishers      := 'Cirrus';
        products        := 'Dart HR';
        urls            := 'https://www.cirrusit.com/hr-product-overview';
        categories      := 'HR Management';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, cirrus, dart, hr;
    end overview;

    constants
        type := 'Cirrus Dart HR';
    end constants;

    triggers
        on si:= SoftwareInstance created, confirmed where type = "Cirrus Dart HR Core";
    end triggers;

    body
	
		bai:= model.BusinessApplicationInstance(
                                                key:= type,
                                                type:=type,
                                                name:="%type%",
                                                _traversys:= true
                                                );
		model.addContainment(bai, si);
		
		cd:= search(SoftwareInstance where type matches regex "^Cirrus Dart");
		for d in cd do
			model.addContainment(bai, d);
		end for;
		
    end body;

end pattern;

identify DartHR 1.0
	tags DartHR;
	DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd "HR"                                 -> "traversys", "Cirrus Dart HR";
	windows_cmd "training"                           -> "traversys", "Cirrus Dart HR Training";
    windows_cmd "PAYROLL"                            -> "traversys", "Cirrus Dart HR Payroll";
    windows_cmd "recruitment"                        -> "traversys", "Cirrus Dart HR Recruitment";
	windows_cmd "(administrator|ams|administration)" -> "traversys", "Cirrus Dart HR Administration";
end identify;
