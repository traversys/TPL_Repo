tpl 1.9 module traversys_ArcIMS;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Esri', 'ArcIMS';
end metadata;

pattern Traversys_SI_ArcIMS 1.0
    '''
        Models ArcIMS.
        
        Change History:
        2013-10-06 | 1.0 | WF | Created.

    '''

    metadata
        products       := 'ArcIMS';
        urls           := "https://www.esri.com/news/arcuser/1000/arcims.html";
        publishers     := "Esri";
        categories     := 'Web Mapping';
        known_versions := '10';
    end metadata;

    overview
        tags traversys, esri, custom, arcims, gis;
    end overview;

    constants
        type:= "Esri ArcIMS";
    end constants;

    triggers
        on p := DiscoveredProcess where cmd matches windows_cmd 'aims_appserver';
    end triggers;

    body

        host := related.host(p);
        name := "%type% on %host.name%";
        key := text.hash("%type%/%host.key%");

        si_node := model.SoftwareInstance(
                                          key := key,
                                          name := name,
                                          type := type,
                                          _traversys:= true
                                          );
        model.setRemovalGroup(si, "%type%_sis");

        all_procs := discovery.allProcesses(p);

        // Relate processes to the SI
        related_procs := search(in all_procs where
                                cmd matches regex '(?i)(giomgr|esri|aims_tasker|aims_monitor).exe');
        inference.associate(si_node, related_procs);

    end body;

end pattern;

identify ArcIMS 1.0
    tags ArcIMS;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'giomgr'        -> 'traversys', 'Esri ArcIMS Application Connection Daemon';
    windows_cmd 'esri'          -> 'traversys', 'Esri ArcIMS Route Server';
    windows_cmd 'aims_appserver'-> 'traversys', 'Esri ArcIMS Application Server';
    windows_cmd 'aims_tasker'   -> 'traversys', 'Esri ArcIMS Tasker';
    windows_cmd 'aims_monitor'  -> 'traversys', 'Esri ArcIMS Monitor';end identify;
