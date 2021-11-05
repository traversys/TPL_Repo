tpl 1.9 module traversys_NetworkRail_FMS;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Network Rail', 'Fault Management System (FMS)';
end metadata;

pattern Traversys_SI_Central2Local 1.0
'''
    FMS Central to Local Transfer Service.

    Change History:
    2015-03-11 | 1.0 | WF | Created.

'''

    metadata
        publishers      := 'Network Rail';
        products        := 'Fault Management System (FMS)';
        urls            := 'https://fms.networkrail.co.uk/';
        categories      := 'Fault Management System';
        known_versions  := '0';
    end metadata;

    overview 
        tags fms, fault, networkrail, custom, traversys;
    end overview;

    constants
        type:= 'Network Rail FMS Central to Local Transfer Service';
    end constants;
  
    triggers
        on service:= DiscoveredService where name = "CLXFER";
    end triggers;
  
    body
  
        host:= related.host(service);
        
        name:= '%type% on %host.name%';

        key:= text.hash('%type%/%host.key%');
      
        si:= model.SoftwareInstance(
                                    key:= key,
                                    name:= name,
                                    type:= type,
                                    instance:= "Central",
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "%type%_sis");
  
    end body;
  
end pattern;


pattern Traversys_SI_FMS_Reporting_Engine 1.0
'''
    FMS Local Reporting Engine.

    Change History:
    2015-03-11 | 1.0 | WF | Created.

'''

    metadata
        publishers     := 'Network Rail';
        products       := 'Fault Management System (FMS)';
        urls           := 'https://fms.networkrail.co.uk/';
        categories     := 'Fault Management System';
        known_versions := '0';
    end metadata;

    overview
        tags fms, networkrail, reporting, custom, traversys;
    end overview;

    constants
        type:= 'Network Rail FMS Reporting Engine';
    end constants;

    triggers
        on service:= DiscoveredService where name matches regex "^REPENG";
    end triggers;

    body
  
        host:= related.host(service);
        
        name:= '%type% on %host.name%';

        key:= text.hash('%type%/%host.key%');
      
        si:= model.SoftwareInstance(
                                    key:= key,
                                    name:= name,
                                    type:= type,
                                    instance:= "Local",
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "%type%_sis");
  
    end body;

end pattern;


pattern Traversys_SI_FaultUpdate 1.0
'''
    FMS Local Fault Update Service
  
    Change History:
    2010-08-03 1.0 - WF: Created.

'''

    metadata
        publishers     := 'Network Rail';
        products       := 'Fault Management System (FMS)';
        urls           := 'https://fms.networkrail.co.uk/';
        categories     := 'Fault Management System';
        known_versions := '0';
    end metadata;

    overview
        tags fms, networkrail, fault, custom, traversys;
    end overview;

    constants
        type:= 'Network Rail FMS Fault Update Service';
    end constants;

    triggers
        on service:= DiscoveredService where name = "FaultUpdate";
    end triggers;

    body
        
        host:= related.host(service);
        
        name:= '%type% on %host.name%';

        key:= text.hash('%type%/%host.key%');
      
        si:= model.SoftwareInstance(
                                    key:= key,
                                    name:= name,
                                    type:= type,
                                    instance:= "Local",
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "%type%_sis");
      
    end body;

end pattern;


pattern Traversys_SI_FMS_Web 1.0
'''
    FMS Web Server.
    
    Change History:
    2015-04-02 1.0 WF : Created.

'''

    metadata
        publishers     := 'Network Rail';
        products       := 'Fault Management System (FMS)';
        urls           := 'https://fms.networkrail.co.uk/';
        categories     := 'Fault Management System';
        known_versions := '0';
    end metadata;

    overview
        tags fms, networkrail, webserver, frmweb, custom, traversys;
    end overview;

    constants
        type:= 'Network Rail FMS Webserver';
        root:= '/u01/app/websites/fms.corp.ukrail.net/forms';
    end constants;

    triggers
		    on process:= DiscoveredProcess where cmd matches unix_cmd 'frmweb';
    end triggers;

    body

        host:= related.host(service);

        repFile:= discovery.fileInfo(host, root + "/fmsmain.fmb");
		    if not repFile then
            log.warn("Not a valid FRM service. Stopping...")
			      stop;
		    end if;
        
        name:= '%type% on %host.name%';

        key:= text.hash('%type%/%host.key%');
      
        si:= model.SoftwareInstance(
                                    key:= key,
                                    name:= name,
                                    type:= type,
                                    instance:= "Central",
                                    install_path:= repFile.path,
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "%type%_sis");

    end body;

end pattern;

identify fms 1.0
    tags fms;
    DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'frmweb' -> 'traversys', 'Network Rail FMS Webserver';
end identify;