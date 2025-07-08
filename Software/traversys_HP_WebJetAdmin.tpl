tpl 1.9 module traversys_HP_WebJetAdmin;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'HP', 'Web Jetadmin';
end metadata;

pattern Traversys_SI_HPWebJetAdmin 1.0
    """
        HP Web Jetadmin.
      
        Change History:
        2015-09-17 | 1.0 | WF | Created.

    """
    metadata
        publishers      := 'HP';
        products        := 'Web Jetadmin';
        urls            := 'https://www.hp.com/us-en/solutions/business-solutions/printingsolutions/wja.html';
        categories      := 'Printer Utility';
        known_versions  := '0';
    end metadata;
    
    overview
        tags custom, web, jetadmin, hp, traversys;
    end overview;
    
    constants
        type := 'HP Web Jetadmin';	
    end constants;
    
    triggers
        on process:= DiscoveredProcess where cmd matches windows_cmd 'HPWJAService' and args = '-AppID=WjaService';
    end triggers;
    
    body

        host:= related.host(process);
        version:= none;
        pr_version:= none;
        
        name := "%type% on %host.name%";
        key := text.hash("%type%/%host.name%");

        packages := model.findPackages(host, [ regex '^HP Web Jetadmin$' ]);
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

    end body;
	
end pattern;

identify WebJetAdmin 1.0
    tags WebJetAdmin;
    DiscoveredProcess cmd, args -> set_by, simple_identity;
    windows_cmd 'HPWJAService', '-AppID=WjaService' -> 'traversys', 'HP Web Jetadmin';end identify;
