tpl 1.9 module traversys_Navisworks;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Autodesk', 'Navisworks';
end metadata;

pattern Traversys_SI_Navisworks_License 1.0
    '''
        Navisworks Licence Server.
        
        Change History:
        2015-09-24 | 1.0 | WF | Created.
    '''

    metadata
        publishers      := 'Autodesk';
        products        := 'Navisworks';
        urls            := 'https://www.autodesk.co.uk/products/navisworks/overview';
        categories      := '3D Design Review';
        known_versions  := 'Simulate', 'Manage';
    end metadata;

    overview
        tags autodesk, navisworks, licensing, custom, traversys;
    end overview;

    constants
        type:= "Autodesk Navisworks Licence Server";
    end constants;

    triggers
        on process:= DiscoveredProcess where cmd matches windows_cmd 'LcLicServer';
    end triggers;

    body

        host:= related.host(process);
        name:= "%type% on %host.name%";
        key := text.hash("%type%/%host.key%");

        si:= model.SoftwareInstance(
                                    key:= key,
                                    name:= name,
                                    type:= type,
                                    _traversys:= true);
        model.setRemovalGroup(si, "%type%_sis");
		
    end body;

end pattern;

identify Navisworks 1.0
	tags Navisworks;
	DiscoveredProcess cmd -> set_by, simple_identity;
	windows_cmd 'LcLicServer' -> "traversys", "Autodesk Navisworks Licence Server";end identify;
