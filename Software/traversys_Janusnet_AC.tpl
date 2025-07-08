tpl 1.9 module traversys_Janusnet_Access_Control;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Janusnet', 'Access Control';
end metadata;

pattern Traversys_SI_JanusnetAC 1.0
    '''
        Janusnet Access Control.
        
        Change History:
        2015-09-24 | 1.0 | WF | Created.
        
    '''

    metadata
        publishers      := 'Janusnet';
        products        := 'Access Control';
        urls            := 'https://www.janusnet.com/solution/access-control';
        categories      := 'Access Control';
        known_versions  := '0';
    end metadata;

    overview
        tags janusnet, access, control, custom, traversys;
    end overview;
    
    constants
        type:= "Janusnet Access Control";
    end constants;

    triggers
        on process:= DiscoveredProcess where cmd matches windows_cmd 'HOUIDSserver';
    end triggers;

    body

        host:= related.host(process);
        name:= "%type% on %host.name%";
        key := text.hash("%type%/%host.key%");

        si:= model.SoftwareInstance(
                                    key:= key,
                                    name:= name,
                                    type:= type,_traversys:= true
                                    );
        model.setRemovalGroup(si, "%type%_sis");
		
    end body;

end pattern;

identify Janusnet 1.0
    tags Janusnet;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'HOUIDSserver' -> 'traversys', 'Janusnet Access Control';end identify;
