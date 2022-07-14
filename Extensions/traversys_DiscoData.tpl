tpl 1.20 module traversys_DiscoData;

metadata
   origin:="Traversys";
   tree_path:='Traversys', 'Extended', 'Discovery Data';
end metadata;


table defaultOptionLists 1.0
"FTP_PORTS" -> ['21'];
"HTTP_PORTS" -> ['80'];
"HTTPS_PORTS" -> ['443'];
"MAINFRAME_PORTS" -> ['3940'];
"MAINVIEW_PORTS" -> ['3940'];
"POWERSHELL_HTTP_PORTS" -> ['5985'];
"POWERSHELL_HTTPS_PORTS" -> ['5986'];
"RLOGIN_PORTS" -> ['513'];
"SNMP_PORTS" -> ['161'];
"SSH_PORTS" -> ['22'];
"TELNET_PORTS" -> ['23'];
"VMAUTH_PORTS" -> ['902'];
"WBEM_HTTP_PORTS" -> ['5988'];
"WBEM_HTTPS_PORTS" -> ['5989'];
"WINDOWS_PORTS" -> ['135'];
"VALID_PORT_STATES" -> ['open', 'open|filtered'];
"CMDB_SYNC_COMPANIES" -> [];
"OPT_CHANGE_PSWD" -> ['You are required to change your password immediately \\\\(root enforced\\\\)'];
end table;


table defaultOptions 1.0
"ACK_PING" -> "False";
"ACK_PING_LIST" -> "80";
"ADMIN_EMAIL" -> "";
"AGGRESSION" -> "4";
"ALLOW_ADVANCED_SEARCH_ALL" -> "False";
"ALLOW_SCAN_REQ_WITHOUT_RECURRENCE" -> "False";
"APPLIANCE_COLOUR" -> "STANDARD";
"APPLIANCE_DESCRIPTION" -> "";
"APPLIANCE_MAINTENANCE_MODE" -> "False";
"APPLIANCE_NAME" -> "Discovery_Appliance";
"APPSERVER_LOG_LEVEL" -> "20";
"APPSERVER_OMNIORB_TRACE_CONFIGURATION" -> "1";
"AUDIT_PURGE_NOW" -> "False";
"AUTHORISED_PROMPT" -> "Are you authorised to use this computer as detailed above\? \(YES/NO\)";
"AUTHORISED_RESPONSE" -> "YES";
"AUTOMATIC_GROUPING_ENABLED" -> "False";
"AUTOMATIC_KNOWLEDGE_CLEANUP" -> "True";
"BASELINE_CRON_SPEC" -> "15 * * * *";
"BEST_IP_MAX_AGE" -> "604800";
"BOGUS_HOSTID_FILTER" -> "(?i)^(0+(-0+)*|X+|DELL|0?1234567890?|.{1,3}|unknown|(system\\s*)?serial\\s?number|(not\\s?|un)available|0x.{1,3}|-1|UNK|none|\\(none\\)|NEW_STRING|To be filled by (OEM|O\\.E\\.M\\.)|See IPMI FRU|not\\s?specified|undefined, but settable|Fill in this information|not\\s?applicable|value not set)$";
"BOGUS_SERIAL_FILTER" -> "(?i)^(0+(-0+)*|X+|DELL|0?1234567890?|.{1,3}|unknown|(system\\s*)?serial\\s?number|(not\\s?|un)available|0x.{1,3}|-1|UNK|none|\\(none\\)|NEW_STRING|To be filled by (OEM|O\\.E\\.M\\.)|See IPMI FRU|not\\s?specified|undefined, but settable|Fill in this information|not\\s?applicable|value not set|9KNF4QBB78BC0|[\\xff]{16}|HE2H81UJ47|\\.+)$";
"BOGUS_UUID_FILTER" -> "(?i)^(0+(-0+)*|X+|DELL|0?1234567890?|.{1,3}|unknown|(system\\s*)?serial\\s?number|(not\\s?|un)available|0x.{1,3}|-1|UNK|none|\\(none\\)|NEW_STRING|To be filled by (OEM|O\\.E\\.M\\.)|See IPMI FRU|not\\s?specified|undefined, but settable|Fill in this information|not\\s?applicable|value not set)$";
"CAM_WORKER_THREADS" -> "3";
"CHECK_WINDOWS_PORT_OPEN" -> "True";
"CLOUD_DISCOVERY_ENABLED" -> "False";
"CLUSTER_MANAGER_LOG_LEVEL" -> "20";
"CLUSTER_MANAGER_OMNIORB_TRACE_CONFIGURATION" -> "1";
"CMDBSYNC_LOG_LEVEL" -> "20";
"CMDBSYNC_OMNIORB_TRACE_CONFIGURATION" -> "1";
"CMDB_SYNC_API" -> "0";
"CMDB_SYNC_CRED_ID" -> "";
"CMDB_SYNC_DEFAULT_COMPANY" -> "";
"CMDB_SYNC_MULTITENANCY" -> "False";
"CMDB_SYNC_RESYNC_WORKERS" -> "0";
"CMDB_SYNC_RF_NAMESPACE" -> "BMCServiceDesk";
"CMDB_SYNC_RPC_QUEUE" -> "-1";
"CMDB_SYNC_THREADS" -> "1";
"CONSOLIDATION_CALL_TIMEOUT" -> "600000";
"CYBERARK_ENABLED" -> "False";
"CYBERARK_ON_DNS_FAILURE" -> "STOP";
"CYBERARK_SHOULD_BE_INSTALLED" -> "False";
"DATASTORE_CACHE" -> "256";
"DATASTORE_CHECKPOINT_CHECK_INTERVAL" -> "30";
"DATASTORE_CHECKPOINT_INTERVAL" -> "900";
"DATASTORE_CHECKPOINT_SIZE_KB" -> "1048576";
"DATASTORE_COMPRESSION_THRESHOLD" -> "512";
"DATASTORE_DEADLOCK_INTERVAL_MICROSECONDS" -> "1000";
"DATASTORE_DESTROYED_NODE_PURGE_DAYS" -> "366";
"DATASTORE_EVENT_SENDING_INTERVAL" -> "30";
"DATASTORE_HISTORY_PURGE_DAYS" -> "0";
"DATASTORE_HOUSEKEEPING_BATCH" -> "10";
"DATASTORE_HOUSEKEEPING_INTERVAL_HIGH" -> "60";
"DATASTORE_HOUSEKEEPING_INTERVAL_LOW" -> "600";
"DATASTORE_HOUSEKEEPING_INTERVAL_MED" -> "300";
"DATASTORE_LOG_BSIZE" -> "1024";
"DATASTORE_LOG_CACHE" -> "True";
"DATASTORE_LOG_MAX" -> "262144";
"DATASTORE_LOG_REGIONMAX" -> "1024";
"DATASTORE_MAX_DEFAULT_ORDER" -> "1000000";
"DATASTORE_MAX_MIGRATE_BATCH" -> "200";
"DATASTORE_MEMORY_MAX" -> "512";
"DATASTORE_MULTI_GENERATION" -> "False";
"DATASTORE_NODE_DESTRUCTION_INTERVAL" -> "90";
"DATASTORE_NODE_DESTRUCTION_MEM_LIMIT" -> "100000";
"DATASTORE_PRIVATE_ENV" -> "False";
"DATASTORE_SHUTDOWN_PERIOD" -> "900";
"DATASTORE_SOFT_LIMIT" -> "30";
"DATASTORE_STARTUP_WAIT_SECONDS" -> "300";
"DATASTORE_SYSTEM_MEM" -> "True";
"DATASTORE_TRICKLE_INTERVAL" -> "30";
"DATASTORE_TRICKLE_PERCENT_FREE" -> "0";
"DATASTORE_UPDATE_INTERVAL" -> "60";
"DDD_AGEING_BATCHSIZE" -> "100";
"DDD_AGEING_INTERVAL" -> "1800";
"DDD_AGEING_TIMEOUT" -> "2419200";
"DISCOVERY_LOG_LEVEL" -> "20";
"DISCOVERY_OMNIORB_TRACE_CONFIGURATION" -> "1";
"DISCOVERY_OPERATING_MODE" -> "0";
"DISCOVERY_REGEX_LOG_THRESHOLD" -> "-1.0";
"DISCOVER_DESKTOP_HOSTS" -> "True";
"DISK_FREE_REQUIRE_MB" -> "1024";
"DISK_FREE_REQUIRE_MB_LOGS" -> "100";
"DNS_TIMEOUT" -> "10";
"ECA_ASYNCHRONISER_THREADS" -> "30";
"ECA_CONTROLLER_TIMEOUT" -> "300000";
"ECA_ENGINE_COUNT" -> "0";
"ECA_ENGINE_THREADS" -> "1";
"ECA_EVENT_DONE_DELAY" -> "0.0";
"ECA_PROCESS_TREE_CACHE_FACTOR" -> "1.0";
"EXTERNAL_API_LOG_LEVEL" -> "20";
"EXTERNAL_API_OMNIORB_TRACE_CONFIGURATION" -> "1";
"FRAGMENT_PACKETS" -> "False";
"FTP_BANNER_SCRAPE" -> "True";
"FTP_HEURISTIC_TIMEOUT" -> "5.0";
"GETBULK_SIZE" -> "10";
"HISTORY_COMPRESSION_THRESHOLD" -> "60";
"HTTPS_HEURISTIC_TIMEOUT" -> "5.0";
"HTTP_HEAD" -> "True";
"HTTP_HEURISTIC_TIMEOUT" -> "5.0";
"IMPORTRECORD_AGEING_TIMEOUT" -> "2419200";
"JVM_SIZE_SQL_DISCO_MAX_SIZE" -> "256";
"JVM_SIZE_SQL_DISCO_MIN_SIZE" -> "64";
"JVM_SIZE_SYNC_MAX_SIZE" -> "512";
"JVM_SIZE_SYNC_MIN_SIZE" -> "128";
"LAST_METHOD" -> "True";
"MAINFRAME" -> "True";
"MAINVIEW" -> "True";
"MAINFRAME_CONNECTION_LINKING_ENABLED" -> "False";
"MAX_ACTIVE_IAP_SESSIONS" -> "50";
"MAX_ACTIVE_SSM_SESSIONS" -> "5";
"MAX_INDIRECT_SCANS_VIA_ENDPOINT" -> "20";
"MAX_START_SSM_SESSIONS" -> "3";
"MIN_FAILED_ACCESSES_BEFORE_DESTROY" -> "7";
"MIN_SECONDS_SINCE_ACCESS_SUCCESS_BEFORE_DESTROY" -> "864000";
"MIN_SLAVE_VERSION" -> "11.0";
"MIN_WINDOWS_SSM_AGENT_VERSION" -> "";
"MODEL_LOG_LEVEL" -> "10";
"MODEL_OMNIORB_TRACE_CONFIGURATION" -> "1";
"MODEL_UPDATE_DEFER_TIME" -> "180";
"NEEDS_ATTENTION_GROWTH_FACTOR" -> "2";
"NEEDS_ATTENTION_THRESHOLD" -> "10";
"NETWORK_DISCOVERY_VIRTUAL_INTERFACES" -> "False";
"NODE_ATTACHMENTS_ENABLED" -> "False";
"NO_ACCESS_AGING_INTERVAL" -> "5";
"NO_ARP_PING" -> "False";
"NO_PING" -> "False";
"NO_RANDOMIZE" -> "False";
"OPEN_PORTS" -> "True";
"OPTIONS_CHECK_INTERVAL" -> "1.0";
"OS_DETECTION" -> "True";
"OS_DETECT_FLAG" -> "-O";
"OS_MAX_TRIES" -> "5";
"OS_SCAN_GUESS" -> "False";
"OS_SCAN_LIMIT" -> "False";
"PAYLOAD_LENGTH" -> "0";
"PING_EXCLUDE_RANGE" -> "";
"PLAYBACK_DELAY" -> "False";
"PLAYBACK_DELAY_MULTIPLIER" -> "1";
"REASONING_CONNECTION_TIMEOUT" -> "60000";
"REASONING_CONTROLLER_TIMEOUT" -> "600000";
"REASONING_LOG_LEVEL" -> "10";
"REASONING_OMNIORB_TRACE_CONFIGURATION" -> "1";
"REASONING_REGEX_LOG_THRESHOLD" -> "-1.0";
"REASONING_REQUEST_TIMEOUT" -> "1800000";
"RECORD_DEVICE_XML" -> "False";
"REPORTS_LOG_LEVEL" -> "20";
"REPORTS_OMNIORB_TRACE_CONFIGURATION" -> "1";
"REQUIRE_PASSPHRASE" -> "True";
"RESTORE_SCAN_STATUS" -> "True";
"AUTOSTART_SCANS" -> " True";
"REST_API_QUERIES" -> "True";
"SCANNER_INTERVAL" -> "3600";
"SCAN_RETRIES" -> "0";
"SCAN_SAFETY_MARGIN" -> "1800";
"SCAN_TIMEOUT" -> "900";
"SECURITY_LOG_LEVEL" -> "20";
"SECURITY_OMNIORB_TRACE_CONFIGURATION" -> "1";
"SERVICENOW_SYNC_ENABLED" -> "False";
"SESSION_LINE_DELAY" -> "0.01";
"SESSION_LOGGING" -> "False";
"SESSION_LOGIN_TIMEOUT" -> "0.0";
"SESSION_MAX_SEARCH_SIZE" -> "512";
"SI_MAX_AGE" -> "0";
"SI_MIN_FAILED_ACCESSES_BEFORE_DESTROY" -> "7";
"SI_MIN_SECONDS_SINCE_ACCESS_SUCCESS_BEFORE_DESTROY" -> "864000";
"SKIP_IMPLICIT_SCANS" -> "False";
"SLAVE_LOG_LEVEL" -> "20";
"SLAVE_OMNIORB_TRACE_CONFIGURATION" -> "1";
"SMART_GRAPH_VIZ_ENABLED" -> "True";
"SNMP_PUBLIC_QUERY" -> "True";
"SNMP_SYSDESC_QUERY" -> "True";
"SSH_SESSION_MODULE" -> "standard";
"SSL_PASSWORD_COMMAND" -> "";
"SUPPORT_URL" -> "https://docs.bmc.com/docs/productsupport/bmc-discovery";
"SUPPORT_URL_DESCRIPTION" -> "Contact BMC Support; Access the Configipedia; Pattern documentation; Request product enhancements, new reports and new patterns";
"SUPPORT_URL_LABEL" -> "Support & Community";
"SUPPORT_URL_TITLE" -> "BMC Discovery Support and Community";
"SUPPRESS_CHILD_CORES" -> "True";
"SYN_PING" -> "False";
"SYN_PING_LIST" -> "80";
"TAXONOMY_TELECOMS" -> "False";
"TELNET_BANNER_SCRAPE" -> "True";
"TELNET_HEURISTIC_TIMEOUT" -> "5.0";
"TELNET_SESSION_MODULE" -> "standard";
"TLS_CIPHERS" -> "ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:!aNULL:!EXPORT:!DES:!3DES:!RC4:!MD5:!PSK:!aECDH:!DSS:!CAMELLIA";
"TOPOLOGY_DISCOVERY_ENABLED" -> "True";
"TRANSITION_FROM_DEFAULT_SCOPE" -> "False";
"UI_DML_EXTRACTION_ENABLED" -> "False";
"UI_REDIRECT_HTTP" -> "True";
"UPGRADE_UPLOAD_ENABLED" -> "True";
"USE_GETBULK" -> "True";
"VAULT_LOG_LEVEL" -> "20";
"VAULT_OMNIORB_TRACE_CONFIGURATION" -> "1";
"VCENTER_HISTORICAL_LIMIT" -> "86400";
"VCENTER_POLLING_INTERVAL" -> "600";
"VMWARE_PROBE_DELAY" -> "1.0";
"VMWARE_TIME_SYNC" -> "False";
"VSPHERE_HEURISTIC_TIMEOUT" -> "5.0";
"VSPHERE_QUERY" -> "True";
"WBEM_QUERIES" -> "True";
"WBEM_RESPONSE_TIMEOUT" -> "14400.0";
"WEB_API" -> "True";
"XMLAPI" -> "True";
"WHATFIX_ENABLED" -> "True";
"WRITE_DISCOVERY_POOL_DATA" -> "False";
default -> "";
end table;


definitions print 1.0
    """
        Enhanced logging functions.

        Author: Wes Moskal-Fitzpatrick

        Change History:
        2022-04-27 | 1.0 | WMF | Created

    """

    define info(active, message)
        """Enhanced info."""
        if active then
            log.info(message);
        end if;
    end define;
    
    define debug(active, message)
        """Enhanced debug."""
        if active then
            log.debug(message);
        end if;
    end define;

    define critical(active, message)
        """Enhanced critical."""
        if active then
            log.critical(message);
        end if;
    end define;

    define warn(active, message)
        """Enhanced warn."""
        if active then
            log.warn(message);
        end if;
    end define;

    define error(active, message)
        """Enhanced error."""
        if active then
            log.error(message);
        end if;
    end define;

    define attribute(active, message, attribute)
        """Log an attribute in debug."""
        if active then
            log.debug("%message% = %attribute%");
        end if;
    end define;

    define data_type(active, message, attribute)
        """Log an attribute in debug."""
        if active then
            dt:= datatype(attribute);
            log.debug("%message% = %dt%");
        end if;
    end define;

    define list_size(active, message, _list_)
        """Get size of a list."""
        if active then
            sz:= size(_list_);
            log.debug("%message% = %sz%");
        end if;
    end define;

end definitions;

definitions node 1.0
    """
        Enhanced node functions.

        Author: Wes Moskal-Fitzpatrick

        Change History:
        2022-04-28 | 1.0 | WMF | Created

    """

    define addAttribute(node, attribute, value, display := false)
        """
            Add an attribute to a node and set display options.
        """
        if value then
            node[attribute]:= value;
            if display then
                model.addDisplayAttribute(node, attribute);
            end if;
        else
            node[attribute]:= void;
            model.removeDisplayAttribute(node, attribute);
        end if;
    end define;

    define removeAttributes(node, attributes)
        """
            Remove attributes.
        """
        for attribute in attributes do
            node[attribute]:= void;
            model.removeDisplayAttribute(node, attribute);
        end for;
    end define;

end definitions;


definitions output 1.0
    """
        Enhanced output functions.

        Author: Alex Read

        Change History:
        2022-07-11 | 1.0 | AR | Created

    """

	define numberToReadableFormat(value, type) -> rf
		"""
            Take a numeric value and convert it to a more human readable format
        """
		
		readable_format := value;
		
		if type = 'bytes' then
		
			if value >= 1099511627776 then
				readable_format := number.toText(value / 1099511627776) + 'TB';
			elif value >= 1073741824 then
				readable_format := number.toText(value / 1073741824) + 'GB';
			elif value >= 1048576 then
				readable_format := number.toText(value / 1048576) + 'MB';
			elif value >= 1024 then
				readable_format := number.toText(value / 1024) + 'KB';
			else
				readable_format := number.toText(value) + 'B';
			end if;
			
		elif type = 'kilobytes' then
		
			if value >= 1073741824 then
				readable_format := number.toText(value / 1073741824) + 'TB';
			elif value >= 1048576 then
				readable_format := number.toText(value / 1048576) + 'GB';
			elif value >= 1024 then
				readable_format := number.toText(value / 1024) + 'MB';
			else
				readable_format := number.toText(value) + 'KB';
			end if;
			
		end if;	

    return readable_format;
  end define;

end definitions;


pattern traversys_discoData 1.1

    '''
    Authors: Wes Moskal-Fitzpatrick, Alex Read

    Description:
    Get additional data about the state of the Discovery instance.

    Change History:
    2022-04-27 | 1.0 | WMF | Created.
	2022-07-14 | 1.1 | AR  | Added REST API functionality
    '''

    overview 
        tags traversys, custom;
    end overview;

    constants
        tw_path:= "/usr/tideway/bin";
    end constants;
    
    triggers 
        on disco := SoftwareInstance created, confirmed where type = "BMC Discovery";
    end triggers;

    body

        host := related.host(disco);
        
		api_versions := [];
		api_max_version := "1.0";
		
		// API Setup
		//
		// Create new Discovery user - Template: User (Not API Access)
		// Set password for user
		// Create new (REST API with OAuth2 authentication) credential
		// Fill in User details - User & Password
		// Leave REST API with OAuth2 authentication section unchanged
		//
		// User permission required:
		//		[admin] - Licensing
		//		[api-access]
		//		[never-deactivate]
		
		// GET request, no authentication, HTTP on default port. Response is JSON encoded
		url := '/api/about';
		auth := '';
		result := discovery.restfulGet(host, auth, url);
				 
		if result then
			if result.response_status = 200 then
				if result.response_body then
				 
					decoded := json.decode(result.response_body);  
					 
					if decoded then 
						api_versions := list.sorted(decoded["api_versions"], reverse:=true);
						api_max_version := number.toText(api_versions[0]);
						log.debug("Found API versions from REST API");
					else
					   log.debug("Failed to json decode %url% response. Raw response: %result.response_body%");
					end if;
				else
					log.debug("%url% returned no response body");
				end if;           
			else
				log.debug("%url% returned %result.response_status%");
			end if;           
		else
			log.debug("Failed to query %url%");            
		end if;
		
		
		not_ok_results  := table();
        tku_levels      := table();
        cmdb_connections:= table();

        // Baseline
        baseline:= discovery.runCommand(host, "%tw_path%/tw_baseline --no-highlight");
        if baseline and baseline.result then
            highest:= regex.extract(baseline.result,"Highest severity failure was (.*)",raw "\1",no_match:= none);
            node.addAttribute(disco, "baseline_highest", highest, true);
            not_ok:= regex.extractAll(baseline.result, "(.*: (CRITICAL|MAJOR|MINOR|INFO).*)");
            if size(not_ok) > 0 then
                for result in not_ok do
                    not_ok_results[result[0]]:= result[1];
                end for;
                print.data_type(false,"Results",not_ok_results);
                node.addAttribute(disco, "baseline_warnings", not_ok_results, true);
            end if;
        else
            node.removeAttributes(disco, [ "baseline_highest", "baseline_warnings" ]);
        end if;

        // TKU Level - Local Only
        appliance_name:= system.getOption("APPLIANCE_NAME");
        hostname:= discovery.runCommand(host, "hostname");
        hostn:= regex.extract(hostname.result, "(\S+)", raw "\1");
        print.attribute(true,"Hostname",hostn);
        if host.hostname = hostn then
            print.attribute(true,"Appliance Name",appliance_name);
            if disco.appliance_name = appliance_name then
                tkus:= search(KnowledgeUpload where origin = "TKU" and modified = 0);
                if size(tkus) > 0 then
                    tku_levels['TKU']:= "Not Found!";
                    tku_levels['EDP']:= "Not Found!";
                    tku_levels['Storage']:= "Not Found!";
                    for tku in tkus do
                        if tku.package = "Technology Knowledge Update" then
                            tku_levels['TKU']:= tku.name;
                        end if;
                        if tku.package = "Extended Data Pack" then
                            tku_levels['EDP']:= tku.name;
                        end if;
                        if tku.package = "Technology Knowledge Update - Storage" then
                            tku_levels['Storage']:= tku.name;
                        end if;
                        if tku.package = "Technology Knowledge Update - ServiceNowSync" then
                            tku_levels['ServiceNow']:= tku.name;
                        end if;
                    end for;
                    node.addAttribute(disco, "TKU_levels", tku_levels, true);
                end if;
            else
                node.removeAttributes(disco, [ "TKU_levels" ]);
            end if;
        else
            node.removeAttributes(disco, [ "TKU_levels" ]);
            // -- API

        end if;

        // Config Dump
        config_dump:= discovery.runCommand(host, "%tw_path%/tw_config_dump");

        if config_dump and config_dump.result then
            config_xml:= xpath.openDocument(regex.extract(config_dump.result, regex '(?is)(<\?xml.*</config>)', raw "\1"));

            // CMDB Sync
            syncs := xpath.evaluate(config_xml, '/config/cmdbsync/cmdb/name');
            if syncs then
                for name in syncs do
                    cmdbs := xpath.evaluate(config_xml, '/config/cmdbsync/cmdb[name="%name%"]/host/text()');
                    ports := xpath.evaluate(config_xml, '/config/cmdbsync/cmdb[name="%name%"]/port/text()');
                    if cmdbs then
                        cmdb:= cmdbs[0];
                        port:= ports[0];
                        connection:= "%cmdb%:%port%";
                    else
                        port:= ports[0];
                        connection:= "%name%:%port%";
                    end if;
                    cmdb_connections[name]:= connection;
                end for;
                node.addAttribute(disco, "CMDB_connections", cmdb_connections, true);
            else
                node.removeAttributes(disco, [ "CMDB_connections" ]);
            end if;
        else
            node.removeAttributes(disco, [ "CMDB_connections" ]);
        end if;

        // Vault Status
        // -- API
		// -- API User DOES NOT require [Vault] permission
		vault_status := table();
		
		url := "/api/v%api_max_version%/vault";
		auth := "oauth2";
		result := discovery.restfulGet(host, auth, url);
				 
		if result then
			if result.response_status = 200 then
				if result.response_body then
				 
					decoded := json.decode(result.response_body);  
					 
					if decoded then 
						
						vault_status['Open'] := decoded["open"];
						vault_status['Passphrase Saved'] := decoded["passphrase_saved"];
						vault_status['Passphrase Set'] := decoded["passphrase_set"];
						
						node.addAttribute(disco, "vault_status", vault_status, true);
						
						log.debug("Found Vault Status from REST API");
					else
					   log.debug("Failed to json decode %url% response. Raw response: %result.response_body%");
					end if;
				else
					log.debug("%url% returned no response body");
				end if;           
			else
				log.debug("%url% returned %result.response_status%");
			end if;           
		else
			log.debug("Failed to query %url%");            
		end if;

        // Licensing
        // -- API
		// -- API User requires [Admin] permission
		licensing_report := "";
		
		url := "/api/v%api_max_version%/admin/licensing";
		auth := "oauth2";
		result := discovery.restfulGet(host, auth, url);
				 
		if result then
			if result.response_status = 200 then
				if result.response_body then
				 
					lic_report_lines := text.split(result.response_body, "\n");					
					
					lic_cloud_sw_counts := table();
					lic_cloud_vm_counts := table();
					lic_host_counts := table();
					
					lic_month_count := '';
					lic_month := '';
					
					lic_cloud_sw_begin_count := false;
					lic_cloud_vm_begin_count := false;
					lic_host_begin_count := false;
					
					lic_report_start := '';
					lic_report_end := '';
					
					month_high_cloud_cap := '';
					month_high_host_cap := '';
					
					for lic_report_line in lic_report_lines do
					
						if lic_report_line <> '' then
						
							if lic_report_start = '' then
								if lic_report_line matches regex '^Report start time:' then
									lic_report_start := regex.extract(lic_report_line, regex '^Report start time:\s+(.*)', raw '\1');
								end if;
							end if;
						
							if lic_report_end = '' then
								if lic_report_line matches regex '^Report end time\s+:' then
									lic_report_end := regex.extract(lic_report_line, regex '^Report end time\s+:\s+(.*)', raw '\1');
								end if;
							end if;
						
							if lic_report_start <> '' and lic_report_end <> '' then
							// Licence Start and End times have been recorded
							
								if month_high_cloud_cap = '' then
									if lic_report_line matches regex '^Highest monthly average capacity for Cloud Resources::' then
										month_high_cloud_cap := regex.extract(lic_report_line, regex '^Highest monthly average capacity for Cloud Resources:\s+(\d+)\s+\((\d{4}\-\d{2})', raw '\2 \1');
									end if;
								end if;
							
								if month_high_host_cap = '' then
									if lic_report_line matches regex '^Highest monthly average capacity for Hosts:' then
										month_high_host_cap := regex.extract(lic_report_line, regex '^Highest monthly average capacity for Hosts:\s+(\d+)\s+\((\d{4}\-\d{2})', raw '\2 \1');
									end if;
								end if;
								
								if lic_report_line has substring 'Cloud Hosted Software (Cloud Resources)' then
									lic_cloud_sw_begin_count := true;
								end if;
								
								if lic_report_line has substring 'Cloud Virtual Machines (Cloud Resources)' then
									lic_cloud_vm_begin_count := true;
									lic_cloud_sw_begin_count := false;
								end if;
								
								if lic_report_line has substring 'Hosts (Hosts)' then
									lic_host_begin_count := true;
									lic_cloud_vm_begin_count := false;
								end if;
								
			
								if lic_cloud_sw_begin_count = true or lic_cloud_vm_begin_count = true or lic_host_begin_count = true then
									if lic_report_line matches regex '\d{4}\-\d{2}\s' then
										
										lic_month_count := regex.extractAll(lic_report_line, regex '(\d{4}\-\d{2})\s\-\s+(\d+)');
										lic_month := lic_month_count[0][0];
										
										if lic_cloud_sw_begin_count = true then
											lic_cloud_sw_counts["%lic_month%"] := lic_month_count[0][1];
										elif lic_cloud_vm_begin_count = true then
											lic_cloud_vm_counts["%lic_month%"] := lic_month_count[0][1];
										 elif lic_host_begin_count = true then
											lic_host_counts["%lic_month%"] := lic_month_count[0][1];
										end if;
									end if;
								end if;
							
							end if;
							
							if lic_report_line = '-----BEGIN LICENSE REPORT SIGNATURE-----' then
								// No more counts to record - end the loop
								break;
							end if;
						
						end if;
					
					end for;

					// Licensing is split into 2 'Discovery Licensing' Detail nodes, one for Cloud Resources, one for Hosts 

					if month_high_cloud_cap <> '' then
						// Don't include Cloud Resources unless there is actually some cloud discovery taking place
						
						cloud_lic_detail := model.Detail(key := "%disco.key%/Discovery Licensing/Cloud Resources", type := 'Discovery Licensing', name := "Cloud Resources", licensing_report_start_time := lic_report_start, licensing_report_end_time := lic_report_end, highest_monthly_average_capacity := month_high_cloud_cap, average_hosted_software_per_month := lic_cloud_sw_counts, average_virtual_machines_per_month := lic_cloud_vm_counts);
						model.rel.Detail(ElementWithDetail := disco, Detail:= cloud_lic_detail);
					
					end if;
					
					if month_high_host_cap <> '' then
						// Don't include Hosts unless there is actually some local discovery taking place
						host_counts := text.split(result.response_body, "\n");					
						host_lic_detail := model.Detail(key := "%disco.key%/Discovery Licensing/Hosts", type := 'Discovery Licensing', name := "Hosts", licensing_report_start_time := lic_report_start, licensing_report_end_time := lic_report_end, highest_monthly_average_capacity := month_high_host_cap, average_hosts_per_month := lic_host_counts);
						model.rel.Detail(ElementWithDetail := disco, Detail:= host_lic_detail);
					
					end if;
					
					log.debug("Found Vault Status from REST API");
					
				else
					log.debug("%url% returned no response body");
				end if;           
			else
				log.debug("%url% returned %result.response_status%");
			end if;           
		else
			log.debug("Failed to query %url%");            
		end if;

        // NTP Status
        ntp_stat:= discovery.runCommand(host, 'command -v timedatectl &> /dev/null && timedatectl status | grep "NTP" || ntpstat');
        timezone:= discovery.runCommand(host, 'command -v timedatectl &> /dev/null && timedatectl status | grep "Time zone" || cat /etc/sysconfig/clock && date +%Z');
        if ntp_stat and ntp_stat.result then
            ntp_enabled:= regex.extract(ntp_stat.result,"NTP enabled: (\w+)",raw "\1",no_match:= none);
            ntp_synced:= regex.extract(ntp_stat.result,"NTP synchronized: (\w+)",raw "\1",no_match:= none);
            node.addAttribute(disco, "NTP_enabled", ntp_enabled, true);
            node.addAttribute(disco, "NTP_synchronised", ntp_synced, true);
        else
            node.removeAttributes(disco, [ "NTP_enabled", "NTP_synchronised" ]);
        end if;
        if timezone and timezone.result then
            time_zone:= regex.extract(timezone.result,"Time zone: (.*)",raw "\1",no_match:= none);
            node.addAttribute(disco, "timezone", time_zone, true);
        else
            node.removeAttributes(disco, [ "timezone" ]);
        end if;

        // Core Dumps
        cores:= discovery.runCommand(host, 'command -v tw_check_cores &> /dev/null && tw_check_cores || ls -l /usr/tideway/cores');
        if cores and cores.result then
            result:= regex.extract(cores.result, regex "(\w.*)", raw "\1", no_match:= cores.result); // strip newline chars
            node.addAttribute(disco, "core_dumps", result, true);
        else
            node.removeAttributes(disco, [ "core_dumps" ]);
        end if;

        // LDAP config
        ldap:= discovery.runCommand(host, '%tw_path%/tw_secopts | grep LDAP_ENABLED');
        if ldap and ldap.result then
            result:= regex.extract(ldap.result, regex "(\w.*)", raw "\1", no_match:= ldap.result); // strip newline chars
            node.addAttribute(disco, "ldap", result, true);
        else
            node.removeAttributes(disco, [ "ldap" ]);
        end if;
        
        // Syslog
        syslog:= discovery.runCommand(host, 'command -v systemctl && systemctl is-active rsyslog');
        if syslog and syslog.result then
            result:= regex.extract(syslog.result, regex "systemctl\s+(\w+)", raw "\1", no_match:= syslog.result); // strip newline chars
            node.addAttribute(disco, "syslog", result, true);
        else
            node.removeAttributes(disco, [ "syslog" ]);
        end if;

        // Cluster Health
        cluster:= discovery.runCommand(host, '%tw_path%/tw_cluster_control --show-members');
        if cluster and cluster.result then
            members:= regex.extract(cluster.result, regex "Number of Members : (\d+)", raw "\1");
            membs:= text.toNumber(members);
            if membs > 0 then
                node.addAttribute(disco, "cluster_size", membs, true);
                faults:= regex.extract(cluster.result, regex "Fault Tolerance : (.*)", raw "\1");
                node.addAttribute(disco, "fault_tolerance", faults, true);
            end if;
        else
            node.removeAttributes(disco, [ "cluster_size", "fault_tolerance" ]);
        end if;

        // UI Errors

        // Deprecated Taxonomy
		
		// Deprecated features within modelled data
		// /usr/tideway/bin/tw_check_reports_model
		
		// Patterns using deprecated attributes
		// /usr/tideway/bin/tw_tax_deprecated
		
		// Custom Taxonomy
		// find /usr/tideway/data/*/taxonomy/ -type f -iname "*.xsl" -o -iname "*.xml"

        // VMWare tools

        // Non-default options
		
		non_default_options := table();
		non_default_option_values := table();
		
		run_cmd_options := discovery.runCommand(host,"%tw_path%/tw_options | egrep -e '\s+=\s+' | sed 's/  = /=/g;s/  \+//g'");
		
		option_pairs := text.split(run_cmd_options.result, "\r\n");
		
		for option_pair in option_pairs do
			
			// Port Options are lists
			if option_pair matches regex "[]]$" then
				
				option_name := regex.extract(option_pair, regex "(\w+)");
				option_values := text.split(text.replace(text.replace(regex.extract(option_pair, regex "=\s*[[](.*)[]]", raw "\1"),", ",","),"'",""), ",");
				
				// Check for missing Default values
				default_not_in_current := [];
				
				for default_value in defaultOptionLists[option_name] do
					in_list := false;
					for option_value in option_values do
						if default_value = option_value then
							in_list := true;
						end if;
					end for;
					if in_list = false then
						list.append(default_not_in_current, default_value);
					end if;
				end for;
				
				// Check for additional values
				current_not_in_default := [];
				
				for option_value in option_values do
					if option_value <> '' then
						in_list := false;
						for default_value in defaultOptionLists[option_name] do
							if default_value = option_value then
								in_list := true;
							end if;
						end for;
						if in_list = false then
							list.append(current_not_in_default, option_value);
						end if;
					end if;
				end for;
				
				if size(current_not_in_default) > 0 then
					non_default_options['%option_name% (Added)'] := current_not_in_default;
				end if;
				if size(default_not_in_current) > 0 then
					non_default_options['%option_name% (Removed)'] := default_not_in_current;
				end if;
			
			else
				option_name := regex.extract(option_pair, regex "(\w+)");
				option_value := text.replace(regex.extract(option_pair, regex "=\s*(.*)", raw "\1"),"'","");
				default_option_value := defaultOptions[option_name];

				if option_value <> default_option_value then
					non_default_options['%option_name% (Altered from: %default_option_value%)'] := option_value;
				end if;
			end if;
		end for;
		
		node.addAttribute(disco, "non_default_options", non_default_options, true);
		
        // Config Dump

        // Crontab

        // List of Users
		
		
		list_users := discovery.runCommand(host,"%tw_path%/tw_listusers | egrep -o '\\b^[a-zA-Z0-9@_+=-]+'");
		
        // Consolidation
		
		consolidation_status := discovery.runCommand(host,'%tw_path%/tw_reasoningstatus --consolidation-status');
		if consolidation_status and consolidation_status.result then
            result:= regex.extract(consolidation_status.result, regex "(\w.*)", raw "\1", no_match:= consolidation_status.result); // strip newline chars
            node.addAttribute(disco, "consolidation_status", result, true);
        else
            node.removeAttributes(disco, [ "consolidation_status" ]);
        end if;
		

        // Outposts

        // Discovery Status

        // SSL Config

        // DNS settings

        // Compaction

        // Uname info
		
		uname := discovery.runCommand(host,"uname -a");

        // Version Info
		
		// Disk Usage
		
		discovery_disk_usage  := table();
		
		pool_size := 0;
		rec_size := 0;
		debug_size := 0;
		data_size := 0;
		trans_size := 0;
		backup_size := 0;
		swap_size := 0;
		disk_size := 0;
		discovery_disk_usage_pct := 0;
		
		run_cmd_pool_size := discovery.runCommand(host,'du -s /usr/tideway/var/pool');
		if run_cmd_pool_size and run_cmd_pool_size.result then
			pool_size := text.toNumber(regex.extract(run_cmd_pool_size.result, regex '(\d+)', raw "\1"));						  
		end if;
		
		run_cmd_rec_size := discovery.runCommand(host,'du -s /usr/tideway/var/record');
		if run_cmd_rec_size and run_cmd_rec_size.result then
			rec_size := text.toNumber(regex.extract(run_cmd_rec_size.result, regex '(\d+)', raw "\1"));						  
		end if;
		
		run_cmd_debug_size := discovery.runCommand(host,'du -s /usr/tideway/log/');
		if run_cmd_debug_size and run_cmd_debug_size.result then
			debug_size := text.toNumber(regex.extract(run_cmd_debug_size.result, regex '(\d+)', raw "\1"));						  
		end if;

		run_cmd_data_size := discovery.runCommand(host,'du -s /usr/tideway/var/localdisk/tideway.db/data');
		if run_cmd_data_size and run_cmd_data_size.result then
			data_size := text.toNumber(regex.extract(run_cmd_data_size.result, regex '(\d+)', raw "\1"));					  
		end if;
		
		run_cmd_trans_size := discovery.runCommand(host,'du -s /usr/tideway/var/localdisk/tideway.db/logs');
		if run_cmd_trans_size and run_cmd_trans_size.result then
			trans_size := text.toNumber(regex.extract(run_cmd_trans_size.result, regex '(\d+)', raw "\1"));						  
		end if;
		
		run_cmd_backup_size := discovery.runCommand(host,'du -s /usr/tideway/var/localdisk/backup');
		if run_cmd_backup_size and run_cmd_backup_size.result then
			backup_size := text.toNumber(regex.extract(run_cmd_backup_size.result, regex '(\d+)', raw "\1"));						  
		end if;
		
		run_cmd_swap_size := discovery.runCommand(host,'cat /proc/swaps');
		if run_cmd_swap_size and run_cmd_swap_size.result then
			swap_size := text.toNumber(regex.extract(run_cmd_swap_size.result, regex 'partition\s+(\d+)', raw "\1"));					  
		end if;

		discovery_size := pool_size + rec_size + debug_size + data_size + trans_size + backup_size + swap_size;
		discovery_size_hr := output.numberToReadableFormat(discovery_size, 'kilobytes');
		
		run_cmd_disk_size := discovery.runCommand(host,'sudo fdisk -l | grep sda:');
		if run_cmd_disk_size and run_cmd_disk_size.result then
			disk_size := text.toNumber(regex.extract(run_cmd_disk_size.result, regex '(\d+)\sbytes', raw "\1"));
			
			discovery_disk_usage_pct := ((100000000000 / (disk_size / 1024)) * discovery_size) / 1000000000;
			discovery_disk_usage_pct_hr := number.toText(discovery_disk_usage_pct);
		
			
			disk_size_hr := output.numberToReadableFormat(disk_size,'bytes');
			
			discovery_disk_usage_summary := 'Discovery is using %discovery_size_hr% of %disk_size_hr% (%discovery_disk_usage_pct_hr%)';
			node.addAttribute(disco, "discovery_disk_usage_summary", discovery_disk_usage_summary, true);
			
			node.addAttribute(disco, "disk_size", disk_size_hr, true);
        else
            node.removeAttributes(disco, [ "disk_size" ]);						  
		end if;
				
		swap_size_hr := output.numberToReadableFormat(swap_size, 'kilobytes');
		data_size_hr := output.numberToReadableFormat(data_size, 'kilobytes');
		trans_size_hr := output.numberToReadableFormat(trans_size, 'kilobytes');
		debug_size_hr := output.numberToReadableFormat(debug_size, 'kilobytes');
		rec_size_hr := output.numberToReadableFormat(rec_size, 'kilobytes');
		pool_size_hr := output.numberToReadableFormat(pool_size, 'kilobytes');
		backup_size_hr := output.numberToReadableFormat(backup_size, 'kilobytes');
		
		discovery_disk_usage['Swap Partition (/proc/swaps)'] := swap_size_hr;
		discovery_disk_usage['Datastore Data (/usr/tideway/var/localdisk/tideway.db/data)'] := data_size_hr;
		discovery_disk_usage['Datastore Transaction Logs (/usr/tideway/var/localdisk/tideway.db/logs)'] := trans_size_hr;
		discovery_disk_usage['Debug Logs (/usr/tideway/log/)'] := debug_size_hr;
		discovery_disk_usage['Record Data (/usr/tideway/var/record)'] := rec_size_hr;
		discovery_disk_usage['Pool Data (/usr/tideway/var/pool)'] := pool_size_hr;
		discovery_disk_usage['Backup Data (/usr/tideway/var/localdisk/backup)'] := backup_size_hr;
		discovery_disk_usage['Total'] := discovery_size_hr;
		
		node.addAttribute(disco, "discovery_disk_usage", discovery_disk_usage, true);
		

    end body;

end pattern;

// The MIT License (MIT)

// Copyright Wes Moskal-Fitzpatrick 2013-2022

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.