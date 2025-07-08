tpl 1.9 module traversys_FAST_InStream;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Oracle', 'Siebel FAST InStream';
end metadata;

pattern Traversys_SI_FAST_InStream 1.0
    '''
    Oracle Siebel CRM FAST InStream.
    
    Change History:
    2015-02-10 | 1.0 | WF | Created.

    '''

    metadata
        publishers     := "Oracle", "Siebel";
        products       := "Bookshelf", "Siebel Search", "FAST InStream";
        urls           := "https://docs.oracle.com/cd/B40099_02/books/SearchAddFAST/booktitle.html";
        categories     := 'CRM';
        known_versions := '8.0';
    end metadata;

    overview
		tags oracle, siebel, bookshelf, fast, instream, custom, traversys;
	end overview;
    
    constants
        type:= 'Oracle Siebel Bookshelf FAST InStream';
    end constants;

    triggers
        on p:= DiscoveredProcess created, confirmed where cmd matches unix_cmd 'fsearchctrl'
                                                        or cmd matches windows_cmd "fsearch";
    end triggers;

    body

		host := related.host(p);
        name := "%type% on %hostname%";

        si_node := model.SoftwareInstance(
                                           key  := text.hash("%type%/%host.name%"),
                                           name := name,
                                           type := type,
                                           _traversys:= true
                                         );
        model.setRemovalGroup(si, "%type%_sis");
		
		all_procs:= discovery.allProcesses(p);
		
		related_procs:= search(in all_procs where cmd matches "fastdatasearch" or args matches '(?i)fulltext' or cmd matches '(?i)fulltext');
        
		for related_proc in related_procs do
            inference.associate(si, related_proc);
		end for;
		
    end body;

end pattern;


metadata
    origin:= "Traversys";
    tree_path:= 'Traversys', 'Core Applications', 'CCMS';
end metadata;

from Traversys.Core.Tsys_Functions import tsys_funcs 1.0;

configuration tsys_config 1.0
  """Configuration settings modify application components"""

    "Database Detail type"
    // e.g. MS SQL = "SQL Server Database", Oracle = "Oracle Database"
    db_type:= "Oracle Database";

    "Database Instances, begins-with or full"
    db_instances:= [ "CCMSDB", "CCMDBP" ];
 
end configuration;

identify FASTInStream 1.0
    tags FASTInStream;
    DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'fsearchctrl' -> 'traversys', 'Oracle Siebel Bookshelf FAST InStream';
    windows_cmd 'fsearch' -> 'traversys', 'Oracle Siebel Bookshelf FAST InStream';end identify;
