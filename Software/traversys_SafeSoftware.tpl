tpl 1.9 module traversys_SafeSoftware_FME;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Safe Software', 'FME';
end metadata;

pattern Traversys_FME 1.0
    """
        Safe Software FME Platform.

        Change History:
        2015-06-15 | 1.0 | WMF | Created.

    """

    metadata
        products := 'FME';
        urls := 'https://www.safe.com/fme/#products';
        publishers  := "Safe Software";
        categories := 'Data Integration Platform';
        known_versions := 'Desktop', 'Server', 'Cloud';
    end metadata;

    overview
        tags safesoftware, fme, custom, traversys;
    end overview;

    triggers
        on service:= DiscoveredService where (name matches regex "^(?i)FME"
                                            or display_name matches regex "^(?i)FME")
                                                and state = "RUNNING";
    end triggers;

    body
        
        host:= related.host(service);
        all_procs:= discovery.allProcesses(service);
        version:= none;
        pr_version:= none;
        
        name := "%type% on %host.name%";
        key := text.hash("%type%/%host.name%");

        packages := model.findPackages(host, [ regex '^(?i)FME' ]);
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
                
    end body;

end pattern;


pattern Traversys_SI_FME_Workbench 1.0
    """
        Model FME Workbench.

        Change History:
        2015-06-15 | 1.0 | WMF | Created.

    """

    metadata
        products := 'FME Workbench';
        urls := 'https://www.safe.com/fme/#products';
        publishers  := "Safe Software";
        categories := 'Data Integration Platform';
        known_versions := '2018.0';
    end metadata;

    overview
        tags safesoftware, fme, custom, traversys;
    end overview;
    
    constants
        type:= "FME Workbench";
    end constants;

    triggers
        on process:= DiscoveredProcess where cmd matches windows_cmd "fmeworkbench";
    end triggers;

    body
   
        host:= related.host(process);
        all_procs:= discovery.allProcesses(process);
        version:= none;
        pr_version:= none;
        
        name := "%type% on %host.name%";
        key := text.hash("%type%/%host.name%");

        packages := model.findPackages(host, [ regex '^(?i)FME' ]);
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
                
    end body;

end pattern;

identify SafeSoftwareFME 1.0
    tags SafeSoftwareFME;
    DiscoveredProcess cmd -> simple_identity;
    windows_cmd "FMEServer_ApplicationServer" -> "FME Application Server";
    windows_cmd "FMEProcessMonitorEngines" -> "FME Server Engines";
    windows_cmd "FMEProcessMonitorCore" -> "FME Server Core";
    windows_cmd "pg_ctl" -> "FME Server Database";
    windows_cmd "fmeworkbench" -> "FME Workbench";
    windows_cmd "UltiDevCassinWebServer2" -> "UltiDev Cassini Web Server";
    regex "Intergraph.*\\lmgrd\.exe" -> "FME License Server";
    regex "FMEServer.*\\Wrapper\.exe" -> "FME SMTP Relay";
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