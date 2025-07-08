tpl 1.9 module traversys_Bentley_ProjectWise;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Bentley Systems', 'Projectwise';
end metadata;

pattern Traversys_SI_ProjectWise 1.0
    '''
        ProjectWise.

        Change History:
        2015-08-04 | 1.0 | WF | Created.

    '''
    metadata
        publishers      := 'Bentley Systems';
        products        := 'Projectwise';
        urls            := 'https://www.bentley.com/en/products/brands/projectwise';
        categories      := 'Document Management Software';
        known_versions  := '0';
    end metadata;

	overview
		tags bentley, projectwise, custom, traversys;
	end overview;
    
    constants
        generic_type    := "ProjectWise";
        wmiNameSpace    := 'root\CIMV2';
        wmiServiceQ     := "select Name, DisplayName from Win32_Service where Name like 'PW%'";
        pw_caching      := 'ProjectWise Caching Server';
        pw_integration  := 'ProjectWise Integration Server';
        pw_cacheint     := 'ProjectWise Caching/Integration Server';
        pw_oframework   := 'ProjectWise Orchestration Framework Service';
        pw_bentley      := 'Bentley Systems Logging Server';
        pw_geoweb       := 'Bentley Systems GeoWeb Publisher';
        pw_bentley_pub  := 'Bentley Systems GeoWeb Publisher Automation Service';
    end constants;

	triggers
		on process:= DiscoveredProcess where 
                                        cmd matches windows_cmd 'dmskrnl' or
                                        cmd matches windows_cmd 'Shepherd' or
                                        cmd matches windows_cmd 'PubImaging' or
                                        cmd matches windows_cmd 'PubServer' or
                                        cmd matches windows_cmd 'DataPreparation'
                                        cmd matches regex '\bBentleyLoggingServer';
	end triggers;

	body

		host:= related.host(process);
        cmd:= process.cmd;
        type:= generic_type;
		
		if cmd matches 'dmskrnl' then
			package_rx:= "(Caching|Integration)";
			type:= pw_cacheint;
			wmi_sResults:= discovery.wmiQuery(host, wmiServiceQ, wmiNameSpace);
			if wmi_sResults and wmi_sResults[0].Name = 'PWFTSrv' then
				type:= pw_caching;
			elif wmi_sResults and wmi_sResults[0].Name = 'PWAppSrv' then
				type:= pw_integration;
            else
                type:= pw_cacheint;
			end if;
		elif cmd matches 'Shepherd' then
			package_rx:= pw_oframework;
			type:= pw_oframework;
		elif cmd matches 'BentleyLoggingServer' then
			package_rx:= pw_bentley;
			type:= pw_bentley;
		elif cmd matches 'PubImaging' then
			package_rx:= pw_bentley;
			type:= pw_bentley;
		elif cmd matches 'PubServer' then
			package_rx:= pw_geoweb;
			type:= pw_geoweb;
		elif cmd matches 'DataPreparation' then
			package_rx:= pw_bentley_pub;
			type:= pw_bentley_pub;
		end if;
        
        name:= "%type% on %host.name%";
		
		full_version:= '';
		product_version:= '';
      
		cmd_line:= text.replace(process.cmd, '\\', '\\\\');
		wmiQuery:= "select Version from CIM_DataFile where Name = '%cmd_line%'";
		wmi_results:= discovery.wmiQuery(host, wmiQuery, wmiNameSpace);
		if wmi_results then
			full_version := wmi_results[0].Version;
		end if;
        
        if not full_version then
			packages := model.findPackages(host, [ regex "^(?i)%package_rx%" ]);
			for package in packages do
				if package.version and package.version > full_version then
					full_version := package.version;
					if package.name matches 'ProjectWise Integration' then
						type := pw_integration;
					elif package.name matches 'ProjectWise Caching' then
						type := pw_caching;
					end if;
				end if;
			end for;
		end if;
		
        // Set product version
        if full_version then
            product_version:= regex.extract(full_version, regex '^(\d+\.\d+)', raw '\1', no_match:= full_version);
            name:= "%type% %product_version% on %host.name%";
        end if;
        
        key:= text.hash("%type%/%host.key%");
        
        si:= model.SoftwareInstance(
                                    key:= key,
                                    name:= name,
                                    type:= type,
                                    version:= full_version,
                                    product_version:= product_version,
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "%type%_sis");
		
    end body;

end pattern;


pattern Traversys_BAI_ProjectWise 1.0
    '''
    ProjectWise Application
    
    Change History:
    2015-08-03 | 1.0| WF | Created.
    
    '''

    overview
        tags bentley, projectWise, custom, traversys;
    end overview;
    
    constants
        type := 'Bentley Systems ProjectWise';
    end constants;

    triggers
        on si:= SoftwareInstance created, confirmed where type matches '^ProjectWise'
                                                        or type matches '^Bentley GeoWeb';
    end triggers;

    body

        name    := '%type%';
		
        key     := text.hash("%type%");

        new_sis := [];
        new_dbs := [];

        bai_node:= model.BusinessApplicationInstance(
                                                    key:= key,
                                                    name:= name,
                                                    type := type,
                                                    _traversys:= true
                                                    );
        model.addContainment(bai_node, si);
        model.setRemovalGroup(bai_node, "%type%_bais");
        
        rel:= search(SoftwareInstance where type = 'Bentley Logging Server');
        model.addContainment(bai_node, rel);
        
    end body;

end pattern;

identify ProjectWise 1.0
	tags ProjectWise;
	DiscoveredProcess cmd -> set_by, simple_identity;
	windows_cmd 'dmskrnl' -> "traversys", "Bentley Systems ProjectWise Caching/Integration Server";
    windows_cmd 'Shepherd' -> "traversys", "Bentley Systems ProjectWise Orchestration Framework Service";
    windows_cmd 'PubImaging' -> "traversys", "Bentley Systems GeoWeb Publisher";
    windows_cmd 'PubServer' -> "traversys", "Bentley Systems GeoWeb Publisher";
    windows_cmd 'DataPreparation' -> "traversys", "Bentley Systems GeoWeb Publisher Automation Service";
    regex '\bBentleyLoggingServer' -> "traversys", "Bentley Systems Logging Server";end identify;
