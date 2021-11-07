tpl 1.9 module traversys_MNetics_Meteor;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'M-Netics', 'Meteor Platform';
end metadata;

pattern Traversys_SI_Meteor_Server 1.0
    '''
        Meteor server for M-Netics.

        Change History:
        2014-07-07 | 1.0 | WF | Created.
		
    '''
    metadata
        publishers      := 'M-Netics';
        products        := 'Meteor Platform';
        urls            := 'https://www.mnetics.co.uk/?ContentID=161';
        categories      := 'Enterprise Resource Planning';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, meteor, mnetics;
    end overview;

    constants
        type := 'Meteor Platform';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches regex "(?i)\bmeteorserver(\.exe)?$";
    end triggers;

    body

		host := related.host(p);
        name := "%type% on %hostname%";

        packages:= model.findPackages(host, [ regex "(?i)meteor" ]);
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

    end body;

end pattern;


pattern Traversys_SI_Meteor_Transaction 1.0
    '''
        Meteor transaction process for M-Netics.

        Change History:
        2014-07-07 | 1.0 | WF | Created.
		
    '''
    metadata
        publishers      := 'M-Netics';
        products        := 'Meteor Platform';
        urls            := 'https://www.mnetics.co.uk/?ContentID=161';
        categories      := 'Enterprise Resource Planning';
        known_versions  := '0';
    end metadata;

    overview
        tags custom, traversys, meteor, mnetics, transaction;
    end overview;

    constants
        type := 'Meteor Transaction Server';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches regex "(?i)\bpmeteortransaction(\.exe)?$";
    end triggers;

    body
		
		host := related.host(p);
        name := "%type% on %hostname%";

        packages:= model.findPackages(host, [ regex "(?i)meteor" ]);
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

    end body;

end pattern;


identify MNetics_SimpleIds 1.0
	tags MNetics;
	DiscoveredProcess cmd -> set_by, simple_identity;
	regex "(?i)\bmeteorserver(\.exe)?$" -> "traversys", "M-Netics Meteor Server";
	regex "(?i)\bpmeteortransaction(\.exe)?$" -> "traversys", "M-Netics Meteor Transaction Server";
end identify;
