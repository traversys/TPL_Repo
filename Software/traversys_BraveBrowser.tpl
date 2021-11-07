tpl 1.9 module traversys_Brave;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Brave Software', 'Brave Browser';
end metadata;

pattern Traversys_SI_BraveBrowser 1.0
    """
    Models Brave Browser.
    
    Change History:
    2021-11-07 | 1.0 | WF | Created.
    
    """
    metadata
        publishers      := 'Brave Software';
        products        := 'Brave Browser';
        urls            := 'https://brave.com/';
        categories      := 'Web Browser';
    end metadata;

    overview
        tags traversys, custom, brave, browser;
    end overview;
    
    constants
        type := "Brave Browser";
    end constants;
    
    triggers
        on p := DiscoveredProcess where cmd matches unix_cmd "bash"
                                    and args matches regex "\bbrave-browser";
    end triggers;
    
    body

        h := related.host(p);
        v := void;
        pv:= void;
        d := void;
        cv:= void;
        a := [];
        
        n := "%type% on %h.name%";
        k := text.hash("%type%/%h.key%");

        packages := model.findPackages(h, [ regex '(?i)brave-browser' ]);
        for pkg in packages do
            if "version" in pkg then
                if pkg.version > v then
                    v := pkg.version;
                    pv:= regex.extract(v, regex "(\d+(?:\.\d+)?)", raw "\1", no_match:= v);
                    n := '%type% %pv% on %h.name%';
                end if;
            end if;
            if "description" in pkg then
                d:= pkg.description;
                list.append(a, "description");
            end if;
        end for;

        // Get Chromium Version
        vc:= discovery.runCommand(h, "brave-browser --version");
        if vc and vc.result then
            cv:= regex.extract(vc.result, "Brave\sBrowser\s(\d+(?:\.\d+)+)", raw "\1", no_match:= vc.result);
            list.append(a, "chromium_version");
        end if;
        
        si:= model.SoftwareInstance(
                                    key             := k,
                                    type            := type,
                                    name            := n,
                                    version         := v,
                                    product_version := pv,
                                    chromium_version:= cv,
                                    description     := d,
                                    _traversys      := true
                                    );
        model.setRemovalGroup(si, "%type%_sis");
        model.addDisplayAttribute(si, a);

        // Associated Processes
        ps:= discovery.allProcesses(p);
        rps:= search(in ps where cmd matches regex "\bbrave$"
                            or cmd matches regex "\bbrave/crashpad_handler");
        inference.associate(si, rps);
        
    end body;

end pattern;

identify BraveBrowser_cmd 1.0
    tags brave, browser;
    DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'brave' -> 'traversys', 'Brave Web Browser';
end identify;

identify BraveBrowser_all 1.0
    tags brave, browser;
    DiscoveredProcess cmd, args -> set_by, simple_identity;
    unix_cmd 'bash', regex '\bbrave-browser' -> 'traversys', 'Brave Web Browser';
end identify;