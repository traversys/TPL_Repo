tpl 1.6 module traversys_FirefoxTabs;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Extended', 'Firefox Tabs';
end metadata;

pattern Traversys_Firefox_Tabs 1.0
    '''
    Author: Wes Fitzpatrick

    Change History:
    2013-10-30 | 1.0 | WF | Created

    '''

    overview
        tags firefox, custom, traversys;
    end overview;

    constants
        t:= "Mozilla Firefox";
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches regex "\b(?i)firefox(\.exe$)?";
    end triggers;

    body

        h:= model.host(p);

        n:= "%t% on %h.name%";

        tab:= regex.extract(p.args, regex "(w{3}\.\w+\.com)", raw "\1");

        url:= "http://%tab%/search?q=%t%";
        urls:= [ 'url' ];

        k:= text.hash("%n%/%t%");

        si:= model.SoftwareInstance(key:=k, name:=n, type:=t, url:=url,_tw_meta_data_attrs:=['url']);
        
        addm:= system.getOption("APPLIANCE_NAME");
        si.appliance:= addm;

        tpls:= si.#Element:Maintainer:Pattern:Pattern;
        tpls[0].urls:= "http://www.google.com/search?q=mozilla";

    end body;

end pattern;
