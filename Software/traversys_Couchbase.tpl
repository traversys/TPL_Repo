tpl 1.9 module traversys_Couchbase;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Couchbase', 'Couchbase Server';
end metadata;

pattern Traversys_SI_Couchbase 1.0
      '''
          Couchbase Server
          
          Change History:
          2015-05-07 | 1.0 | WF | Created.

      '''
    metadata
        publishers      := 'Couchbase';
        products        := 'Couchbase Server';
        urls            := 'https://docs.couchbase.com/home/server.html';
        categories      := 'Distributed Document Database';
        known_versions  := '7.0';
    end metadata;

    overview
        tags custom, traversys, couchbase;
    end overview;
    
    constants
        type:= "Couchbase Server";
    end constants;
    
    triggers
        on pr:= DiscoveredProcess where cmd matches regex '/opt/couchbase(\S+)?';
    end triggers;
    
    body

        host := related.host(p);
        name := "%type% on %host.name%";

        packages := model.findPackages(host, [ regex "couchbase-server" ]);
        version:= none;
        product_version:= none;
        revision:= none;
        
        for package in packages do
            package_name := package.name;
            if "version" in package then
                if package.version > version then
                    version := package.version;
                    if "build" in package then
                        version := "%package_version%.%package.build%";
                        build := package.build;
                    end if;
                    product_version := regex.extract(package_version, regex'(\d+(?:\.\d+)?)', raw'\1', version);
                    name:= "%type% %product_version% on %host.name%";
                end if;
            end if;
        end for;

        si := model.SoftwareInstance(
                                    key:= text.hash("%type%/%host.name%"),
                                    name:= name,
                                    type:= type,
                                    version:= version,
                                    product_version:= product_version,
                                    build:= build,
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "%type%_sis");

        all_prs:= discovery.allProcesses(pr);
        rel_prs:= search(in all_prs where cmd matches regex "/opt/couchbase");
        inference.associate(si, rel_prs);
    
    end body;

end pattern;

identify Couchbase 1.0
    tags Couchbase;
    DiscoveredProcess cmd -> set_by, simple_identity;
    regex '/opt/couchbase(\S+)?' -> 'traversys', 'Couchbase Server';
end identify;