// (C) 2019 Traversys Limited
// Licensed under GPL-3.0-or-later

tpl 1.15 module subnetMapper;

metadata
    __name     :='Subnet Mapper';
    origin     :='Traversys';
    description:='Map a subnet to an IP';
    tree_path  :='Traversys', 'Extensions', 'Subnet Mapper';
end metadata;

from TSAKLicense import gpl_license 1.0;

table cidrTable 1.0
    '/0'    -> 'A', [ 0, 0, 0, 0 ];
    '/1'    -> 'A', [ 128, 0, 0, 0 ];
    '/2'    -> 'A', [ 192, 0, 0, 0 ];
    '/3'    -> 'A', [ 224, 0, 0, 0 ];
    '/4'    -> 'A', [ 240, 0, 0, 0 ];
    '/5'    -> 'A', [ 248, 0, 0, 0 ];
    '/6'    -> 'A', [ 252, 0, 0, 0 ];
    '/7'    -> 'A', [ 254, 0, 0, 0 ];
    '/8'    -> 'B', [ 255, 0, 0, 0 ];
    '/9'    -> 'B', [ 255, 128, 0, 0 ];
    '/10'   -> 'B', [ 255, 192, 0, 0 ];
    '/11'   -> 'B', [ 255, 224, 0, 0 ];
    '/12'   -> 'B', [ 255, 240, 0, 0 ];
    '/13'   -> 'B', [ 255, 248, 0, 0 ];
    '/14'   -> 'B', [ 255, 252, 0, 0 ];
    '/15'   -> 'B', [ 255, 254, 0, 0 ];
    '/16'   -> 'C', [ 255, 255, 0, 0 ];
    '/17'   -> 'C', [ 255, 255, 128, 0 ];
    '/18'   -> 'C', [ 255, 255, 192, 0 ];
    '/19'   -> 'C', [ 255, 255, 224, 0 ];
    '/20'   -> 'C', [ 255, 255, 240, 0 ];
    '/21'   -> 'C', [ 255, 255, 248, 0 ];
    '/22'   -> 'C', [ 255, 255, 252, 0 ];
    '/23'   -> 'C', [ 255, 255, 254, 0 ];
    '/24'   -> 'D', [ 255, 255, 255, 0 ];
    '/25'   -> 'D', [ 255, 255, 255, 128 ];
    '/26'   -> 'D', [ 255, 255, 255, 192 ];
    '/27'   -> 'D', [ 255, 255, 255, 224 ];
    '/28'   -> 'D', [ 255, 255, 255, 240 ];
    '/29'   -> 'D', [ 255, 255, 255, 248 ];
    '/30'   -> 'D', [ 255, 255, 255, 252 ];
    '/31'   -> 'D', [ 255, 255, 255, 254 ];
    '/32'   -> 'D', [ 255, 255, 255, 255 ];
end table;

definitions subnetFunctions 1.0
    """ Subnet Functions developed by Traversys """

    define ipEvaluate(ipAddr, subnet, netmask, sub, ip) -> subnetted
        "Evaluate if given IP is in the same block range as the subnet"
        blocks:= 256 - netmask;
        count:= number.range(256 / blocks);
        subnetted:= false;
        for i in count do
            last:= blocks * (i + 1);
            first:= last - blocks;
            if (sub >= first) and (sub < last) then
                if (ip >= first) and (ip < last) then
                    subnetted:= true;
                    log.debug("ip address %ipAddr% is in subnet range %subnet%.");
                    break;
                end if;
            end if;
        end for;
        return subnetted;
    end define;

    define subnet2ip(ip, subnet) -> inRange
        "Check IP is in a given subnet"

        inRange:= false;
        cidr:= regex.extract(subnet, regex "(/\d+)$", raw "\1");
        class:= cidrTable[cidr][0];
        netmask:= cidrTable[cidr][1];
        log.debug("subnet %subnet% Class is %class%, netmask %netmask%");
        octets:= text.split(ip, ".");
        ip1st:= text.toNumber(octets[0]);
        ip2nd:= text.toNumber(octets[1]);
        ip3rd:= text.toNumber(octets[2]);
        ip4th:= text.toNumber(octets[3]);
        subnetIP:= regex.extract(subnet, regex "((\d+\.)+\d+)", raw "\1");
        subOctets:= text.split(subnetIP, ".");
        sub1st:= text.toNumber(subOctets[0]);
        sub2nd:= text.toNumber(subOctets[1]);
        sub3rd:= text.toNumber(subOctets[2]);
        sub4th:= text.toNumber(subOctets[3]);

        match:= 0;
        if ip1st = sub1st then
            match:= 1;
            if ip2nd = sub2nd then
                match:= 2;
                if ip3rd = sub3rd then
                    match:= 3;
                end if;
            end if;
        end if;

        if class = "D" and match > 2 then
            inRange:= ipEvaluate(ip, subnet, netmask[3], sub4th, ip4th);
        elif class = "C" and match > 1 then
            inRange:= ipEvaluate(ip, subnet, netmask[2], sub3rd, ip3rd);
        elif class = "B" and match > 0 then
            inRange:= ipEvaluate(ip, subnet, netmask[1], sub2nd, ip2nd);
        elif class = "A" then
            inRange:= ipEvaluate(ip, subnet, netmask[0], sub1st, ip1st);
        end if;

        return inRange;

    end define;

end definitions;

pattern subnetTest 1.0
    """
        This pattern will trigger on a subnet and attempt to evaluate an IP.

        Test purposes only.

        Triggers on Subnet - will examine an IP address to see if it maps to the Subnet.

        Change History:
        2019-07-10 1.0 WMF : Created.

    """

    overview
        tags Subnets, Custom;
    end overview;

    triggers
        on sub:= Subnet created, confirmed where ip_address_range = "192.168.1.0/24";
    end triggers;

    body

        // Run against single test IP
        ips:= search(IPAddress where ip_addr = "192.168.1.82");
        ip:= ips[0];
        testSubnet:= "192.168.1.80/28";
        subnetted_true:= subnetFunctions.subnet2ip(ip.ip_addr, sub.ip_address_range);
        log.info("IP %ip.ip_addr% in %sub.ip_address_range%? %subnetted_true%");
        subnetted_test:= subnetFunctions.subnet2ip(ip.ip_addr, testSubnet);
        log.info("IP %ip.ip_addr% in %testSubnet%? %subnetted_test%");

    end body;

end pattern;
