// Copyright 2014 Traversys Limited

tpl 1.9 module traversys_SkyIQ;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Sky', 'Sky IQ';
end metadata;

definitions tsys_skyiq 1.0
	""" 
        Custom Functions for Sky IQ.

        Author: Wes Moskal-Fitzpatrick

        Change History:
        2014-07-17 | 1.0 | WMF | Created
    """

    define process2si(process, type, pck_rx) -> si
        """
            Generate an SI based on DiscoveredProcess.
        """

        host:= related.host(process);

        version:= none;
        pr_version:= none;
        
        name := "%type% on %host.name%";
        key := text.hash("%type%/%host.key%");

        packages := model.findPackages(host, pkg_rx);
        for pkg in packages do
            if "version" in pkg then
                if pkg.version > v then
                    version:= pkg.version;
                    pr_version:= regex.extract(version, regex "(\d+(?:\.\d+)?)", raw "\1", no_match:= version);
                    name:= '%type% %product_version% on %host.name%';
                end if;
            end if;
        end if;
        
        si:= model.SoftwareInstance(
                                    key:= key,
                                    type:= type,
                                    name:= name,
                                    version:= version,
                                    product_version:= pr_version,
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "%type%_sis");
        
        return si;

    end define;
	
end definitions;


pattern Traversys_SI_SkyIQ_BluePrint 1.1
    '''
        Author: Tim Read, Traversys Limited

        Blueprint Processor Service.

        Change History:
        2014-07-17 | 1.0 | TR | Created.
        2015-05-22 | 1.1 | WF | Refactored and optimised code.

    '''

    metadata
        publishers      := 'BSkyB';
        products        := 'Sky IQ';
        urls            := 'https://www.sky.com/';
        categories      := 'Customer Analytics';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, skyiq, blueprint;
    end overview;

    constants
        t := 'Sky IQ Blueprint Processor Service';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd "Blueprint\.Processor\.Service";
    end triggers;

    body

        si:= tsys_skyiq.process2si(p, t, [ "(?i)Blueprint\.Processor\.Service" ]);
			
	end body;

end pattern;


pattern Traversys_SI_SkyIQ_Elements_Logger 1.1
    '''
        Author: Tim Read, Traversys Limited

        Elements Logger Service.

        Change History:
        2014-07-17 | 1.0 | TR | Created.
        2015-05-22 | 1.1 | WF | Refactored and optimised code.

    '''

    metadata
        publishers      := 'BSkyB';
        products        := 'Sky IQ';
        urls            := 'https://www.sky.com/';
        categories      := 'Customer Analytics';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, skyiq, elements, logging;
    end overview;

    constants
        t := 'Sky IQ Elements Logger';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches regex "\b(?i)elements(\.foundation)?\.logger(\.server)?\.service(\.exe$)";
    end triggers;

    body

        si:= tsys_skyiq.process2si(p, t, [ '(?i)Elements\sLogger' ]);
			
	end body;

end pattern;


pattern Traversys_SI_SkyIQ_Elements_Messenger 1.1
    '''
        Author: Tim Read, Traversys Limited

        Elements Messenger Service.

        Change History:
        2014-07-17 | 1.0 | TR | Created.
        2015-05-22 | 1.1 | WF | Refactored and optimised code.

    '''

    metadata
        publishers      := 'BSkyB';
        products        := 'Sky IQ';
        urls            := 'https://www.sky.com/';
        categories      := 'Customer Analytics';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, skyiq, elements, messaging;
    end overview;

    constants
        t := 'Sky IQ Elements Messenger Service';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches regex "\b(?i)elements(\.foundation)?\.messenger(\.server)?\.service(\.exe$)";
    end triggers;

    body

        si:= tsys_skyiq.process2si(p, t, [ '(?i)Elements' ]);
			
	end body;

end pattern;


pattern Traversys_SI_SkyIQ_Elements_Foundation_Framework 1.1
    '''
        Author: Tim Read, Traversys Limited

        Elements Foundation Framework.

        Change History:
        2014-07-17 | 1.0 | TR | Created.
        2015-05-22 | 1.1 | WF | Refactored and optimised code.

    '''

    metadata
        publishers      := 'BSkyB';
        products        := 'Sky IQ';
        urls            := 'https://www.sky.com/';
        categories      := 'Customer Analytics';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, skyiq, elements, foundation, framework;
    end overview;

    constants
        t := 'Sky IQ Elements Foundation Framework';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches regex "\b(?i)Elements\.Foundation\.Framework\.Client\.UI\.Forms(\.exe)?$";
    end triggers;

    body

        si:= tsys_skyiq.process2si(p, t, [ '(?i)Elements' ]);
			
	end body;

end pattern;


pattern Traversys_SI_SkyIQ_Identify_AddressCleanse 1.1
    '''
        Author: Tim Read, Traversys Limited

        Sky IQ Identify AddressCleanse.

        Change History:
        2014-07-17 | 1.0 | TR | Created.
        2015-05-22 | 1.1 | WF | Refactored and optimised code.

    '''

    metadata
        publishers      := 'BSkyB';
        products        := 'Sky IQ';
        urls            := 'https://www.sky.com/';
        categories      := 'Customer Analytics';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, skyiq, elements, identify, addresscleanse;
    end overview;

    constants
        t := 'Sky IQ Identify AddressCleanse';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches regex "\b(?i)(identify\.)?addresscleanse(service)?(\.exe)$";
    end triggers;

    body

        si:= tsys_skyiq.process2si(p, t, [ '(?i)Address\sCleanse' ]);
			
	end body;

end pattern;


pattern Traversys_SI_SkyIQ_Identify_Control_Service 1.1
    '''
        Author: Tim Read, Traversys Limited

        Sky IQ Identify Control Service.

        Change History:
        2014-07-17 | 1.0 | TR | Created.
        2015-05-22 | 1.1 | WF | Refactored and optimised code.

    '''

    metadata
        publishers      := 'BSkyB';
        products        := 'Sky IQ';
        urls            := 'https://www.sky.com/';
        categories      := 'Customer Analytics';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, skyiq, elements, identify, control;
    end overview;

    constants
        t := 'Sky IQ Identify Control';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd "Identify\.ControlService";
    end triggers;

    body

        si:= tsys_skyiq.process2si(p, t, [ '(?i)Identify\sControl' ]);
			
	end body;

end pattern;


pattern Traversys_SI_SkyIQ_Identify_Delivery_Point_Service 1.1
    '''
        Author: Tim Read, Traversys Limited

        Sky IQ Identify Delivery Point Service.

        Change History:
        2014-07-17 | 1.0 | TR | Created.
        2015-05-22 | 1.1 | WF | Refactored and optimised code.

    '''

    metadata
        publishers      := 'BSkyB';
        products        := 'Sky IQ';
        urls            := 'https://www.sky.com/';
        categories      := 'Customer Analytics';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, skyiq, elements, identify, delivery, point;
    end overview;

    constants
        t := 'Sky IQ Identify Delivery Point';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd "Identify\.DeliveryPointService";
    end triggers;

    body

        si:= tsys_skyiq.process2si(p, t, [ '(?i)Identify\sDelivery\s\Point\s(Web)?Service' ]);
			
	end body;

end pattern;


pattern Traversys_SI_SkyIQ_Identify_Person_Key_Service 1.1
    '''
        Author: Tim Read, Traversys Limited

        Sky IQ Identify Delivery Point Service.

        Change History:
        2014-07-17 | 1.0 | TR | Created.
        2015-05-22 | 1.1 | WF | Refactored and optimised code.

    '''

    metadata
        publishers      := 'BSkyB';
        products        := 'Sky IQ';
        urls            := 'https://www.sky.com/';
        categories      := 'Customer Analytics';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, skyiq, elements, identify, person, key;
    end overview;

    constants
        t := 'Sky IQ Identify Person Key Service';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd "Identify\.PersonKeyService";
    end triggers;

    body

        si:= tsys_skyiq.process2si(p, t, [ '(?i)Identify\sPerson\s\Key\s' ]);
			
	end body;

end pattern;


pattern Traversys_BAI_SkyIQ 1.0
    '''
        Author: Tim Read, Traversys Limited

        Models Sky IQ Stack.

        Change History:
        2014-07-17 | 1.0 | TR | Created.
        2015-05-22 | 1.1 | WF | Refactored and optimised code.

    '''

    metadata
        publishers      := 'BSkyB';
        products        := 'Sky IQ';
        urls            := 'https://www.sky.com/';
        categories      := 'Customer Analytics';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, skyiq;
    end overview;

    constants
        type := 'Sky IQ';
    end constants;

    triggers
        on si:= SoftwareInstance created, confirmed where type = "Sky IQ Blueprint Processor Service";
    end triggers;

    body


		bai:= model.BusinessApplicationInstance(
                                                key:= "%type%",
                                                type:=type,
                                                name:="%type%"
                                                _traversys:=true
                                                );
		model.addContainment(bai, si);
		
		siqs:= search(SoftwareInstance where type matches regex "Sky IQ (Elements|Identify)");
		for siq in siqs do
			model.addContainment(bai, siq);
		end for;
		
		end body;

end pattern;

identify SkyIQ 1.0
	tags SkyIQ;
	DiscoveredProcess cmd -> set_by, simple_identity;
	windows_cmd "Blueprint\.Processor\.Service"                      -> "traversys", "Sky IQ Blueprint Processor Service";
    windows_cmd "Elements\.Foundation\.Framework\.Client\.UI\.Forms" -> "traversys", "Sky IQ Elements Foundation Framework";
    windows_cmd "Identify\.ControlService"                           -> "traversys", "Sky IQ Identify Control Service";
    windows_cmd "Identify\.DeliveryPointService"                     -> "traversys", "Sky IQ Identify Delivery Point Service";
	windows_cmd "Identify\.PersonKeyService"                         -> "traversys", "Sky IQ Identify Person Key Service";
	regex "\b(?i)elements(\.foundation)?\.logger(\.server)?\.service(\.exe)?$"    -> "traversys", "Sky IQ Elements Logger Service";
	regex "\b(?i)elements(\.foundation)?\.messenger(\.server)?\.service(\.exe)?$" -> "traversys", "Sky IQ Elements Messenger Service";
	regex "\b(?i)(identify\.)?addresscleanse(service)?(\.exe)?$"                  -> "traversys", "Sky IQ Identify AddressCleanse Service";	
end identify;		