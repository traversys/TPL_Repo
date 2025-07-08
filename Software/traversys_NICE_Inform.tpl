tpl 1.9 module traversys_NICE_Inform;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'NICE Inform', 'Inform Application Suite';
end metadata;

pattern Traversys_SI_NICEInform 1.0
    '''
        NICE Inform Application Server.
        
        Change History:
        2015-09-04 | 1.0 | WF | Created.
    
    '''

    metadata
        publishers      := 'NICE';
        products        := 'Inform Application Suite';
        urls            := 'https://www.nicepublicsafety.com/nice-inform/';
        categories      := 'Incident Management';
        known_versions  := '0';
    end metadata;

    overview
        tags nice, inform, custom, traversys;
    end overview;
    
    constants
        type:= 'NICE Inform';
    end constants;

    triggers
     on process := DiscoveredProcess where cmd matches windows_cmd 'Nice\.Inform\.Server';
    end triggers;

    body

        host:= model.host(process);
        instance:= "%type% Application Server";
        name:= '%instance% on %host.name%';
        
        server:= regex.extract(process.cmd, regex "Nice\.Inform\.Server\.(\w+)\.exe", raw "\1");
        if server then
            if server matches "Server" then
                instance:= "%type% %server%";
            else
                instance:= "%type% %server% Server";
            end if;
            name:= '%instance% on %host.name%';
        end if;
        
        packages:= model.findPackages(host, [ regex "NICE Inform Server" ]);
        version:= void;
		pr_version:= void;
		
        for pkg in packages do
            if "version" in pkg then
                if pkg.version > version then
                    version:= pkg.version;
                end if;
                pr_version:= regex.extract(version, regex '^(\d+(?:\.\d+)?)', raw '\1', no_match := version);
                name:= '%instance% %pr_version% on %host.name%';
            end if;
        end for;

        key := text.hash("%instance%/%host.key%");
	
		si:= model.SoftwareInstance(key:= key,
                                    name:= name,
                                    type:= type,
                                    version:= version,
                                    product_version:= pr_version,
                                    instance:= instance,
                                    _traversys:= true);
        model.setRemovalGroup(si, "%type%_sis");
		
    end body;

end pattern;

identify NICEInform 1.0
	tags NICEInform;
	DiscoveredProcess cmd -> set_by, simple_identity;
	windows_cmd 'Nice\.Inform\.Server' -> "traversys", "NICE Inform Server Process";end identify;
