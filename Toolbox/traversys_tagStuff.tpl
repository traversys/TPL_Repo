// (C) 2022 Traversys Limited
// Licensed under GPL-3.0-or-later

tpl 1.20 module TagStuff;

metadata
    __name     :='TagStuff';
    origin     :='Traversys';
    description:="Use a search query to add a 'tag' to all returned nodes.";
    tree_path  :='Traversys', 'Extensions', 'TagStuff';
end metadata;

from TSAKLicense import gpl_license 1.0;

configuration tagger 1.0
    """Tagging Block"""

    "Tag" tag_name := "";
    "Value" tag_value := "";
    "Group Name" group_name := "";
    "Activate" __active := false;

end configuration;

pattern tagStuff 1.0

    """
    Author: Wes Moskal-Fitzpatrick

    How to use
    ==========
    1) Create a manual group of nodes to update.
    2) Add a tag and value and enter the group name into the config block
    3) Set active to True for one-off tagging

    Change History:
    2022-08-23 1.0 WMF : Created.

    """

    overview
        tags traversys, tagging, tagger;
    end overview;

    triggers
        on config:= PatternConfiguration modified where name = "TagStuff.tagger" and __active = true;
    end triggers;

    body

        if gpl_license.accept_gpl = false then
            stop;
        end if;

        group_nodes:= search(Group where name = "%tagger.group_name%" traverse Container:Containment:ContainedItem:);

        for _node in group_nodes do
            _node[tagger.tag_name]:= tagger.tag_value;
        end for;

    end body;

end pattern;
