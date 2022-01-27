// (C) 2019 Traversys Limited
// Licensed under GPL-3.0-or-later

tpl 1.15 module makeBAIs;

metadata
    __name     :='Generate BAIs';
    origin     :='Traversys';
    description:='Generate BAIs by following relationships';
    tree_path  :='Traversys', 'Software', 'Generate BAIs';
end metadata;

from TSAKLicense import gpl_license 1.0;

configuration ignore 1.0
    """Ignore rules"""

    "Websites to ignore" websites := [ "_" ];

end configuration;

pattern WebsiteBAIs 1.1

    """
    Author: Wes Moskal-Fitzpatrick

    Work in progress - use typical relationships to generate some BAIs from Websites.

    Change History:
    2019-05-25 1.0 WMF : Created.
    2019-06-04 1.1 WMF : Added conditional to limit BAI creation only if communicating SIs is discovered.

    """

    overview
        tags traversys, bai, website;
    end overview;

    constants
        type := "Website";
    end constants;

    triggers
        on sc:= SoftwareComponent created, confirmed where type matches regex "\bWebsite\b";
    end triggers;

    body
        if gpl_license.accept_gpl = false then
            stop;
        end if;

        if sc.instance in ignore.websites then
            log.warn("Ignoring website %sc.instance%...");
            stop;
        end if;

        instance := text.lower(sc.instance);
        name     := "%sc.instance% %type%";
        key      := text.hash(instance);

       containing_sis := search(in sc traverse ContainedSoftware:SoftwareContainment:SoftwareContainer:SoftwareInstance);
       outgoing_sis   := search(in containing_sis traverse Connecting:ObservedCommunication:Listening:SoftwareInstance);

       // Create only a BAI if there is a communicating SI - in this way we
       // try to model something that looks like like a genuine BAI
       if size(outgoing_sis) > 0 then

            bai := model.BusinessApplicationInstance(
                                                     key       := key,
                                                     type      := type,
                                                     name      := name,
                                                     instance  := sc.instance,
                                                     _traversys:= true
                                                  );
            // ContainedSoftware:SoftwareContainment:SoftwareContainer:BusinessApplicationInstance
            model.addContainment(bai, sc);
            model.addContainment(bai, containing_sis);
            model.addContainment(bai, outgoing_sis);

            // Some of these will be DB servers, but the SIDs can vary so we can add the DB server and try to work it out manually.
            databases      := search(in outgoing_sis traverse ElementWithDetail:Detail:Detail:Database where lower(instance) = %instance%);

            // Dependant:Dependency:DependedUpon:Database
            model.rel.Dependency(Dependant := bai, DependedUpon := databases);

            si_dependencies:= search(in containing_sis traverse Dependant:Dependency:DependedUpon:SoftwareInstance);
            model.addContainment(bai, si_dependencies);

            si_containers  := search(in containing_sis traverse ContainedSoftware:SoftwareContainment:SoftwareContainer:SoftwareInstance);
            model.addContainment(bai, si_containers);

            lb_members     := search(in containing_sis traverse ServiceProvider:SoftwareService:Service:LoadBalancerMember);
            lb_pools       := search(in lb_members traverse ContainedMember:Containment:Container:LoadBalancerPool where lower(name) = "%instance%");
            lb_services    := search(in lb_pools traverse ContainedPool:Containment:Container:LoadBalancerService);
            model.addContainment(bai, lb_services);

            //lb_instances   := search(in lb_pools traverse ContainedPool:Containment:Container:LoadBalancerInstance);
            //lb_failover    := search(in lb_instances traverse ContainedInstance:Containment:Container:LoadBalancerGroup
            //                                         traverse Container:Containment:ContainedInstance:LoadBalancerInstance where failover_state = "Standby");

        end if;

    end body;

end pattern;
