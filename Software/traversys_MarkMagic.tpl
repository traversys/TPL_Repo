tpl 1.9 module traversys_Cybra_MarkMagic;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Cybra', 'MarkMagic';
end metadata;


pattern Traversys_SI_MarkMagic 1.0
    '''
        Author: Wes Fitzpatrick, Traversys Limited

        Models Mark Magic software.

        Change History:
        2014-07-14 | 1.0 | WF | Created.

    '''

    metadata
        publishers      := 'Cybra';
        products        := 'MarkMagic';
        urls            := 'https://cybra.com/markmagic/';
        categories      := 'Barcode Labelling';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, cybra, markmagic;
    end overview;

    constants
        type := 'Cybra MarkMagic';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches regex "(?i)\bMarkMagic\b";
    end triggers;

    body
		
		// Get host
        host:= related.host(p);

		name:= "%type% on %host.name%";
		
        si_node := model.SoftwareInstance(
                                           key  := text.hash("%type%/%host.name%"),
                                           name := name,
                                           type := type,
                                           _traversys:= true
                                         );
        model.setRemovalGroup(si, "%type%_sis");

    end body;

end pattern;

identify MarkMagic 1.0
	tags MarkMagic;
	DiscoveredProcess cmd -> set_by, simple_identity;
	regex "(?i)\bMarkMagic\b" -> "traversys", "Cybra MarkMagic";
end identify;
