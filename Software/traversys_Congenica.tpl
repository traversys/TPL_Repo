tpl 1.20 module traversys_Congenica;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Congenica';
end metadata;

pattern Congenica_BAI 1.0
    """
    Models an instance of the Congenica Application.

    Triggers on PostgreSQL runnning sapientia DB.
    
    Change History:
    2023-06-13 | 1.0 | WF | Created.
    
    """
    metadata
        publishers := 'Congenica';
        products   := 'Congenica';
        urls       := 'https://www.congenica.com/';
        categories := 'Genetic Sequencing & Analysis';
    end metadata;

    overview
        tags traversys, custom, congenica;
    end overview;
    
    constants
        type := "Congenica";
        db_instance := "sapientia";
    end constants;
    
    triggers
        on si := SoftwareInstance where type = "PostgreSQL Database Server";
    end triggers;
    
    body

        databases := search(in si traverse ElementWithDetail:Detail:Detail:Database where instance = %db_instance%);
        if size(databases) = 0 then
            // Not a Congenica DB
            stop;
        end if;

        host:= related.host(si);

        name     := "%type%";
        key      := text.hash(name);

        bai := model.BusinessApplicationInstance(
                                                    key       := key,
                                                    type      := type,
                                                    name      := name,
                                                    _traversys:= true
                                                  );
        model.addContainment(bai, si);
        model.rel.Dependency(Dependant := bai, DependedUpon := databases);

        etc_hosts:= discovery.fileGet(host, "/etc/hosts");
        if etc_hosts and etc_hosts.md5sum then
            bastion:= regex.extract(etc_hosts.content, regex "(\b(\d{1,3}\.?)+\b)\s+bastion\n", raw "\1");
            if bastion <> "" then
                bastion_ip:= search(IPAddress where ip_addr = "%bastion%");
                if size(bastion_ip) > 0 then
                    log.debug("Found bastion IP %bastion%.");
                    bastion_hosts:= search(in bastion_ip traverse IPv4Address:DeviceAddress:DeviceWithAddress:Host);
                    if size(bastion_hosts) > 0 then
                        bastion_host := bastion_hosts[0];
                        log.debug("Bastion Host %bastion_host.name%.");
                        //Associate:Inference:InferredElement:Host
                        //model.rel.Inference(Associate:=bai,Host:=bastion_host);
                        bai.bastion := bastion_host.name;
                        model.addDisplayAttribute(bai, "bastion %bastion_ip%");
                    end if;
                end if;
            end if;
        end if;

    end body;

end pattern;


//identify Congenica 1.0
//    tags congenica;
//    DiscoveredProcess cmd -> set_by, simple_identity;
//    unix_cmd 'congenica' -> 'traversys', 'Congenica';
//end identify;