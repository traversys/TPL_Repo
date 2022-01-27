// (C) 2019 Traversys Limited
// Licensed under GPL-3.0-or-later

tpl 1.15 module targetForRemoval;

metadata
    __name     :='Target Pattern';
    origin     :='Traversys';
    description:='Target Pattern for Body Removal';
    tree_path  :='Traversys', 'Extensions', 'Target Pattern';
end metadata;

from TSAKLicense import gpl_license 1.0;
from BodyWipe import bodyWipe 1.0;

pattern targetPattern 1.0

    """
    Author: Wes Moskal-Fitzpatrick

    A target pattern for body removal.

    Change History:
    2019-06-18 1.0 WMF : Created.

    """

    overview
        tags traversys, target;
    end overview;

    triggers
        on si:= SoftwareInstance created, confirmed where type = "BMC Discovery Proxy";
    end triggers;

    body
        if gpl_license.accept_gpl = false then
            stop;
        end if;

        // Will alternately add/remove attribute for each run
        if si.test_attribute then
            log.debug("Removing Test Attribute.");
            si.test_attribute:= void;
        else
            log.debug("Adding Test Attribute.");
            si.test_attribute:= true;
        end if;

    end body;

end pattern;
