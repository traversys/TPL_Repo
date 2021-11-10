tpl 1.19 module traversys_Syncthing;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Syncthing Foundation', 'Syncthing';
end metadata;

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

        h  := related.host(p);
        da := discovery.access();
        v  := void;
        pv := void;
        d  := void;
        cv := void;
        r  := void;
        id := void;
        rl := void;
        rd := void;
        llp:= void;
        cf := void;
        a  := [];
        lp := [];
        dl := [];
        x  := none;

        br := "/"; // Linux
        if h.os_type = "Windows" then
            br := "\\";
        end if;

        version:= datatype(v);
        log.debug("version: %version%");
        
        n := "%type% on %h.name%";
        k := text.hash("%type%/%h.key%");

        gui:= regex.extract(p.args, regex 'gui-address="\w+:(\d+)"', raw "\1");
        if gui then
            llp:= gui;
            list.append(a, "local_port");
        end if;

        rd:= regex.extract(p.cmd, regex "((\w:)?((\\|/).*)+(\\|/))", raw "\1");
        home:= regex.extract(p.args, regex "home=((\w:)?((\\|/).*)+(\\|/)?)", raw "\1");
        if not rd then
            rd:= home;
        end if;

        if not datatype(rd) = "void" then
            list.append(a, "root_dir");
            // Get config
            sp:= discovery.runCommand(h, p.cmd + " --paths");
            if sp and sp.result then
                cf:= regex.extract(sp.result, regex "((\w:)?((\\|/).*)+(\\|/)config.xml)", raw "\1");
                if cf then
                    list.append(a, "config_file");
                    xf:= discovery.fileGet(h, cf);
                    if xf and xf.content then
                        x:= xf.content;
                    else
                        xf:= discovery.fileGet(h, rd + "config.xml");
                        if xf and xf.content then
                            // TODO: something with this XML
                            x:= xf.content;
                        else
                            xf:= discovery.fileGet(h, home + br + "config.xml");
                            if xf and xf.content then
                                // TODO: something with this XML
                                x:= xf.content;
                            end if;
                        end if;
                    end if;
                end if;
            end if;
        end if;

        if x then
            xd:=xpath.openDocument(x);
            if not gui then
                add:= xpath.evaluate(xd,'/configuration/gui/address/text()');
                gui:= regex.extract(add[0], regex '\w+:(\d+)', raw "\1");
                if gui then
                    llp:= gui;
                    list.append(a, "local_port");
                    api:= xpath.evaluate(xd,'/configuration/gui/apikey/text()');
                    if api then
                        tok:= api[0];
                        headers:= table();
                        headers['X-API-Key']:= tok;
                        res:= discovery.restfulGet(da, '', '/rest/config', headers, port:=llp);
                        if res and res.response_status = "200" then
                            // API Stuff
                            bod:= res.response_body;
                            log.debug("Response: %res.response_status%");
                            log.debug("Body: %res.response_body%");
                        else // Try to run locally
                            res:= discovery.runCommand(da, 'curl -k -X GET -H "X-API-Key: %tok%" https://127.0.0.1:%llp%/rest/config');
                            if res and res.result then
                                bod:= res.result;
                            end if;
                        end if;
                    end if;
                end if;
            end if;
            xpath.closeDocument(xd);
        end if;

        packages := model.findPackages(h, [ regex '(?i)syncthing' ]);
        for pkg in packages do
            log.debug("Packages found.");
            if "version" in pkg then
                if pkg.version > v then
                    v := pkg.version;
                    log.debug("Packages version: %v%");
                    pv:= regex.extract(v, regex "(\d+(?:\.\d+)?)", raw "\1", no_match:= v);
                    n := '%type% %pv% on %h.name%';
                    if pkg.revision then
                        r := pkg.revision;
                        list.append(a, "revision");
                    end if;
                    if "description" in pkg then
                        d:= pkg.description;
                        list.append(a, "description");
                    end if;
                end if;
            end if;
        end for;

        // Listening Ports
        lps:= search(in p processwith communicationForProcesses(2));
        for l in lps do
            list.append(lp, l.local_port);
            list.append(a, "listening_ports");
            if l.local_ip_addr = "127.0.0.1" then
                if not llp then
                    // TODO: Some API stuff to happen here....
                    llp:= l.local_port;
                    list.append(a, "local_port");
                end if;
            end if;
        end for;

        // Get Device ID
        di := discovery.runCommand(h, p.cmd + " --device-id");
        //if h.os_type = "Windows" then
        //    di := discovery.runCommand(h, rd + "syncthing -device-id");
        //else
        //    di := discovery.runCommand(h, "syncthing -device-id");
        //end if;
        if di and di.result then
            log.debug("Device ID: %di.result%");
            id:= text.strip(di.result);
            list.append(a, "device_id");
        end if;

        // Get Detailed Version Info
        ver := discovery.runCommand(h, p.cmd + " --version");
        if ver and ver.result then
            if datatype(v) = "void" then
                v := regex.extract(ver.result, regex "v(\d+(?:\.\d+)+(-\w+\d+)?)", raw "\1");
                pv:= regex.extract(v, regex "(\d+(?:\.\d+)?)", raw "\1", no_match:= v);
                n := '%type% %pv% on %h.name%';
            end if;
            rl:= regex.extract(ver.result, regex '"((\w+\s?)+)"', raw "\1");
            list.append(a, "release");
        end if;
        
        si := model.SoftwareInstance(
                                    key             := k,
                                    type            := type,
                                    name            := n,
                                    version         := v,
                                    product_version := pv,
                                    revision        := r,
                                    release         := rl,
                                    description     := d,
                                    listening_ports := lp,
                                    local_port      := llp,
                                    device_id       := id,
                                    root_dir        := rd,
                                    config_file     := cf,
                                    _traversys      := true
                                    );
        model.setRemovalGroup(si, "%type%_sis");
        model.addDisplayAttribute(si, a);

        // Get Network Connections
        ncs:= search(in p processwith communicationForProcesses(1));
        for nc in ncs do
            ri := nc.remote_ip_addr;
            eps:= search(DiscoveryAccess where endpoint = "%ri%");
            for ep in eps do
                inf:= search(in ep traverse Associate:Inference:InferredElement:);
                for i in inf do
                    list.append(dl, i.name);
                end for;
            end for;
        end for;
        if size(dl) > 0 then
            si.sync_clients:= dl;
            model.addDisplayAttribute(si, "sync_clients");
        else
            si.sync_clients:= void;
        end if;

        // Associated Processes
        ps:= discovery.allProcesses(p);
        rps:= search(in ps where cmd matches windows_cmd "SyncTrayzor");
        inference.associate(si, rps);
        
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
        r  := void;
        v  := void;
        pv := void;
        d  := void;
        rd := void;
        a  := [];

        br := "/"; // Linux
        if h.os_type = "Windows" then
            br := "\\";
        end if;

        packages := model.findPackages(h, [ regex "(?i)SyncTrayzor" ]);
        for pkg in packages do
            if "version" in pkg then
                if pkg.version > v then
                    v := pkg.version;
                    pv:= regex.extract(v, regex "(\d+(?:\.\d+)?)", raw "\1", no_match:= v);
                    n := '%type% %pv% on %h.name%';
                    if pkg.revision then
                        r := pkg.revision;
                        list.append(a, "revision");
                    end if;
                    if "description" in pkg then
                        d:= pkg.description;
                        list.append(a, "description");
                    end if;
                end if;
            end if;
        end for;

        rd:= regex.extract(p.cmd, regex "((\w:)?((\\|/).*)+(\\|/))", raw "\1");
        if not datatype(rd) = "void" then
            xf:= discovery.fileGet(h, rd + br + "SyncTrayzor.exe.config");
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