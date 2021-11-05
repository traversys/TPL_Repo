tpl 1.9 module traversys_Fidessa;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'ION Group', 'Fidessa';
end metadata;

definitions tsys_if 1.0
    """
        Custom Functions for Fidessa.

        Author: Wes Moskal-Fitzpatrick

        Change History:
        2013-10-06 | 1.0 | WMF | Created

    """

    define process2si(process, type, instance) -> si
        """
            Generate an SI based on DiscoveredProcess.
        """

        host:= related.host(process);
        all_procs:= discovery.allProcesses(process);
        
        name := "%type% on %host.name%";
        key := text.hash("%type%/%host.name%");

        if instance then
            name := "%type% %instance% on %host.name%";
            key := text.hash("%type%/%instance%/%host.name%");
        end if;

        si:= model.SoftwareInstance(
                                    key:= key,
                                    type:= type,
                                    name:= name,
                                    instance:= instance,
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "sis");
        
        return si;

    end define;

end definitions;

pattern Traversys_SI_FidessaInfra 1.0
    '''
        Models Fidessa Infrastructure.
        
        Change History:
        2013-10-06 | 1.0 | WF | Created.

    '''

    metadata
        publishers      := 'ION Group';
        products        := 'Fidessa';
        urls            := 'https://iongroup.com/markets/products/fidessa/';
        categories      := 'Equities Trading Platform';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, fidessa;
    end overview;

    constants
        type := 'Fidessa Infrastructure';
    end constants;

    triggers
        on process := DiscoveredProcess where (cmd matches unix_cmd 'tclsh' and args matches regex 'RunMinder')
                                            or cmd matches unix_cmd 'S?Jdi';
    end triggers;

    body

        cluster:= regex.extract(process.args, regex '(?i)(standby|primary|hot|master)', raw '\1', no_match:= void);
        si:= tsys_if.process2si(process, type, cluster);

    end body;
        
end pattern;


pattern Traversys_SI_ConManager 1.0
    '''
        Models Fidessa Consolidation Manager.
        
        Change History:
        2013-10-06 | 1.0 | WF | Created.

    '''

    metadata
        publishers      := 'ION Group';
        products        := 'Fidessa';
        urls            := 'https://iongroup.com/markets/products/fidessa/';
        categories      := 'Equities Trading Platform';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, fidessa, consolidation;
    end overview;

    constants
        type := 'Fidessa Consolidation Manager';
    end constants;

    triggers
        on process := DiscoveredProcess where cmd matches unix_cmd 'ConMgr\d*';
    end triggers;

    body

        si:= tsys_if.process2si(process, type, void);

    end body;

        
end pattern;


pattern Traversys_SI_Fidessa_Query 1.0
    '''
        Models Fidessa Query Server.
        
        Change History:
        2013-10-06 | 1.0 | WF | Created.

    '''

    metadata
        publishers      := 'ION Group';
        products        := 'Fidessa';
        urls            := 'https://iongroup.com/markets/products/fidessa/';
        categories      := 'Equities Trading Platform';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, fidessa, query;
    end overview;

    constants
        type := 'Fidessa Query Server';
    end constants;

    triggers
        on process := DiscoveredProcess where cmd matches regex '\b(?i)(Opub|DaqSvr|OaSwitch|Ref)$'
                                            or (cmd matches unix_cmd 'tclsh' and args matches regex 'fbl_TclRRSvr');
    end triggers;

    body
        
        si:= tsys_if.process2si(process, type, void);

    end body;

        
end pattern;

pattern Traversys_SI_Fidessa_Interfaces 1.0
    '''
        Models Fidessa Interfaces.
        
        Change History:
        2013-10-06 | 1.0 | WF | Created.

    '''

    metadata
        publishers      := 'ION Group';
        products        := 'Fidessa';
        urls            := 'https://iongroup.com/markets/products/fidessa/';
        categories      := 'Equities Trading Platform';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, fidessa, interfaces;
    end overview;

    constants
        type := 'Fidessa Interfaces';
    end constants;

    triggers
        on process := DiscoveredProcess where cmd matches unix_cmd 'SFCAdp'
                                            or cmd matches unix_cmd 'RDSCli';
    end triggers;

    body
        
        si:= tsys_if.process2si(process, type, void);

    end body;

end pattern;

pattern Traversys_SI_Fidessa_AllocMan 1.0
    '''
        Models Fidessa Allocation Management.
        
        Change History:
        2013-10-06 | 1.0 | WF | Created.

    '''

    metadata
        publishers      := 'ION Group';
        products        := 'Fidessa';
        urls            := 'https://iongroup.com/markets/products/fidessa/';
        categories      := 'Equities Trading Platform';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, fidessa, allocation;
    end overview;

    constants
	    type :=	'Fidessa Allocation Management';
    end constants;

    triggers
        on process := DiscoveredProcess where cmd matches unix_cmd 'tclsh'
                                            and args matches regex '\bCtacData';
    end triggers;

    body

        si:= tsys_if.process2si(process, type, void);

    end body;

end pattern;


pattern Traversys_SI_Fidessa_TradeMan 1.0
    '''
        Models Fidessa Trade Management.
        
        Change History:
        2013-10-06 | 1.0 | WF | Created.

    '''

    metadata
        publishers      := 'ION Group';
        products        := 'Fidessa';
        urls            := 'https://iongroup.com/markets/products/fidessa/';
        categories      := 'Equities Trading Platform';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, fidessa, trade;
    end overview;

    constants
	    type :=	'Fidessa Trade Management';
    end constants;

    triggers
        on process := DiscoveredProcess where cmd matches unix_cmd 'tclsh'
                                            and args matches regex '\btmar_\w+';
    end triggers;

    body

        si:= tsys_if.process2si(process, type, void);

    end body;

        
end pattern;

pattern Traversys_SI_Fidessa_BasketMan 1.0
    '''
        Models Fidessa Basket Management.
        
        Change History:
        2013-10-06 | 1.0 | WF | Created.

    '''

    metadata
        publishers      := 'ION Group';
        products        := 'Fidessa';
        urls            := 'https://iongroup.com/markets/products/fidessa/';
        categories      := 'Equities Trading Platform';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, fidessa, basket;
    end overview;

    constants
	    type :=	'Fidessa Basket Management';
    end constants;

    triggers
        on process := DiscoveredProcess where cmd matches unix_cmd 'tclsh'
                                            and args matches regex '\bbeam_\w+';
    end triggers;

    body
        
        si:= tsys_if.process2si(process, type, void);

    end body;

        
end pattern;


pattern Traversys_SI_Fidessa_OrderMan 1.0
    '''
        Models Fidessa Order Management.
        
        Change History:
        2013-10-06 | 1.0 | WF | Created.

    '''

    metadata
        publishers      := 'ION Group';
        products        := 'Fidessa';
        urls            := 'https://iongroup.com/markets/products/fidessa/';
        categories      := 'Equities Trading Platform';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, fidessa, orders;
    end overview;

    constants
	    type :=	'Fidessa Order Management';
    end constants;

    triggers
        on process := DiscoveredProcess where cmd matches unix_cmd 'tclsh'
                                            and args matches regex '\bsite-specific_\w+'
                                                or args matches regex '\bomar_\w+';
    end triggers;

    body

        si:= tsys_if.process2si(process, type, void);

    end body;

end pattern;

pattern Traversys_SI_Fidessa_PosMan 1.0
    '''
        Models Fidessa Position Management.
        
        Change History:
        2013-10-06 | 1.0 | WF | Created.

    '''

    metadata
        publishers      := 'ION Group';
        products        := 'Fidessa';
        urls            := 'https://iongroup.com/markets/products/fidessa/';
        categories      := 'Equities Trading Platform';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, fidessa, positions;
    end overview;

    constants
	    type:= 'Fidessa Position Management';
    end constants;

    triggers
        on process := DiscoveredProcess where cmd matches unix_cmd 'tclsh'
                                            and (args matches regex '\bsite-specific_(ValStrategy|Unlock)'
                                                    or args matches regex '\bpmac_\w+');
    end triggers;

    body

        si:= tsys_if.process2si(process, type, void);

    end body;

end pattern;


pattern Traversys_SI_Fidessa_MMA 1.0
    '''
        Models Fidessa Multi Market Access.
        
        Change History:
        2013-10-06 | 1.0 | WF | Created.

    '''

    metadata
        publishers      := 'ION Group';
        products        := 'Fidessa';
        urls            := 'https://iongroup.com/markets/products/fidessa/';
        categories      := 'Equities Trading Platform';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, fidessa, market, access;
    end overview;

    constants
	    type :=	'Fidessa Multi-Market Access';
    end constants;

    triggers
        on process := DiscoveredProcess where cmd matches unix_cmd 'enx(_Psr|Eig_Gw)'
                                            or cmd matched unix_cmd 'EuroNextGw'
                                                or cmd matches regex '\b[Mm]il_?Eis'
                                                    or cmd matches regex '\b(\w_)?Vwap\b'
                                                        or cmd matched unix_cmd 'aq_Autoopen';
    end triggers;

    body

        si:= tsys_if.process2si(process, type, void);

    end body;

        
end pattern;

identify Fidessa 1.0
    tags Fidessa;
    DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'S?Jdi'                          -> 'traversys', 'Fidessa Infrastructure';
    unix_cmd 'ConMgr\d*'                      -> 'traversys', 'Fidessa Consolidation Manager';
    unix_cmd 'SFCAdp'                         -> 'traversys', 'Fidessa Interfaces';
    unix_cmd 'RDSCli'                         -> 'traversys', 'Fidessa Interfaces';
    unix_cmd 'enx(_Psr|Eig_Gw)'               -> 'traversys', 'Fidessa Multi-Market Access';
    unix_cmd 'EuroNextGw'                     -> 'traversys', 'Fidessa Multi-Market Access';
    unix_cmd 'aq_Autoopen'                    -> 'traversys', 'Fidessa Multi-Market Access';
    regex '\b(?i)(Opub|DaqSvr|OaSwitch|Ref)$' -> 'traversys', 'Fidessa Query Server';
    regex '\b[Mm]il_?Eis'                     -> 'traversys', 'Fidessa Multi-Market Access';
    regex '\b(\w_)?Vwap\b'                    -> 'traversys', 'Fidessa Multi-Market Access';
end identify;

identify Fidessa_args 1.0
    tags Fidessa;
    DiscoveredProcess cmd, args -> set_by, simple_identity;
    unix_cmd 'tclsh', regex 'RunMinder'                            -> 'traversys', 'Fidessa Infrastructure';
    unix_cmd 'tclsh', regex 'fbl_TclRRSvr'                         -> 'traversys', 'Fidessa Query Server';
    unix_cmd 'tclsh', regex '\bCtacData'                           -> 'traversys', 'Fidessa Allocation Management';
    unix_cmd 'tclsh', regex '\btmar_\w+'                           -> 'traversys', 'Fidessa Trade Management';
    unix_cmd 'tclsh', regex '\bbeam_\w+'                           -> 'traversys', 'Fidessa Basket Management';
    unix_cmd 'tclsh', regex '\bsite-specific_\w+'                  -> 'traversys', 'Fidessa Order Management';
    unix_cmd 'tclsh', regex '\bomar_\w+'                           -> 'traversys', 'Fidessa Order Management';
    unix_cmd 'tclsh', regex '\bsite-specific_(ValStrategy|Unlock)' -> 'traversys', 'Fidessa Position Management';
    unix_cmd 'tclsh', regex '\bpmac_\w+'                           -> 'traversys', 'Fidessa Position Management';
end identify;
