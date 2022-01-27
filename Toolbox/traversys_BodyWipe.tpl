// (C) 2019 Traversys Limited
// Licensed under GPL-3.0-or-later

tpl 1.15 module BodyWipe;

metadata
    __name     :='Body Wipe';
    origin     :='Traversys';
    description:='Pattern to remove body element';
    tree_path  :='Traversys', 'Extensions', 'Body Wipe';
end metadata;

from TSAKLicense import gpl_license 1.0;

pattern bodyWipe 1.0

    """
    Author: Wes Moskal-Fitzpatrick

    A pattern to strip body from TPL.

    Change History:
    2019-06-18 1.0 WMF : Created.

    """

    overview
        tags traversys, bodywipe;
    end overview;

    triggers
        on tipple:= PatternModule modified where name = "targetForRemoval" and active = 1;
    end triggers;

    body

        if gpl_license.accept_gpl = false then
            stop;
        end if;

        // Remove Pattern Body
        if not tipple.wiped then
            tipple.content:= "Removed!";
            tipple.wiped:= true;
        end if;

    end body;

end pattern;
