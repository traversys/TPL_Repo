tpl 1.19 module traversys_Syncthing;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Syncthing Foundation', 'Syncthing';
end metadata;

definitions special 1.0
	""" 
        Special Functions.

        Author: Wes Moskal-Fitzpatrick

        Change History:
        2014-11-12 | 1.0 | WMF | Created
    """

    define slashes(host) -> slash
        """
            Set direction of slashes for filepaths.
        """
        slash := "/"; // Linux
        if host.os_type = "Windows" then
            slash := "\\";
        end if;
    
        return slash;

    end define;

    define xpathEvaluate(xmldoc, path) -> single_value, list_value, success
        """
            Return both list and singular results.
        """
    
        list_value   := xpath.evaluate(xmldoc, path);
        single_value := none;
        success      := false;
        if size(list_value) > 0 then
            single_value:= list_value[0];
            success:= true;
        end if;

        return single_value, list_value, success;

    end define;

    define getPackages(host, match_list) -> version, product_version, revision, build, description, display
        """
            Get the best package and other details.
        """

        version         := void;
        product_version := void;
        revision        := void;
        build           := void;
        description     := void;
        display         := [];

        packages := model.findPackages(host, match_list);
        for pkg in packages do
            if "version" in pkg then
                if pkg.version > version then
                    version := pkg.version;
                    product_version:= regex.extract(version, regex "(\d+(?:\.\d+)?)", raw "\1", no_match:= version);
                    list.append(display, "version");
                    list.append(display, "product_version");
                    if "revision" in pkg then
                        revision := pkg.revision;
                        list.append(display, "revision");
                    end if;
                    if "description" in pkg then
                        description:= pkg.description;
                        list.append(display, "description");
                    end if;
                    if "build" in pkg then
                        build := pkg.build;
                        list.append(display, "build");
                    end if;
                end if;
            end if;
        end for;

        return version, product_version, revision, build, description, display;

    end define;

    define getFileContent(host, config_file) -> file, content, success
    """
        Get and validate the config file.
    """
    
        file    := discovery.fileGet(host, config_file);
        content := none;
        success := false;
        if file and file.content then
            log.debug("Found config file: %file.path%");
            success:= true;
            content:= file.content;
        end if;

        return file, content, success;

    end define;

    define displayAttribute(node, attr, value)
        """
            Add a list of attributes or void them.
        """
        adt:= datatype(value);
        if adt = "void" then
            node[attr]:= void;
            log.debug("Attribute %attr% is void.");
        elif adt = "none" then
            node[attr]:= void;
            log.debug("Attribute %attr% is none.");
        elif adt = "list" then
            if size(adt) > 0 then
                node[attr]:= value;
                model.addDisplayAttribute(node, attr);
            else
                node[attr]:= void;
                log.debug("Attribute list %attr% is empty.");
            end if;
        elif adt = "node" then
            log.warn("Attribute %attr% is a node.");
            node[attr]:= void;
        elif adt = "relationship" then
            log.warn("Attribute %attr% is a relationship.");
            node[attr]:= void;
        elif adt = "nodeset" then
            log.warn("Attribute %attr% is a nodeset.");
            node[attr]:= void;
        elif adt = "unknown" then
            log.warn("Setting attribute %attr% (unknown data type).");
            node[attr]:= value;
            model.addDisplayAttribute(node, attr);
        else
            node[attr]:= value;
            model.addDisplayAttribute(node, attr);
        end if;

    end define;
	
end definitions;

definitions syncthing 1.0
	""" 
        Custom Functions related to Syncthing.

        Author: Wes Moskal-Fitzpatrick

        Change History:
        2014-11-12 | 1.0 | WMF | Created
    """

    define getAPIKey(config_data) -> api_key, local_port
        """
            Get API key from config file.
        """

        api_key:= none;
        local_port:= none;

        if config_data then
            xmldoc:=xpath.openDocument(config_data);
            gui_address, gui_address_lst, ok:= special.xpathEvaluate(xmldoc,'/configuration/gui/address/text()');
            if ok then
                local_port:= regex.extract(gui_address, regex '\w+:(\d+)', raw "\1");
                log.debug("Found port: %local_port%");
            end if;
            if local_port then
                api_key, api_key_lst, ok:= special.xpathEvaluate(xmldoc,'/configuration/gui/apikey/text()');
                if ok then
                    log.debug("Found API key");
                end if;
            end if;
            xpath.closeDocument(xmldoc);
        end if;

        return api_key, local_port;

    end define;

    define getconfigFile(host,si,process) -> xmlfile, xmldoc, ok
        """
            Get API key from config file.

            Syncthing can have many config files all over the system
            but only one specifically will contain API Key details.
        """

        cmd:= process.cmd;
        slash:= special.slashes(host);
        xmlfile:= none;
        xmldoc:= none;
        ok:= false;

        paths:= discovery.runCommand(host, cmd + " --paths");
        if paths and paths.result then
            cf:= regex.extract(paths.result, regex "((\w:)?((\\|/).*)+(\\|/)config.xml)", raw "\1");
            log.debug("Potential config file (paths): %cf%");
            if cf then // Most trustworthy path
                xmlfile, xmldoc, ok:= special.getFileContent(host, cf);
                if ok then
                    log.debug("Found config file (paths): %cf%");
                    special.displayAttribute(si, "config_file", cf);
                else // Switch out user - in case this doesn't match Discovery login
                    // Syncthing paths command will output a path configured to the current
                    // user regardless of actual existence
                    usr:= regex.extract(cmd, regex "\\Users\\(\S+?)\\", raw "\1");
                    drive:= regex.extract(cf, regex "^(.*\\Users\\)", raw "\1");
                    path:= regex.extract(cf, regex "\\Users\\\S+?(\\.+)", raw "\1");
                    newcf:= "%drive%%usr%%path%";
                    log.debug("Potential config file (user): %newcf%");
                    xmlfile, xmldoc, ok:= special.getFileContent(host, newcf);
                    if ok then
                        log.debug("Found config file (user): %newcf%");
                        special.displayAttribute(si, "config_file", newcf);
                    elif 'root_dir' in si then // Use -home flag
                        cf:= si.root_dir + slash + "config.xml";
                        log.debug("Potential config file (home): %cf%");
                        xmlfile, xmldoc, ok:= special.getFileContent(host, cf);
                        if ok then
                            log.debug("Found config file (root): %cf%");
                            special.displayAttribute(si, "config_file", cf);
                        else
                            log.warn("No config file found!");
                        end if;
                    end if;
                end if;
            end if;
        end if;

        return xmlfile, xmldoc, ok;

    end define;

    define apiCall(host, target, endpoint, api_key, port) -> response_body, response_status, success
        """
            Make an API call to a Syncthing endpoint.
        """
        headers:= table();
        response_body:= none;
        response_status:= none;
        success:= false;

        headers['X-API-Key']:= api_key;
        res:= discovery.restfulGet(target, '', endpoint, headers:=headers, port:=port);
        // Syncthing configuration for accesss outside of the local system requires the
        // address to be set to 0.0.0.0
        if res then
            response_status:= res.response_status;
            if response_status = 200 then
                response_body:= res.response_body;
                log.debug("Response: %response_status%");
                success:= true;
            end if;
        end if;
        if not success then // Try to run locally
            // Syncthing by default best practice is locked to localhost access
            url:= "https://127.0.0.1:%port%%endpoint%";
            log.debug("Making curl GET request to %url%...");
            if host.os_type = "Windows" then
                res:= discovery.runPowerShell(target, 'curl.exe --silent -k -X GET -H "X-API-Key: %api_key%" %url%');
            else
                res:= discovery.runCommand(target, 'curl --silent -k -X GET -H "X-API-Key: %api_key%" %url%');
            end if;
            if res and res.result then
                response_body:= res.result;
                log.debug("Curl success.");
                success:= true;
            end if;
        end if;

        return response_body, response_status, success;

    end define;
	
end definitions;


pattern Traversys_SI_Syncthing 1.0
    """
    Models an instance of Syncthing.
    
    Change History:
    2021-11-07 | 1.0 | WF | Created.
    
    """
    metadata
        publishers := 'Syncthing Foundation';
        products   := 'Syncthing';
        urls       := 'https://syncthing.net/';
        categories := 'Continuous File Synchronisation';
    end metadata;

    overview
        tags traversys, custom, syncthing;
    end overview;
    
    constants
        type := "Syncthing";
    end constants;
    
    triggers
        on p := DiscoveredProcess where cmd matches unix_cmd "syncthing"
                                        or cmd matches windows_cmd "syncthing";
    end triggers;
    
    body

        h         := related.host(p);
        da        := discovery.access();
        to_display:= [];
        ports     := [];

        n := "%type% on %h.name%";
        log.debug("Default name: %n%");
        k := text.hash("%type%/%h.key%");

        v, pv, r, b, d, to_display:= special.getPackages(h, [ regex '(?i)syncthing' ]);
        if not datatype(pv) = "void" then
            n := '%type% %pv% on %h.name%';
            log.debug("Package name: %n%");
        end if;

        si := model.SoftwareInstance(
                                    key             := k,
                                    type            := type,
                                    name            := n,
                                    version         := v,
                                    product_version := pv,
                                    revision        := r,
                                    build           := b,
                                    description     := d,
                                    _traversys      := true
                                    );
        model.setRemovalGroup(si, "%type%_sis");
        log.debug("Check1 SI: %si.name%");

        // Local Port
        local_port:= regex.extract(p.args, regex 'gui-address="\w+:(\d+)"', raw "\1");
        if local_port then
            special.displayAttribute(si, "local_port", local_port);
            log.debug("Local port set to: %local_port%");
        end if;
        log.debug("Check2 SI: %si.name%");

        // Listening Ports
        listeners:= search(in p processwith communicationForProcesses(2));
        for lsr in listeners do
            list.append(ports, lsr.local_port);
            if lsr.local_ip_addr = "127.0.0.1" then
                if not local_port then
                    local_port:= lsr.local_port;
                    special.displayAttribute(si, "local_port", local_port);
                    log.debug("Local port set to: %local_port%");
                end if;
            end if;
            special.displayAttribute(si, "listening_ports", ports);
        end for;
        log.debug("Check3 SI: %si.name%");

        // Get Device ID
        dev_id := discovery.runCommand(h, p.cmd + " --device-id");
        if dev_id and dev_id.result then
            log.debug("Device ID from runcmd: %dev_id.result%");
            id:= text.strip(dev_id.result);
            special.displayAttribute(si, "device_id", id);
        end if;
        log.debug("Check4 SI: %si.name%");

        home:= regex.extract(p.args, regex "home=((\w:)?((\\|/).*)+(\\|/)?)", raw "\1");
        if not home then
            home:= regex.extract(p.cmd, regex "((\w:)?((\\|/).*)+(\\|/))", raw "\1");
        end if;
        if home then
            special.displayAttribute(si, "root_dir", home);
        end if;
        log.debug("Check5 SI: %si.name%");

        // Get config
        xfnode, xmldoc, ok:= syncthing.getconfigFile(h,si,p);
        
        // Get API key and API call
        if ok then
            api_key, api_port:= syncthing.getAPIKey(xmldoc);
            if not local_port then
                local_port:= api_port;
                special.displayAttribute(si, "local_port", local_port);
            end if;
            if api_key and local_port then
                response_body, response_status, ok:= syncthing.apiCall(h, da, '/rest/system/version', api_key, local_port);
                if ok then
                    jsondoc:= json.decode(response_body);
                    if datatype(pv) = "void" then
                        v:= jsondoc['version'];
                        pv:= regex.extract(v, regex "(\d+(?:\.\d+)?)", raw "\1", no_match:= v);
                        si.version:= v;
                        si.product_version:= pv;
                        si.name := '%type% %pv% on %h.name%';
                        log.debug("Config name: %si.name%");
                        special.displayAttribute(si, "release", jsondoc['codename']);
                    end if;
                end if;
                response_body, response_status, ok:= syncthing.apiCall(h, da, '/rest/config/devices', api_key, api_port);
                if ok then
                    jsondoc:= json.decode(response_body);
                    for device in jsondoc do   
                        device_name:= device['name'];
                        log.debug("Device Name: %device_name%");
                        candidate_hosts:= search(Host where name matches regex "^(?i)device_name");
                        sync_clients:= [];
                        for candidate_host in candidate_hosts do
                            if candidate_host.name = h.name then
                                // This is the current Host
                                continue;
                            else
                                list.append(sync_clients, candidate_host.name);
                                candidate_sis:= search(in candidate_hosts
                                                        traverse Host:HostedSoftware:RunningSoftware:SoftwareInstance
                                                            where type = "Syncthing");
                                for candidate_si in candidate_sis do
                                    model.rel.Communication(Peer:= candidate_si, Peer:= si);
                                end for;
                            end if;
                        end for;
                        if size(sync_clients) > 0 then
                            special.displayAttribute(si, "sync_clients", sync_clients);
                        end if;
                    end for;
                end if;
                response_body, response_status, ok:= syncthing.apiCall(h, da, '/rest/svc/deviceid', api_key, api_port);
                if ok then
                    jsondoc:= json.decode(response_body);
                    deviceid:= jsondoc['id'];
                    if deviceid then
                        log.debug("Device ID set by API: %deviceid%");
                        special.displayAttribute(si, "device_id", deviceid);
                    else
                        response_body, response_status, ok:= syncthing.apiCall(h, da, '/rest/config', api_key, api_port);
                        if ok then
                            jsondoc:= json.decode(response_body);
                            if 'defaults' in jsondoc then
                                defaults:= jsondoc['defaults'];
                                deviceid:= defaults['device']['deviceID'];
                                if deviceid then
                                    log.debug("Device ID set by API config: %deviceid%");
                                    special.displayAttribute(si, "device_id", deviceid);
                                elif 'folder' in defaults then
                                    folder:= defaults['folder'];
                                    deviceid:= folder['devices'][0]['deviceID'];
                                    log.debug("Device ID set by API folder: %deviceid%");
                                    special.displayAttribute(si, "device_id", deviceid);
                                end if;
                            end if;
                        end if;
                    end if;
                end if;
                // Build Clusters around Folder IDs
                // Syncthing does not have a "central" fileserver, so it's possible to configure
                // connections with peers on a folder-by-folder basis, which means multiple devices
                // Could be syncing with other devices and not be known to each other.
                response_body, response_status, ok:= syncthing.apiCall(h, da, '/rest/config/folders', api_key, api_port);
                if ok then
                    jsondoc:= json.decode(response_body);
                    for folder in jsondoc do
                        folder_id:= folder['id'];
                        log.debug("Working on folder: %folder_id%");
                        label:= folder['label'];
                        devices:= folder['devices'];
                        for device in devices do
                            device_id:= device['deviceID'];
                            log.debug("Found Device ID: %device_id%");
                            stsis:= search(SoftwareInstance where type = "Syncthing" and device_id = "%device_id%");
                            for stsi in stsis do
                                sc:= model.SoftwareCluster(
                                                        key       := "%type%/%folder_id%",
                                                        name      := "Syncthing Folder %label% (%folder_id%)",
                                                        type      := "Syncthing Folder",
                                                        instance  := folder_id,
                                                        _traversys:= true
                                );
                                log.info("Created a Cluster for Syncthing %label%");
                                model.addContainment(sc,stsi);
                                model.addContainment(sc,si);
                                model.setRemovalGroup(sc);
                            end for;
                        end for;
                    end for;
                end if;
            end if;
        end if;
        log.debug("Check6 SI: %si.name%");

        // Get Detailed Version Info
        ver := discovery.runCommand(h, p.cmd + " --version");
        if ver and ver.result then
            if datatype(pv) = "void" then
                v := regex.extract(ver.result, regex "v(\d+(?:\.\d+)+(-\w+\d+)?)", raw "\1");
                pv:= regex.extract(v, regex "(\d+(?:\.\d+)?)", raw "\1", no_match:= v);
                si.version:= v;
                si.product_version:= pv;
                si.name := '%type% %pv% on %h.name%';
                log.debug("Config name: %si.name%");
                release:= regex.extract(ver.result, regex '"((\w+\s?)+)"', raw "\1");
                if release then
                    special.displayAttribute(si, "release", release);
                end if;
            end if;
        end if;
        log.debug("Check7 SI: %si.name%");

        // Get Network Connections
        ncs:= search(in p processwith communicationForProcesses(1));
        for nc in ncs do
            rem_ip := nc.remote_ip_addr;
            eps:= search(DiscoveryAccess where endpoint = "%rem_ip%");
            for ep in eps do
                inf_host:= search(in ep traverse Associate:Inference:InferredElement:Host);
                for ih in inf_host do
                    candidate_sis:= search(in ih
                                            traverse Host:HostedSoftware:RunningSoftware:SoftwareInstance
                                                where type = "Syncthing");
                    cansis:= size(candidate_sis);
                    log.debug("Candidate SIs found: %cansis%");
                    for candidate_si in candidate_sis do
                        log.debug("Candidate SI: %candidate_si.name%");
                        log.debug("SI: %si.name%");
                        model.rel.Communication(Server:= candidate_si, Client:= si);
                    end for;
                end for;
            end for;
        end for;

        // Associated Processes
        ps:= discovery.allProcesses(p);
        rps:= search(in ps where cmd matches windows_cmd "SyncTrayzor");
        for rp in rps do
            inference.associate(si, rp);
        end for;
        
    end body;

end pattern;


pattern Traversys_SI_SyncTrayzor 1.0
    """
    Models an instance of SyncTrayzor.
    
    Change History:
    2021-11-09 | 1.0 | WF | Created.
    
    """
    metadata
        publishers := 'canton7';
        products   := 'SyncTrayzor';
        urls       := 'https://github.com/canton7/SyncTrayzor';
        categories := 'Continuous File Synchronisation';
    end metadata;

    overview
        tags traversys, custom, syncthing, synctrayzor;
    end overview;
    
    constants
        type := "SyncTrayzor";
    end constants;
    
    triggers
        on p := DiscoveredProcess where cmd matches windows_cmd "SyncTrayzor";
    end triggers;
    
    body

        h  := related.host(p);
        n  := "%type% on %h.name%";
        k  := text.hash("%type%/%h.key%");
        rd := void;
        a  := [];

        slash:= special.slashes(h);
        v, pv, r, b, d, a:= special.getPackages(h, [ regex '(?i)SyncTrayzor' ]);
        if pv then
            n := '%type% %pv% on %h.name%';
        end if;

        rd:= regex.extract(p.cmd, regex "((\w:)?((\\|/).*)+(\\|/))", raw "\1");
        if not datatype(rd) = "void" then
            xf:= discovery.fileGet(h, rd + "SyncTrayzor.exe.config");
            if xf and xf.content then
                x:= xf.content;
                //TODO: Do some XML stuff
            end if;
        end if;

        si := model.SoftwareInstance(
                                    key             := k,
                                    type            := type,
                                    name            := n,
                                    version         := v,
                                    product_version := pv,
                                    revision        := r,
                                    description     := d,
                                    _traversys      := true
                                    );
        model.setRemovalGroup(si, "%type%_sis");
        model.addDisplayAttribute(si, a);

        // Relate to Syncthing
        stp:= discovery.descendents(p);
        sts:= search(in stp traverse Primary:Inference:InferredElement:SoftwareInstance);
        for st in sts do
            log.debug("Adding management relationship for %st.name%...");
            model.rel.Management(Manager:= si, ManagedElement:= st);
        end for;
        inference.associate(si, stp);
        
    end body;

end pattern;


identify Syncthing 1.0
    tags Syncthing;
    DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'syncthing' -> 'traversys', 'Syncthing';
    windows_cmd 'syncthing' -> 'traversys', 'Syncthing';
    windows_cmd 'SyncTrayzor' -> 'traversys', 'SyncTrayzor';
end identify;