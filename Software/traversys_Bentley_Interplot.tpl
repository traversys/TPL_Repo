tpl 1.9 module traversys_Bentley_SELECT;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Bentley Systems', 'Projectwise InterPlot Server';
end metadata;

pattern Traversys_SI_Projectwise_Interplot 1.0
    '''
    Projectwise InterPlot
    
    Change History:
    2015-02-26 | 1.0 | WF | Created.
    
    '''
    metadata
        publishers      := 'Bentley Systems';
        products        := 'Projectwise InterPlot Server';
        urls            := 'https://www.bentley.com/en/products/brands/projectwise';
        categories      := 'Enterprise Design Collaboration';
        known_versions  := '0';
    end metadata;

    overview
        tags bentley, projectwise, interplot, custom, traversys;
    end overview;
    
    constants
        type:= 'Bentley Projectwise InterPlot Server';
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd 'pidrpcs';
    end triggers;

    body

        host:= related.host(p);
		
		name:= '%type% on %host.name%';

        key:= "%name%/%host.key%";
	
		si := model.SoftwareInstance(
                                    key:= key,
                                    name:= name,
                                    type:= type,
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "%type%_sis");
  
    end body;

end pattern;


identify BentleyPWIP 1.0
    tags Bentley;
    DiscoveredProcess cmd -> simple_identity;
    windows_cmd 'pidrpcs' -> "Bentley Projectwise InterPlot Server";end identify;
