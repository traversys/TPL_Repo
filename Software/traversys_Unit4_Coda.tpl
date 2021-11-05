tpl 1.9 module traversys_Unit4_Coda;

metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Unit4', 'Coda Financials';
end metadata;

pattern Traversys_SI_Coda_Financials 1.0
    '''
        Author: Wes Fitzpatrick, Traversys Limited

        This pattern is used to model the Data Store server for Coda Web.

        Change History:
        2014-06-24 | 1.0 | WF | Created.

    '''

    metadata
        products       := 'Coda Financials';
        urls           := 'https://www.unit4.com/products/financial-management-software';
        publishers 	   := "Unit4";
        categories     := 'Financial Management & Accounting';
        known_versions := '0';
    end metadata;

	overview
		tags coda, finance, unit4, custom, traversys;
	end overview;

	constants
    	win_coda_dir := "\conf\Catalina\localhost\coda.xml";
    	nix_coda_dir := "/conf/Catalina/localhost/coda.xml";
		type		 := "Unit4 Coda Finance";
	end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches regex "(?i)\bcodajavasrv(\.exe)?$"
									or cmd matches regex "(?i)\boasnsv(\.exe)$";
    end triggers;

    body

        // Get host
        h:= related.host(p);
        
        // Get properties file
        d:= regex.extract(p.cmd, regex "^(\w:\\.*?\\CODA\\.*?\\)", raw "\1");
        fd:= d + "webapps\\default\\WEB-INF\\classes\\coda-web.properties";
        dl:= d + "webapps\\default\\WEB-INF\\classes";
        pf:= discovery.fileGet(h, fd);
        ld:= discovery.listDirectory(h, dl);
		n:= "%type% on %hn%";

        packages := model.findPackages(host, [ regex "^(?i)coda" ]);
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
						n:= "%type% %product_version% on %hn%";
                    end if;
                end if;
            end if;
        end for;
        
        da:= discovery.access(p);
        ser_l:= search(in da traverse DiscoveryAccess:DiscoveryAccessResult:DiscoveryResult:ServiceList
                                traverse List:List:Member:DiscoveredService where state = "RUNNING"
									and (cmdline = "%p.cmd%" or name matches "\b(?i)coda\b")
                        );
        sc:= size(ser_l);
        for ser in ser_l do
            sn:= ser.display_name;
        end for;

        si:= model.SoftwareInstance(
									key:=text.hash("%type%/%host.key%"),
									name:=n,
									version:=v,
									product_version:=pv,
									type:=type,
									_traversys:=true
									);
		model.setRemovalGroup(si, "%type%_sis");
        si.instance:= sn;

    end body;

end pattern;

identify Coda 1.0
    tags Coda;
    DiscoveredProcess cmd -> set_by, simple_identity;
    regex "(?i)\bcodajavasrv(\.exe)?$" -> "traversys", "Unit4 Coda Finance";
    regex "(?i)\boasnsv(\.exe)$" ->  "traversys", "Unit4 Coda Name Server";
end identify;