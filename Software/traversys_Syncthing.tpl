tpl 1.9 module traversys_Syncthing;
    
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
        on p := DiscoveredProcess where cmd matches unix_cmd "syncthing";
    end triggers;
    
    body

        h  := related.host(p);
        v  := void;
        pv := void;
        d  := void;
        cv := void;
        r  := void;
        id := void;
        rl := void;
        llp:= void;
        a  := [];
        lp := [];
        dl := [];
        
        n := "%type% on %h.name%";
        k := text.hash("%type%/%h.key%");

        packages := model.findPackages(h, [ regex '(?i)syncthing' ]);
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

        // Listening Ports
        lps:= search(in p processwith communicationForProcesses(2));
        for l in lps do
            list.append(lp, l.local_port);
            list.append(a, "listening_ports");
            if l.local_ip_addr = "127.0.0.1" then
                // Some API stuff to happen here....
                llp:= l.local_port;
                list.append(a, "local_port");
            end if;
        end for;

        // Get Device ID
        di := discovery.runCommand(h, "syncthing -device-id");
        if di and di.result then
            id:= text.strip(di.result);
            list.append(a, "device_id");
        end if;

        // Get Detailed Version Info
        ver := discovery.runCommand(h, "syncthing -version");
        if ver and ver.result then
            if not v then
                v := regex.extract(ver.result, regex "v(\d+(?:\.\d+)+(-\w+\d+))", raw "\1");
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
        
    end body;

end pattern;

identify Syncthing 1.0
    tags Syncthing;
    DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'syncthing' -> 'traversys', 'Syncthing';
end identify;