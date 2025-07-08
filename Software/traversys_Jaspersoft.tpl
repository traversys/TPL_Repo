tpl 1.9 module traversys_TIBCO_Jaspersoft;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'TIBCO', 'Jaspersoft';
end metadata;

pattern Traversys_SI_JaspersoftReports 1.0
    """
    Jaspersoft Reports.
    
    Change History:
    2015-09-17 | 1.0 | WF | Created.
    
    """
    metadata
        publishers      := 'TIBCO';
        products        := 'Jaspersoft';
        urls            := 'https://www.jaspersoft.com/';
        categories      := 'Embedded Analytics and Reporting';
        known_versions  := '0';
    end metadata;

    overview
        tags traversys, custom, jaspersoft, reports, tibco;
    end overview;
    
    constants
        type := "TIBCO Jaspersoft Reports";
    end constants;
    
    triggers
        on service := DiscoveredService where state = 'RUNNING' and name matches "(?i)jasperreportsPostgreSQL";
    end triggers;
    
    body

        host:= related.host(service);
        all_procs:= discovery.allProcesses(service);
        version:= none;
        pr_version:= none;
        
        name := "%type% on %host.name%";
        key := text.hash("%type%/%host.name%");

        packages := model.findPackages(host, [ regex '(?i)^JasperReports' ]);
        for pkg in packages do
            if "version" in pkg then
                if pkg.version > v then
                    version:= pkg.version;
                end if;
            end if;
        end if;
        
        if version then
            pr_version:= regex.extract(version, regex "(\d+(?:\.\d+)?)", raw "\1", no_match:= version);
            name:= '%type% %product_version% on %host.name%';
        end if;

        si:= model.SoftwareInstance(
                                    key:= key,
                                    type:= type,
                                    name:= name,
                                    version:= version,
                                    product_version:= pr_version,
                                    cmd:= service.cmdline,
                                    pid:= service.pid,
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "%type%_sis");
        
    end body;

end pattern;

identify Jaspersoft 1.0
    tags Jaspersoft;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'jasperreportsPostgreSQL' -> 'traversys', 'TIBCO Jaspersoft Reports';end identify;
