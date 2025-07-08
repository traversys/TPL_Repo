tpl 1.9 module traversys_Solidus_eCare;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Ericsson', 'Solidus eCare';
end metadata;

pattern Traversys_SI_SoliduseCare 1.0
    """
        Solidus eCare
      
        Change History:
        2015-09-17 | 1.0 | WF | Created.
    
    """
    metadata
        publishers      := 'Ericsson';
        products        := 'Solidus eCare';
        urls            := 'https://www.gartner.com/en/documents/325946/ericsson-solidus-ecare';
        categories      := 'Customer Contact Center';
        known_versions  := '0';
    end metadata;

    overview
        tags solidus, custom, ericsson, ecare, traversys;
    end overview;
    
    constants
        type := 'Ericsson Solidus eCare';
    end constants;
    
    triggers
        on process:= DiscoveredProcess where cmd matches windows_cmd 'ccas';
    end triggers;
    
    body
        
        host:= related.host(process);
        version:= none;
        pr_version:= none;
        
        name := "%type% on %host.name%";
        key := text.hash("%type%/%host.name%");

        packages := model.findPackages(host, [ regex '^Solidus eCare$' ]);
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

identify Solidus_eCare 1.0
    tags Solidus, eCare;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'ccas' -> 'traversys', 'Ericsson Solidus eCare';end identify;
