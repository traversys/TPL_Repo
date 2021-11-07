tpl 1.9 module traversys_Nastel_Autopilot;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Nastel', 'Navigator';
end metadata;

definitions tsys_nastel 1.0
	""" 
        Custom Functions for Nastel.

        Author: Wes Moskal-Fitzpatrick

        Change History:
        2014-07-14 | 1.0 | WMF | Created
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
                end if;
            end if;
        end if;
        
        if version then
            pr_version:= regex.extract(version, regex "(\d+(?:\.\d+)?)", raw "\1", no_match:= version);
            name:= '%type% %product_version% on %host.name%';
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

pattern Traversys_SI_Nastel_PubSub 1.0
    '''
        Author: Wes Fitzpatrick, Traversys Limited

        Nastel Navigator M6 Publisher/Subscriber.

        Change History:
        2014-07-14 | 1.0 | WF | Created.
		
    '''
    metadata
        publishers      := 'Nastel';
        products        := 'Navigator', 'AutoPilot M6';
        urls            := 'https://docs.google.com/viewer?url=https%3A%2F%2Fwww.nastel.com%2Fwp-content%2Fuploads%2F2020%2F03%2Fnav_classic_install_guide.pdf';
        categories      := 'Application Performance Monitoring';
        known_versions  := '6';
    end metadata;

    overview
        tags custom, traversys, nastel, navigator, autopilot, m6, publish, subscriber;
    end overview;

    constants
        type := 'Nastel Navigator M6-WMQ Publish/Subscriber';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd "nsqpub";
    end triggers;

    body
		
		si:= tsys_nastel.process2si(p, type, [ regex '(?i)wmq' ];);

    end body;

end pattern;


pattern Traversys_SI_Message_Manager 1.0
    '''
        Author: Wes Fitzpatrick, Traversys Limited

        Nastel Navigator M6 Message Server.

        Change History:
        2014-07-14 | 1.0 | WF | Created.
		
    '''
    metadata
        publishers      := 'Nastel';
        products        := 'Navigator', 'AutoPilot M6';
        urls            := 'https://docs.google.com/viewer?url=https%3A%2F%2Fwww.nastel.com%2Fwp-content%2Fuploads%2F2020%2F03%2Fnav_classic_install_guide.pdf';
        categories      := 'Application Performance Monitoring';
        known_versions  := '6';
    end metadata;

    overview
        tags custom, traversys, nastel, navigator, autopilot, m6, messaging;
    end overview;

    constants
        type := 'Nastel Navigator M6-WMQ Message Manager';
    end constants;


    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd "nsqmsg";
		
    end triggers;

    body
		
		si:= tsys_nastel.process2si(p, type, [ regex '(?i)wmq' ];);

    end body;

end pattern;


pattern Traversys_SI_WMQ_Agent 1.0
    '''
        Author: Wes Fitzpatrick, Traversys Limited

        Nastel Navigator M6 WMQ Agent.

        Change History:
        2014-07-14 | 1.0 | WF | Created.
		
    '''
    metadata
        publishers      := 'Nastel';
        products        := 'Navigator', 'AutoPilot M6';
        urls            := 'https://docs.google.com/viewer?url=https%3A%2F%2Fwww.nastel.com%2Fwp-content%2Fuploads%2F2020%2F03%2Fnav_classic_install_guide.pdf';
        categories      := 'Application Performance Monitoring';
        known_versions  := '6';
    end metadata;

    overview
        tags custom, traversys, nastel, navigator, autopilot, m6, wmq;
    end overview;

    constants
        type := 'Nastel Navigator M6-WMQ Agent';
    end constants;


    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd "nsqmq";
		
    end triggers;

    body
		
		si:= tsys_nastel.process2si(p, type, [ regex '(?i)wmq' ];);

    end body;

end pattern;


pattern Traversys_SI_Nastel_Workgroup_Server 1.0
    '''
        Author: Wes Fitzpatrick, Traversys Limited

        Nastel Navigator Workgroup Server.

        Change History:
        2014-07-14 | 1.0 | WF | Created.
		
    '''
    metadata
        publishers      := 'Nastel';
        products        := 'Navigator', 'AutoPilot M6';
        urls            := 'https://docs.google.com/viewer?url=https%3A%2F%2Fwww.nastel.com%2Fwp-content%2Fuploads%2F2020%2F03%2Fnav_classic_install_guide.pdf';
        categories      := 'Application Performance Monitoring';
        known_versions  := '6';
    end metadata;

    overview
        tags custom, traversys, nastel, navigator, autopilot, m6, workgroup;
    end overview;

    constants
        type := 'Nastel Navigator M6-WMQ Workgroup Server';
    end constants;


    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd "nsqmgr";
		
    end triggers;

    body
		
		si:= tsys_nastel.process2si(p, type, [ regex '(?i)wmq' ];);

    end body;

end pattern;


pattern Traversys_SI_Nastel_Connection_Manager 1.0
    '''
        Author: Wes Fitzpatrick, Traversys Limited

        Nastel Navigator Connection Manager.

        Change History:
        2014-07-14 | 1.0 | WF | Created.
		
    '''
    metadata
        publishers      := 'Nastel';
        products        := 'Navigator', 'AutoPilot M6';
        urls            := 'https://docs.google.com/viewer?url=https%3A%2F%2Fwww.nastel.com%2Fwp-content%2Fuploads%2F2020%2F03%2Fnav_classic_install_guide.pdf';
        categories      := 'Application Performance Monitoring';
        known_versions  := '6';
    end metadata;

    overview
        tags custom, traversys, nastel, navigator, autopilot, m6, connection, manager;
    end overview;

    constants
        type := 'Nastel Navigator M6-WMQ Connection Manager';
    end constants;


    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd "nsqcm";
		
    end triggers;

    body
		
		si:= tsys_nastel.process2si(p, type, [ regex '(?i)wmq' ];);

    end body;

end pattern;


pattern Traversys_SI_Nastel_Log_Adapter 1.0
    '''
        Author: Wes Fitzpatrick, Traversys Limited

        Nastel Navigator M6-WMQ Log Adapter.

        Change History:
        2014-07-14 | 1.0 | WF | Created.
		
    '''
    metadata
        publishers      := 'Nastel';
        products        := 'Navigator', 'AutoPilot M6';
        urls            := 'https://docs.google.com/viewer?url=https%3A%2F%2Fwww.nastel.com%2Fwp-content%2Fuploads%2F2020%2F03%2Fnav_classic_install_guide.pdf';
        categories      := 'Application Performance Monitoring';
        known_versions  := '6';
    end metadata;

    overview
        tags custom, traversys, nastel, navigator, autopilot, m6, logging, adapter;
    end overview;

    constants
        type := 'Nastel Navigator M6-WMQ Log Adapter';
    end constants;


    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd "nsqadp";
		
    end triggers;

    body
		
		si:= tsys_nastel.process2si(p, type, [ regex '(?i)wmq' ];);

    end body;

end pattern;


pattern Traversys_SI_Nastel_Event_Adapter 1.0
    '''
        Author: Wes Fitzpatrick, Traversys Limited

        Nastel Navigator M6-WMQ Event Adapter.

        Change History:
        2014-07-14 | 1.0 | WF | Created.
		
    '''
    metadata
        publishers      := 'Nastel';
        products        := 'Navigator', 'AutoPilot M6';
        urls            := 'https://docs.google.com/viewer?url=https%3A%2F%2Fwww.nastel.com%2Fwp-content%2Fuploads%2F2020%2F03%2Fnav_classic_install_guide.pdf';
        categories      := 'Application Performance Monitoring';
        known_versions  := '6';
    end metadata;

    overview
        tags custom, traversys, nastel, navigator, autopilot, m6, logging, adapter;
    end overview;

    constants
        type := 'Nastel Navigator M6-WMQ Event Adapter';
    end constants;


    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd "mqevent";
		
    end triggers;

    body
		
		si:= tsys_nastel.process2si(p, type, [ regex '(?i)wmq' ];);

    end body;

end pattern;


pattern Traversys_BAI_Nastel_Navigator 1.0
    '''
        Author: Wes Fitzpatrick, Traversys Limited

        Will model the Nastel Navigator Stack.

        Change History:
        2014-07-14 | 1.0 | WF | Created.
		
    '''

    metadata
        publishers      := 'Nastel';
        products        := 'Navigator', 'AutoPilot M6';
        urls            := 'https://docs.google.com/viewer?url=https%3A%2F%2Fwww.nastel.com%2Fwp-content%2Fuploads%2F2020%2F03%2Fnav_classic_install_guide.pdf';
        categories      := 'Application Performance Monitoring';
        known_versions  := '6';
    end metadata;

    overview
        tags custom, traversys, nastel, navigator;
    end overview;

    constants
        type := 'Nastel Navigator';
    end constants;

    triggers
        on si:= SoftwareInstance created, confirmed where type = "Nastel Navigator M6-WMQ Workgroup Server";
    end triggers;

    body
	
		bai:= model.BusinessApplicationInstance(
                                                key:= "%type%",
                                                type:=type,
                                                name:="%type%"
                                                _traversys:=true
                                                );
		model.addContainment(bai, si);
		
		wmqs:= search(SoftwareInstance where type matches regex "^Nastel Navigator");
		for wmq in wmqs do
			model.addContainment(bai, wmq);
		end for;
		
    end body;

end pattern;


identify Nastel 1.0
	tags Nastel;
	DiscoveredProcess cmd -> set_by, simple_identity;
	windows_cmd "mqevent" -> "traversys", "Nastel Navigator M6-WMQ Event Adapter";
	windows_cmd "nsqadp"  -> "traversys", "Nastel Navigator M6-WMQ Log Adapter";
	windows_cmd "nsqcm"   -> "traversys", "Nastel Navigator M6-WMQ Connection Manager";
	windows_cmd "nsqmgr"  -> "traversys", "Nastel Navigator M6-WMQ Workgroup Server";
	windows_cmd "nsqmq"   -> "traversys", "Nastel Navigator M6-WMQ Agent";
	windows_cmd "nsqmsg"  -> "traversys", "Nastel Navigator M6-WMQ Message Server";
	windows_cmd "nsqpub"  -> "traversys", "Nastel Navigator M6-WMQ Publish/Subscriber";
end identify;