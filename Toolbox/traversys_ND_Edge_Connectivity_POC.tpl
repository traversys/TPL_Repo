// (C) 2019 Traversys Limited
// Licensed under GPL-3.0-or-later

tpl 1.15 module ndEdgeConnectivity;

metadata
    __name     :='NetworkDevice Edge Connectivity PoC';
    origin     :='Traversys';
    description:='Proof of Concept for Network Device Edge Connectivity';
    tree_path  :='Traversys', 'Extensions', 'ND Edge Connectivity';
end metadata;

from TSAKLicense import gpl_license 1.0;

pattern ndEdgeConnectivity 1.0

    """
    Author: Wes Moskal-Fitzpatrick

    Proof of Concept for 2 random network devices selected in BMC's Demo Appliance.

    Change History:
    2019-06-09 1.0 WMF : Created.

    """

    overview
        tags traversys, NetworkDevice, edge;
    end overview;

    triggers
        on nd:= NetworkDevice created, confirmed where name = "swd77";
    end triggers;

    body
        if gpl_license.accept_gpl = false then
            stop;
        end if;

        interfaces:= search(in nd traverse DeviceWithInterface:DeviceInterface:InterfaceOfDevice:NetworkInterface where interface_name = "fc0");

        if size(interfaces) > 0 then
            interface:= interfaces[0];
            log.debug("Interface of %nd.name% = %interface.name%");
            edgeDevices:= search(NetworkDevice where name = "ais-saas-f5.calbro.com");
            if size(edgeDevices) > 0 then
                edgeDevice:= edgeDevices[0];
                log.debug("Edge Device = %edgeDevice.name%");
                edgeIfaces:= search(in edgeDevice traverse DeviceWithInterface:DeviceInterface:InterfaceOfDevice:NetworkInterface where interface_name = "external");
                if size(edgeIfaces) > 0 then
                    edgeIface:= edgeIfaces[0];
                    log.debug("Linking Interface %interface.name% to Edge Interface %edgeIface.name%...");
                    // EdgeDevice:NetworkLink:EdgeClient:NetworkInterface
                    model.rel.NetworkLink(EdgeDevice := interface, EdgeClient := edgeIface);
                end if;
            end if;
        end if;

    end body;

end pattern;
