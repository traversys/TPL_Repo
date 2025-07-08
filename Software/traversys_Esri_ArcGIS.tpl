tpl 1.9 module traversys_Esri_ArcGIS;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Esri', 'ArcGIS';
end metadata;

definitions tsys_agis 1.0
    """
        Custom Functions for ArcGIS.

        Author: Wes Moskal-Fitzpatrick

        Change History:
        2015-02-10 | 1.0 | WMF | Created

    """

    define process2si(process, type, svc_rx, pck_rx) -> si
        """
            Generate an SI based on DiscoveredProcess.
        """

        host:= related.host(process);
        da:= discovery.access(process);
        services:= search(in da
                                traverse DiscoveryAccess:DiscoveryAccessResult:DiscoveryResult:ServiceList
                                    traverse List:List:Member:DiscoveredService
                                        where state = "RUNNING"
                                            and cmdline = "%process.cmd%"
                                            and name matches regex "%svc_rx%"");
        if size(services) = 0 then
            log.warn("Correct service for %type% is not running, stopping...");
            stop;
        end if;

        version:= none;
        pr_version:= none;
        
        name := "%type% on %host.name%";
        key := text.hash("%type%/%host.key%");

        packages := model.findPackages(host, pkg_rx);
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
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "%type%_sis");
        
        return si;

    end define;

end definitions;

pattern Traversys_SI_ArcGIS_Appserver 1.0
    '''
        Esri ArcGIS.
        
        Change History:
        2015-02-10 | 1.0 | WF | Created.
    
    '''
    metadata
        publishers      := 'Esri';
        products        := 'ArcGIS';
        urls            := 'https://hub.arcgis.com';
        categories      := 'GIS Mapping Software';
        known_versions  := '0';
    end metadata;
    
    overview
        tags arcgis, esri, custom, traversys;
    end overview;
    
    constants
        type := 'Esri ArcGIS Application Server';
    end constants;

    triggers
        on proc:= DiscoveredProcess where cmd matches windows_cmd 'beasvc';

    end triggers;

    body

        si := tsys_agis.process2si(proc, type, "\besridomain_AdminServer", [ regex "ArcGIS\sArcIMS" ]);
        
        // Associated processes
        all_procs:= discovery.allProcesses(proc);
        related_procs:= search(in all_procs
                                where cmd matches windows_cmd 'Aims_AppServer'
                                    or cmd matches windows_cmd 'Aims_Tasker');
        inference.associate(si, related_procs);
        
    end body;

end pattern;


pattern Traversys_SI_ArcGIS_Object_Man 1.0
    '''
    Esri ArcGIS Object Manager.
    
    Change History:
    2015-02-10 | 1.0 | WF | Created.
    
    '''
    metadata
        publishers      := 'Esri';
        products        := 'ArcGIS';
        urls            := 'https://hub.arcgis.com';
        categories      := 'GIS Mapping Software';
        known_versions  := '0';
    end metadata;
    
    overview
        tags arcgis, appserver, custom, esri, traversys;
    end overview;
    
    constants
        type := 'Esri ArcGIS Object Manager';
    end constants;

    triggers
        on proc:= DiscoveredProcess where cmd matches windows_cmd 'ArcSOCMon' or cmd matches windows_cmd 'ArcSOM';

    end triggers;

    body

        si := tsys_agis.process2si(proc, type, "Arc(ServerObjectManager|SOCMonitor)",
                                    [ regex "ArcGIS\sServer",
                                      regex "Esri\sUK\sPDF\sPrint\sWeb",
                                      regex "Esri\sUK\sLinear\sRef\sWeb",
                                      regex "Esri\sUK\sIIM\sWeb\sService",
                                      regex "Esri\sUK\sQuick\sAddress\sWeb\sService",
                                      regex "Esri\sUK\sADValidationWebService",
                                      regex "ArcServerObjectManager",
                                      regex "ArcSOCMonitor" ]);
                
    end body;

end pattern;


pattern Traversys_SI_ArcGIS_GeoRINM 1.0
    '''
    Esri ArcGIS GeoRINM Server.
    
    Change History:
    2015-02-10 | 1.0 | WF | Created.
    
    '''
    metadata
        publishers      := 'Esri';
        products        := 'ArcGIS';
        urls            := 'https://hub.arcgis.com';
        categories      := 'GIS Mapping Software';
        known_versions  := '0';
    end metadata;
    
    overview
        tags arcgis, georinm, custom, esri, traversys;
    end overview;
    
    constants
        type := 'Esri ArcGIS GeoRINM Server';
    end constants;

    triggers
        on proc:= DiscoveredProcess where cmd matches windows_cmd 'Geocortex\.Agent\.Runner';
    end triggers;

    body

        si := tsys_agis.process2si(proc, type, "GeocortexAgent", [ regex "Geocortex\sEssentials" ]);
        
    end body;

end pattern;

identify ArcGIS 1.0
    tags ArcGIS;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'beasvc' -> "traversys", "Esri ArcGIS Application Server";
    windows_cmd 'Aims_AppServer' -> "traversys", "Esri ArcGIS Application Server";
    windows_cmd 'Aims_Tasker' -> "traversys", "Esri ArcGIS Application Server";
    windows_cmd 'ArcSOCMon' -> "traversys", "Esri ArcGIS Object Manager";
    windows_cmd 'ArcSOM' -> "traversys", "Esri ArcGIS Object Manager";
    windows_cmd 'Geocortex\.Agent\.Runner' -> "traversys", "Esri ArcGIS GeoRINM Server";end identify;
