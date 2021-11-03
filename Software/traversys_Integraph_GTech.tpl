tpl 1.6 module traversys_Integraph_Gtech;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Intergraph G/Technology';
end metadata;

definitions tsys_ig 1.0
    """
        Custom Functions for Integraph.

        Author: Wes Moskal-Fitzpatrick

        Change History:
        2015-06-15 | 1.0 | WMF | Created

    """
    
    define service2si(service, type, pkg_rx) -> si
        """
            Generate an SI based on DiscoveredService.
        """

        host:= related.host(service);
        all_procs:= discovery.allProcesses(service);
        version:= none;
        pr_version:= none;
        
        name := "%type% on %host.name%";
        key := text.hash("%type%/%host.name%");

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
                                    cmd:= service.cmdline,
                                    pid:= service.pid,
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "sis");
        
        pp:= search(in all_procs where pid = %service.pid%);
        inference.primary(si, pp);
        
        return si;

    end define;

    define process2si(process, type, pkg_rx) -> si
        """
            Generate an SI based on DiscoveredProcess.
        """

        host:= related.host(process);
        all_procs:= discovery.allProcesses(process);
        version:= none;
        pr_version:= none;
        
        name := "%type% on %host.name%";
        key := text.hash("%type%/%host.name%");

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
        model.setRemovalGroup(si, "sis");
        
        return si;

    end define;

end definitions;

pattern Traversys_SI_GTech 1.0
    """
        Intergraph G/Technology.

        This pattern will loop through the services and generate SIs.

        Change History:
        2015-06-15 | 1.0 | WMF | Created.

    """

    overview
        tags gtechnology, gis, integraph, traversys;
    end overview;

    metadata
        products := 'Integrapth G/Technology';
        urls := 'https://www.hexagonsafetyinfrastructure.com/products/utilities-and-communications-products/advanced-utility-gis/intergraph-gtechnology';
        publishers  := "Hexagon Safety & Infrastructure";
        categories := 'Geographical Information System Mapping';
        known_versions := '0';
    end metadata;

    triggers
        on service:= DiscoveredService where (name matches regex "^(?i)intergraph"
                                            or display_name matches regex "^(?i)intergraph")
                                                and state = "RUNNING";
    end triggers;

    body

        si:= service2si(service, type, [ regex '^(?i)intergraph' ]);

        if service.display_name matches "Intergraph G/Technology Mobile Service" then
            // Add associated PublishMapFiles process
            gtmob:= search(in all_procs where cmd matches windows_cmd "ImportToOracleDBConsole"
                                            or cmd matches windows_cmd "PublishSubsetService");
            inference.associate(si, gtmob);
        end if;
        
    end body;

end pattern;


pattern Traversys_SI_PDS 1.0
    """
        Intergraph Persisted Delta Service.

        Change History:
        2015-06-15 | 1.0 | WMF | Created.

    """

    metadata
        products := 'Integrapth G/Technology', 'Persisted Delta Service';
        publishers  := "Hexagon Safety & Infrastructure";
        categories := 'Geographical Information System Mapping';
        known_versions := '0';
    end metadata;

    overview
        tags gtechnology, gis, intergraph, traversys;
    end overview;
    
    constants
        type := "Intergraph G/Technology Persisted Deltas Service";
    end constants;

    triggers
        on service:= DiscoveredService where display_name = "CreatePersistedDeltas" and state = "RUNNING";
    end triggers;

    body

        si:= service2si(service, type, [ regex '^(?i)intergraph', regex '(?i)DDCInstaller', regex '(?i)DDC Components' ]);
        
    end body;

end pattern;


pattern Traversys_Intergraph_Publish 1.0
    """
        PublishMapFiles process.

        Change History:
        2015-06-15 | 1.0 | WMF | Created.

    """

    metadata
        products := 'Integrapth G/Technology', 'Map Publisher';
        publishers  := "Hexagon Safety & Infrastructure";
        categories := 'Geographical Information System Mapping';
        known_versions := '6.0';
    end metadata;

    overview
        tags gtechnology, gis, intergraph, traversys;
    end overview;
    
    constants
        type := "Intergraph Map Publisher";
    end constants;

    triggers
        on process:= DiscoveredProcess where cmd matches windows_cmd "PublishMapFiles";
    end triggers;

    body

        si:= process2si(process, type, [ regex '(?i)Intergraph' ]);
   
        if process.args then
            dbsid:= regex.extract(process.args, regex "@(\S+)", raw "\1");
        end if;

        si.rdbms_connection_string:= dbsid;

        dbs:= search(SoftwareInstance where instance = %db_sid%);
        if size(dbs) >0 then
            model.rel.Communication(Server := dbs, Client := si);
        end if;

    end body;

end pattern;


pattern Traversys_GNetviewer 1.0
    """
        Model GNetviewer.

        Change History:
        2015-06-15 | 1.0 | WMF | Created.

    """

    metadata
        products := 'Integrapth G/Technology', 'G/Netviewer';
        publishers  := "Hexagon Safety & Infrastructure";
        categories := 'Geographical Information System Mapping';
        known_versions := '0';
    end metadata;

    overview
        tags gtechnology, gis, intergraph, traversys;
    end overview;
    
    constants
        type:= "Intergraph G/Netviewer";
    end constants;

    triggers
        on process:= DiscoveredProcess where cmd matches windows_cmd "MapServer";
    end triggers;

    body

        si:= process2si(process, type, [ regex '^(?i)G/?Net' ]);
   
        all_procs:= discovery.allProcesses(process);
        ingr:= search(in all_procs where cmd matches windows_cmd "IngrViewer");
        inference.associate(si, ingr);
        
        gweb:= search(in host traverse :::SoftwareInstance where type = "Intergraph G/Technology MapServer Manager Service");
        model.addContainment(si, gweb);
                
    end body;

end pattern;

pattern Traversys_GNetPlotServer 1.0
    """
        Model NetPlot service.

        Change History:
        2015-06-15 | 1.0 | WMF | Created.

    """

    metadata
        products := 'Integrapth G/Technology', 'NetPlot';
        publishers  := "Hexagon Safety & Infrastructure";
        categories := 'Geographical Information System Mapping';
        known_versions := '10.0.1';
    end metadata;

    overview
        tags gtechnology, gis, intergraph, traversys;
    end overview;

    constants
        type:= "Intergraph G/Technology NetPlot Server";
    end constants;

    triggers
        on process:= DiscoveredProcess where cmd matches windows_cmd "G3E" or
                                             cmd matches windows_cmd "OSMasterMapSchemaManager" or
                                             cmd matches windows_cmd "NetPlotService";
    end triggers;

    body

        // If the service is already modelled, don't model this.
        existing:= search(in host traverse :::SoftwareInstance where type = %type%);
        if size(existing) > 0 then
            stop;
        end if;

        si:= process2si(process, type, [ regex '^(?i)G/?Net' ]);
   
    end body;

end pattern;


identify Intergraph 1.0
    tags Intergraph;
    DiscoveredProcess cmd -> simple_identity;
    windows_cmd "CreatePersistedDeltas" -> "Intergraph G/Technology Persisted Delta Service";
    windows_cmd "EW.Scheduler" -> "Intergraph G!NIUS Scheduling Service";
    windows_cmd "Intergraph.GWaterUK.PI.Geot.Service.exe" -> "Intergraph G/Technology GeoTesselation Service";
    windows_cmd "PublishMapFiles" -> "Intergraph G/Technology Map Publisher";
    windows_cmd "UserManagementWindowsServices" -> "Intergraph G/Technology User Management Service";
    windows_cmd "UserManagementWindowsService" -> "Intergraph G/Technology User Management Service";
    windows_cmd "AuthorizationManagerWindowsService" -> "Intergraph G/Technology Authorization Service";
    windows_cmd "ImportToOracleDBConsole" -> "Intergraph G/Technology Mobile Servive";
    windows_cmd "PublishSubsetService" -> "Intergraph G/Technology Mobile Service";
    windows_cmd "GNWebMgr" -> "Intergraph G/Technology Web Manager";
    windows_cmd "IngrViewer" -> "Intergraph G/Netviewer Application Client";
    windows_cmd "MapServer" -> "Intergraph G/Netviewer Application Server";
    windows_cmd "NetPlotService" -> "Intergraph G/Netviewer Plot Service";
    windows_cmd "G3E" -> "Intergraph G/Netviewer Plot Server";
    windows_cmd "OSMasterMapSchemaManager" -> "Intergraph G/Netviewer Plot Server";
end identify;

// The MIT License (MIT)

// Copyright Wes Fitzpatrick 2015

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.