tpl 1.9 module traversys_Broadcom_CA_Licensing;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Broadcom', 'CA License Server';
end metadata;


pattern Traversys_SI_CA_Licensing 1.0
    '''
        Generates model for the CA License Server.

        Change History:
        2008-11-17 | 1.0 | WF | Created.

    '''

    metadata
        publishers     := "Broadcom", "ComputerAssociates", "CA";
        products       := "CA Licensing";
        categories     := 'License Management';
    end metadata;

    overview
		tags licensing, broadcom, ca, custom, traversys;
	end overview;

    constants
        type:= 'Broadcom CA License Server';
    end constants;

    triggers
        on p := DiscoveredProcess where cmd matches regex '(?i)\bCA.*\blic(\d+)?rmtd';
    end triggers;

    body
        
        // Get host details
        host := related.host(p);

        name := "%type% Server on %host.name%";

        packages := model.findPackages(host, [regex '(?i)CA Licensing']);
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
                                           name := name,
                                           type := type,
                                           version := version,
                                           product_version := product_version
                                           revision := revision,
                                           _traversys:= true
                                         );
        model.setRemovalGroup(si, "%type%_sis");

    end body;

end pattern;

identify BroadcomLicensing 1.0
    tags Broadcom, Licensing;
    DiscoveredProcess cmd -> set_by, simple_identity;
    regex '(?i)\bCA.*\blic(\d+)?rmtd?' -> 'traversys', 'Broadcom CA License Server';
    regex '(?i)\blicrmt\b' -> 'traversys', 'Broadcom CA License Client';
    regex '(?i)\bCA.*\blic(\d+)?services\.exe' -> 'traversys', 'Broadcom CA License Client';
    regex '(?i)\bCA.*\blic(\d+)?fds' -> 'traversys', 'Broadcom CA License Client';end identify;
