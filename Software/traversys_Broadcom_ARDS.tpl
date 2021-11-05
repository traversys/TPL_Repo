tpl 1.9 module traversys_Broadcom_ARDS;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Broadcom', 'Advanced Repository for Distributed Systems (ARDS)';
end metadata;

pattern Traversys_SI_ARDS 1.0
    '''
        Generates model for the Repository for Distributed Systems Product.

        Change History:
        2015-09-11 1.0 | WF | Created.

    '''

    metadata
        publishers     := "Broadcom", "ComputerAssociates", "CA";
        products       := "Advanced Repository for Distributed Systems";
        urls           := "https://knowledge.broadcom.com/external/article/56263/advantage-repository-for-distributed-sys.html",
                          "https://techdocs.broadcom.com/us/en/ca-miscellaneous/legacy_bookshelves_and_pdfs/bookshelves_and_pdfs/bookshelves/ca-distributed-repository-access-system.html";
        categories     := 'License Management';
        known_versions := '2.1';
    end metadata;

    overview
		tags ards, broadcom, ca, custom, traversys;
	end overview;

    constants
        type:= 'Broadcom Advantage Repository for Distributed Systems';
    end constants;

    triggers
        on p := DiscoveredProcess created, confirmed where cmd matches windows_cmd 'lwdbsrvc'
                                                            or cmd matches windows_cmd 'lwudsrvr';
    end triggers;

    body
        
        host := related.host(p);
        name := "%type% on %hostname%";

        packages := model.findPackages(host, [regex '(?i)Advantage Repository for Distributed Systems' ]);
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

    end body;

end pattern;

identify BroadcomARDS 1.0
    tags Broadcom, ARDS;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'lwdbsrvc' -> 'traversys', 'Broadcom Advantage Repository for Distributed Systems';
    windows_cmd 'lwudsrvr' -> 'traversys', 'Broadcom Advantage Repository for Distributed Systems';
end identify;