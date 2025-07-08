tpl 1.6 module traversys_Axios_Assyst;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Axios', 'Assyst';
end metadata;

pattern Traversys_SI_Assyst 1.0
    '''  
        Identifies Axios Assyst.

        Change History:
        2015-09-10 | 1.0 | WMF | Created.
    '''

    metadata
        products := 'Assyst';
        urls := 'https://www.axiossystems.com/';
        publishers  := 'Axios Systems';
        categories := 'ITSM and Asset Management';
        known_versions := '0';
    end metadata;

    overview
        tags axios, assyst, custom, traversys;
    end overview;
    
    constants
    	type := 'Axios Assyst';
    end constants;

    triggers
		on p:= DiscoveredProcess created, confirmed where cmd matches windows_cmd 'assyst';
    end triggers;

    body

		host := model.host(p);
        name:= '%type% on %host.name%';
        v:= none;

        wmiNameSpace := 'root\CIMV2';
        cmd_line:= text.replace(p.cmd, '\\', '\\\\');
        wmiQuery:= "select Version from CIM_DataFile where Name = '%cmd_line%'";
        wmi_results:= discovery.wmiQuery(host, wmiQuery, wmiNameSpace);    
        if wmi_results then
            v:= wmi_results[0].Version;
        end if;
        
        if not v then
            packages := model.findPackages(host, [ regex "^assyst" ]);
            for pkg in packages do
                if "version" in pkg then
                    if pkg.version > v then
                        v:= pkg.version;
                    end if;
                end if;
            end for;
        end if;

        if v then
            pv:= regex.extract(v, regex '^(\d+(?:\.\d+)?)', raw '\1', no_match:= v);
            name := '%type% %pv% on %host.name%';
        else
            pv:= none;
        end if;
	
		model.SoftwareInstance(
                                key:= '%type%/%host.key%',
                                name:= name,
                                type:= type,
                                version:= v,
                                product_version:= pv,
                                _traversys:= true
                                );
		
    end body;

end pattern;

identify assyst 1.0
    tags assyst;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'assyst' -> 'traversys', 'Axios Assyst';end identify;
