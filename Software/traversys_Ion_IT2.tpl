tpl 1.9 module traversys_ION_IT2;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'ION Group', 'IT2';
end metadata;

pattern Traversys_SI_IT2 1.0
    '''
    Traversys IT2 Application Server
    
    Author: Wes Fitzpatrick
    
    Change History:
    2015-02-25 - WF: Rewrite.
    
    '''
    metadata
        publishers      := 'ION Group';
        products        := 'IT2';
        urls            := 'https://iongroup.com/treasury/products/it2/';
        categories      := 'Risk Management';
        known_versions  := '0';
    end metadata;
    
    overview
        tags ion, it2, custom, traversys;
    end overview;
    
    constants
        type := 'ION IT2 Application Server';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd 'IT2SS';
    end triggers;

    body
        
        host := related.host(p);
        name := "%type% on %hostname%";

        packages:= model.findPackages(host, [ regex "^(?i)IT2\sApplication\sServer" ]);
        version:= none;
        product_version:= none;
        
        for package in packages do
            package_name := package.name;
            if "version" in package then
                if package.version > version then
                    version := package.version;
                    product_version := regex.extract(package_version, regex'(\d+(?:\.\d+)?)', raw'\1', version);
                end if;
            end if;
        end for;

        si_node := model.SoftwareInstance(
                                           key  := text.hash("%type%/%host.name%"),
                                           name := name,
                                           type := type,
                                           version := version,
                                           product_version := product_version,
                                           _traversys:= true
                                         );
        model.setRemovalGroup(si, "%type%_sis");
        
        // Get Services
        da:= discovery.access(p);
        rel_services:= search(in da
                                traverse DiscoveryAccess:DiscoveryAccessResult:DiscoveryResult:ServiceList
                                    traverse List:List:Member:DiscoveredService
                                        where state = "RUNNING"
                                            and pid = "%p.pid%"
                                            and name matches regex "^IT2AppServer");
        inference.associate(si_node, rel_services);
        
        all_procs:= discovery.allProcesses(p);
        related_procs:= search(in all_procs where cmd matches windows_cmd 'IT2\s*Event\s*Monitor');
        inference.associate(si_node, related_procs);
        
    end body;

end pattern;

identify it2 1.0
    tags it2;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'IT2SS' -> 'traversys', 'ION IT2 Application Server';end identify;
