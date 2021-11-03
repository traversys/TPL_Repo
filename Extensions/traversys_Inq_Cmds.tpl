tpl 1.6 module traversys_Inq_CMDs;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Extended', 'Inq CMDs';
end metadata;

pattern Traversys_Inq_CMDs 1.0
    '''  
        Inq Commands.

        Change History:
        2009-09-06 | 1.0 | WF | Created.

    '''

    overview
        tags storage, inq, custom, traversys;
    end overview;

	triggers
		on host := Host created, confirmed;
	end triggers;
	
	body

		if host.os_type = "Windows" then	
			inq	:= "inq";
			inq_hba := "inq -hba";
			inq_et := "inq -no_dots -et";
			inq_clar := "inq -no_dots -clar_wwn";
			inq_sym	:= "inq -no_dots -sym_wwn";
		elif host.os_type matches "Linux" then 
			inq := "sudo /usr/local/site/coredb/utils/inq.linux";
			inq_hba := "sudo /usr/sbin/lpfc/lputil listhbas";
			inq_et := "sudo /usr/local/site/coredb/utils/inq.linux -no_dots -et";
			inq_clar := "sudo /usr/local/site/coredb/utils/inq.linux -no_dots -clar_wwn";
			inq_sym	:= "sudo /usr/local/site/coredb/utils/inq.linux -no_dots -sym_wwn";
		else
			inq := "sudo /usr/local/site/coredb/utils/inq";
			inq_hba := "sudo /usr/local/site/coredb/utils/inq -hba";
			inq_et := "sudo /usr/local/site/coredb/utils/inq -no_dots -et";
			inq_clar := "sudo /usr/local/site/coredb/utils/inq -no_dots -clar_wwn";
			inq_sym	:= "sudo /usr/local/site/coredb/utils/inq -no_dots -sym_wwn";
		end if;

		inq_cmd := discovery.runCommand(host, inq);
		if inq_cmd and inq_cmd.result then
			host.inq := inq_cmd.result;
		end if;

		inq_hba_cmd	:= discovery.runCommand(host, inq_hba);
		if inq_hba_cmd and inq_hba_cmd.result then
			host.inq_hba := inq_hba_cmd.result;
			host.san_attached := true;
		end if;

		inq_et_cmd := discovery.runCommand(host, inq_et);		
		if inq_et_cmd and inq_et_cmd.result then
			host.inq_et := inq_et_cmd.result;
		end if;

		inq_clar_cmd := discovery.runCommand(host, inq_clar);
		if inq_clar_cmd and inq_clar_cmd.result then
			host.inq_clar := inq_clar_cmd.result;
		end if;

		inq_sym_cmd	:= discovery.runCommand(host, inq_sym);
		if inq_sym_cmd and inq_sym_cmd.result then
			host.inq_sym := inq_sym_cmd.result;
		end if;

	end body;

end pattern; 