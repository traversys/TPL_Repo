tpl 1.9 module traversys_McLaren_DocLoader;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'McLaren DocLoader';
end metadata;

pattern Traversys_SI_McLaren_DocLoader 1.0
    '''
    McLaren DocLoader.
    
    Change History:
    2015-02-10 | 1.0 | WF | Created.

    '''

    metadata
        publishers     := "McLaren Software", "Idox";
        products       := "DocLoader";
        urls           := "http://www.mclarensoftware.com/ms/products/Docloader";
    end metadata;

    overview
        tags mclaren, idox, docloader, custom, traversys;
    end overview;
    
    constants
        type:= 'Idox McLaren DocLoader';
    end constants;

    triggers
     on p := DiscoveredProcess where cmd matches windows_cmd 'DocLoader';
    end triggers;

    body
        
        host := related.host(p);
        name := "%type% on %hostname%";

        packages := model.findPackages(host, [ regex "^McLaren\sDocLoader" ]);
        version:= none;
        product_version:= none;
        revision:= none;
        
        for package in packages do
            package_name := package.name;
            if "version" in package then
                if package.version > version then
                    version := package.version;
                    if "revision" in package then
                        version := "%package_version%.%package.revision%";
                        revision := package.revision;
                        product_version := regex.extract(package_version, regex'(\d+(?:\.\d+)?)', raw'\1', version);
                        name:= "%type% %product_version% on %hn%";
                    end if;
                end if;
            end if;
        end for;

        si_node := model.SoftwareInstance(
                                           key  := text.hash("%type%/%host.name%"),
                                           name := name,
                                           type := type,
                                           version := version,
                                           product_version := product_version,
                                           revision := revision,
                                           _traversys:= true
                                         );
        model.setRemovalGroup(si, "%type%_sis");
		
    end body;

end pattern;

identify DocLoader 1.0
    tags DockLoader;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'DocLoader' -> 'traversys', 'Idox McLaren DocLoader';
end identify;