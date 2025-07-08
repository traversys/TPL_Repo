tpl 1.9 module traversys_ArchestrA;

metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Wonderware', 'ArchestrA System Platform';
end metadata;

pattern Traversys_SI_ArchestrA 1.0
    '''
    ArchestrA Platform.
    
    Change History:
    2015-02-20 | 1.0 | WF | Created.
    
    '''
    metadata
        publishers      := 'Wonderware';
        products        := 'ArchestrA System Platform';
        urls            := 'http://archestra.info/index.php';
        categories      := 'License Management';
        known_versions  := '2020 R2';
    end metadata;
    
    overview
        tags archestra, wonderware, custom, traversys;
    end overview;
    
    constants
        type := 'ArchestrA System Platform';
    end constants;

    triggers
        on p:= DiscoveredProcess created, confirmed where cmd matches windows_cmd 'aa(Logger|Bootstrap)'
                                                       or cmd matches windows_cmd 'aah(\w+)Svc'
                                                       or cmd matches windows_cmd 'Alarmmgr';

    end triggers;

    body

        host:= related.host(p);
        
        package_lst:= model.findPackages(host, [ regex "^Wonderware\sApplication\sServer" ]);
        
        name:= '%type% on %host.name%';
        version:= "";
        pr_version:= "";
        edition:= "";
        
        for pkg in package_lst do
            if "version" in pkg then
                if pkg.version > version then
                    version:= pkg.version;
                    log.debug("Package version: %version%");
                end if;
                pr_version:= regex.extract(version, regex '^(\d+(?:\.\d+)?)', raw '\1', no_match := version);
                name:= '%type% %pr_version% on %host.name%';
                edition:= regex.extract(pkg.name, regex 'Wonderware\sApplication\sServer\s(.*)', raw '\1');
                if edition then
                    name:= '%type% %edition% on %host.name%';
                    year:= regex.extract(edition, regex '^(\d{4})\b', raw '\1');
                    if year then
                        name:= '%type% %year% on %host.name%';
                    end if;
                end if;
            end if;
        end for;

        nr_si:= model.SoftwareInstance(
                                    name:= name,
                                    key:= text.hash("%host.key%/%name%"),
                                    type:= type,
                                    version:= version,
                                    product_version:= pr_version,
                                    edition:= edition,
                                    environment:= host_env,
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "%type%_sis");
        
    end body;

end pattern;

identify ArchestrA 1.0
    tags ArchestrA;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'aa(Logger|Bootstrap)' -> 'traversys', 'ArchestrA System Platform';
    windows_cmd 'Alarmmgr' -> 'traversys', 'ArchestrA System Platform';
    windows_cmd 'aah(\w+)Svc' -> 'traversys', 'ArchestrA System Platform';
end identify;