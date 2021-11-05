tpl 1.9 module traversys_eB_Insight;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Bentley Systems', 'eB Insight';
end metadata;

pattern Traversys_SI_eBServiceManager 1.0
    '''
    Bentley eB Insight server.
    
    Author: Wes Fitzpatrick
    
    Change History:
    2015-02-25 | 1.0 | WF | Created.
    
    '''

    metadata
        publishers     := "Bentley Systems";
        products       := "eB Insight";
        urls           := "https://ecosystem.asite.com/partners/bentleys-eb-insight";
        categories     := "Asset Lifecycle Information Management";
        known_versions := "15";
    end metadata;

    overview
        tags eb, insight, bentley, custom, traversys;
    end overview;

    constants
        type:= 'Bentley eB Insight';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd 'eB\.Service\.Manager';
    end triggers;

    body
        
        host := related.host(p);
        name := "%type% on %hostname%";

        packages := model.findPackages(host, [regex '^(?i)eb\s(core|web)' ]);
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
        
        // Get Services
        disco_acc:= discovery.access(p);
        rel_services:= search(in disco_acc traverse DiscoveryAccess:DiscoveryAccessResult:DiscoveryResult:ServiceList
                                traverse List:List:Member:DiscoveredService
                                    where state = "RUNNING"
                                        and pid = "%p.pid%"
                                            and name matches regex "^eB\s");
        inference.associate(si_node, rel_services);
        
        all_procs:= discovery.allProcesses(p);
        related_procs:= search(in all_procs where cmd matches windows_cmd 'IT2\s*Event\s*Monitor');
        inference.associate(si_node, related_procs);
        
    end body;

end pattern;

identify eb 1.0
    tags eb;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'eB\.Service\.Manager' -> 'traversys', 'Bentley eB Insight';
end identify;