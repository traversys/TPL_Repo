tpl 1.6 module traversys_OpenOffice;

metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'OpenOffice';
end metadata;


pattern Traversys_SI_OpenOffice 1.0
    '''
    OpenOffice Server

    Change History:
    2015-05-07 | 1.0 | WF | Created.

    '''
  
    overview 
        tags openoffice, custom, traversys;
    end overview;

    metadata
        products := 'OpenOffice';
        urls := 'https://www.openoffice.org//';
        publishers  := 'Apache Foundation';
        categories := 'Office Software Suite';
        known_versions := '4.1.11';
    end metadata;
  
    constants
        type:= "Apache OpenOffice";
    end constants;
  
    triggers
        on pr:= DiscoveredProcess created, confirmed where cmd matches unix_cmd 'java' and args matches regex "\b(?i)openoffice\b";
    end triggers;

    body
  
        host:= related.host(pr);
        
        name:= '%type% on %host.name%';
        key:= text.hash("%type%/%host.key%");
        
        package_lst:= model.findPackages(host, [ regex "openoffice\.org" ]);

        pr_version:= "";
        version:= "";
        
        // Get the highest package
        for pkg in package_lst do
            log.debug("Found package %pkg.name%");
            if "version" in pkg then
                if pkg.version > version then
                    version:= pkg.version;
                    log.debug("Package version: %version%");
                end if;
                pr_version:= regex.extract(version, regex '^(\d+(?:\.\d+)?)', raw '\1', no_match := version);
                name:= '%type% %pr_version% on %host.name%';
            end if;
        end for;

        si:= model.SoftwareInstance(
                                    key:= key,
                                    name:= name,
                                    type:= type,
                                    version:= version,
                                    product_version:= pr_version,
                                    _traversys:= true
                                    );
    
    end body;
  
end pattern;

identify OpenOffice 1.0
    tags OpenOffice;
    DiscoveredProcess cmd, args -> set_by, simple_identity;
    unix_cmd 'java', regex "\b(?i)openoffice\b" -> 'traversys', 'Apache OpenOffice';
end identify;
