tpl 1.19 module TKU_ext_MS_SCCM;

metadata
	author := 'MSL';
    origin := 'test bed';
	description := "Microsoft SystemCenter Configuration Manager";
	categories := 'Client Management';
	product_synonyms := 'SCCM';
	publishers := "Microsoft Corporation";
    tree_path := 'TKU Extensions', 'Software', 'Microsoft', 'SCCM';
end metadata;

pattern sccm 1.0
'''
	Triggers on SCCM Client SI and looks for missing Site Code etc
	Uses disco.runPS to query for sSiteCode

	Change History:
	 	31-12-2021 - MSL	first draft
'''

    metadata
		products := "Microsoft SystemCenter Configuration Manager";
    end metadata;

    overview
		tags SCCM, Windows;
    end overview;

	constants
		ps_sitecode	:= "$([WmiClass]'ROOT\ccm:SMS_Client').getassignedsite() | Select sSiteCode,Site,Container | fl | Out-String";
	end constants;

    triggers
		on trig := SoftwareInstance created, confirmed where type = 'Microsoft System Center Configuration Manager Client';
    end triggers;

    body
		if trig.domain and trig.site_server then
			log.debug('domain and site_server defined');
		end if;

		host := model.host(trig);

		run_ps_sitecode := discovery.runPowerShell(host, ps_sitecode, '');
		if run_ps_sitecode then
			regex_sitecode := regex.extract(run_ps_sitecode.result, 'sSiteCode\s:\s(\S+)', raw "\1");
			if regex_sitecode then
				log.debug("SiteCode: %regex_sitecode%");
				trig.sitecode := regex_sitecode;
				trig._tw_meta_data_attrs := ['sitecode'];
			end if;
		else
			log.debug("Nothing found");
		end if;
    end body;
end pattern;
