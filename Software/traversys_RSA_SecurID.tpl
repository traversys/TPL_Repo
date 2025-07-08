tpl 1.9 module traversys_RSA_SecurID;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'RSA', 'SecurID';
end metadata;
    
pattern Traversys_SI_AceServer 1.0
    """
        RSA SecureID Ace Server
      
        Change History:
        2015-09-17 | 1.0 | WF | Created.
    
    """
    metadata
        publishers      := 'RSA', 'SecurID';
        products        := 'RSA SecurID ACE/Server';
        urls            := 'https://www.securid.com/', 'https://docs.oracle.com/cd/E19944-01/819-4520/SecureID_ACE_Server.html';
        categories      := 'Identity Access Management';
        known_versions  := '0';
    end metadata;
    
    overview
        tags custom, ace, rsa, securid, traversys;
    end overview;
    
    constants
        type := 'RSA SecurID ACE/Server';
    end constants;
    
    triggers
        on process:= DiscoveredProcess where cmd matches windows_cmd '_mprosrv';
    end triggers;
    
    body

        host:= related.host(process);
        
        name := "%type% on %host.name%";
        key := text.hash("%type%/%host.name%");

        si:= model.SoftwareInstance(
                                    key:= key,
                                    type:= type,
                                    name:= name,
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "%type%_sis");

    end body;
  
end pattern;

identify SecurID 1.0
    tags SecurID;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd '_mprosrv' -> 'traversys', 'RSA SecurID ACE/Server';end identify;
