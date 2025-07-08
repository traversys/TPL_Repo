tpl 1.9 module traversys_MetaStorm;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Nesscomp', 'MetaStorm BPM';
end metadata;

pattern Traversys_SI_MetaStorm_ProcessEngine 1.0
    '''
        Metastorm Process Engine
        
        Change History:
        2015-07-23 | 1.0 | Created.
          
    '''
    metadata
        publishers      := 'Nesscomp';
        products        := 'MetaStorm BPM', 'OpenText';
        urls            := 'http://www.nesscomp.com/learn-about-bpm/metastorm-bpm/';
        categories      := 'Business Process Management';
        known_versions  := '0';
    end metadata;

    overview
        tags metastorm, opentext, nesscomp, custom, traversys;
    end overview;
    
    constants
        type:= 'Nesscomp MetaStorm BPM Process Engine';
    end constants;
    
    triggers
        on process:= DiscoveredProcess where cmd matches windows_cmd 'eEngine';
    end triggers;

    body
  
        host:= model.host(process);
        key := text.hash("%type%/%host.key%");

	      name:= '%type% on %host.name%';
        
        si:= model.SoftwareInstance(
                                    name:= name,
                                    type:= type,
                                    key:= key
                                    );
        model.setRemovalGroup(si, "%type%_sis");

        sv:= discovery.registryKey(host, "HKEY_LOCAL_MACHINE\\SOFTWARE\\Metastorm\\e-work\\InstallInfo\\EORACLESERVICENAME");
        
        if sv and sv.value then
            si.service_value:= sv.value;
            model.addDisplayAttribute(si, 'service_value');
        else:
            si.service_value:= void;
        end if;
        
        dsn:= discovery.registryKey(host, "HKEY_LOCAL_MACHINE\\SOFTWARE\\Metastorm\\e-work\\InstallInfo\\EORACLEDSN");
        if dsn and dsn.value then
            si.dsn_value:= dsn.value;
            model.addDisplayAttribute(si, 'dsn_value');
        else:
            si.dsn_value:= void;
        end if;

    end body;

end pattern;


pattern Traversys_SI_MetaStorm_Event_Monitor 1.0
    '''
        MetaStorm Event Monitor
        
        Change History:
        2015-07-23 | 1.0 | Created.
        
    '''
    metadata
        publishers      := 'Nesscomp';
        products        := 'MetaStorm BPM', 'OpenText';
        urls            := 'http://www.nesscomp.com/learn-about-bpm/metastorm-bpm/';
        categories      := 'Business Process Management';
        known_versions  := '0';
    end metadata;

    overview
        tags metastorm, opentext, nesscomp, event, monitor, custom, traversys;
    end overview;
    
    constants
        type:= 'Nesscomp MetaStorm BPM Event Monitor';
    end constants;
    
    triggers
        on process:= DiscoveredProcess where cmd matches windows_cmd 'Metastorm\sEvent\sMonitor';
    end triggers;
    
    body

        host:= model.host(process);
        key := text.hash("%type%/%host.key%");

        name:= '%type% on %host.name%';
        
        si:= model.SoftwareInstance(
                                    name:= name,
                                    type:= type,
                                    key:= key,
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "%type%_sis");

        si._tw_meta_data_attrs:= tw_meta_data_attrs;

    end body;

end pattern;

identify MetaStorm 1.0
	tags MetaStorm;
	DiscoveredProcess cmd -> set_by, simple_identity;
	windows_cmd 'eEngine' -> "traversys", "Nesscomp MetaStorm BPM Process Engine";
	windows_cmd 'Metastorm\sEvent\sMonitor' -> "traversys", "Nesscomp MetaStorm BPM Event Monitor";end identify;
