tpl 1.0 module traversys_Simple_Ids;

identify 3Com 1.0
  tags 3com;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd '3cmlink' -> 'traversys', '3Com Winmodem Driver';
end identify;

identify 3Ware 1.0
  tags 3Ware;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd '3dmd' -> 'traversys', '3Ware 3DM Disc Monitor';
    windows_cmd '3dm'  -> 'traversys', '3Ware 3DM Disc Monitor';
end identify;

identify A2iA 1.0
  tags A2iA;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'A2iARCPg'      -> 'traversys', 'A2iA Checkreader Server Service Executable';
    windows_cmd 'A2iA_Service'  -> 'traversys', 'A2iA Checkreader Server Service Executable';
end identify;

identify Actimize 1.0
  tags Actimize;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'AISSrv' -> 'traversys', 'Actimize Analytics Intelligence Server Service';
end identify;

identify ActivePDF 1.0
  tags ActivePDF;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'APDCDFLT' -> 'traversys', 'ActivePDF Default Processor';
    windows_cmd 'APDCEX2K' -> 'traversys', 'ActivePDF Excel 2000 DocConverter';
    windows_cmd 'APDCPOST' -> 'traversys', 'ActivePDF PostScript DocConverter';
    windows_cmd 'APDCPP2K' -> 'traversys', 'ActivePDF PowerPoint 2000 DocConverter';
    windows_cmd 'APDCSYSO' -> 'traversys', 'ActivePDF DocConverter SystemOnly Launch';
    windows_cmd 'APDCWD2K' -> 'traversys', 'ActivePDF Word 2000 DocConverter';
    windows_cmd 'APDOCCNV' -> 'traversys', 'ActivePDF DocConverter';
    windows_cmd 'APSERVER' -> 'traversys', 'activePDF Server';
    windows_cmd 'APSPOOL'  -> 'traversys', 'ActivePDF Spooler';
    windows_cmd 'APWEBGRB' -> 'traversys', 'activePDF WebGrabber';
end identify;

identify Actuate 1.0
  tags Actuate;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'actuatewindowsservice' -> 'traversys', 'Actuate Windows Service';
end identify;

identify AcuCorp 1.0
  tags AcuCorp;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'acurcl'   -> 'traversys', 'AcuCorp AcuConnect Listener';
    unix_cmd 'acushare' -> 'traversys', 'AcuCorp Acushare License Manager Service';
end identify;

identify Adaptec 1.0
  tags Adaptec;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'aqagent' -> 'traversys', 'Adaptec Application Quiesce Agent';
end identify;

identify AdLib 1.0
  tags AdLib;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'AdlibFMR' -> 'traversys', 'AdLib Express Data Execution Prevention';
    windows_cmd 'AdlibPDF' -> 'traversys', 'AdLib Express Data Execution Prevention';
end identify;

identify Adobe 1.0
  tags Adobe;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'AcrobatElementsServer' -> 'traversys', 'Adobe Elements Server';
    windows_cmd 'acrobat'               -> 'traversys', 'Adobe Acrobat Writer';
    windows_cmd 'acrodist'              -> 'traversys', 'Adobe Acrobat Distiller';
    windows_cmd 'Adobe\sMedia\sPlayer'  -> 'traversys', 'Adobe Media Player';
    windows_cmd 'AdobeUpdateManager'    -> 'traversys', 'Adobe Update Manager';
    windows_cmd 'AdobeUpdater'          -> 'traversys', 'Adobe Updater';
    windows_cmd 'AOM'                   -> 'traversys', 'Adobe Automatic Updater';
    windows_cmd 'apdproxy'              -> 'traversys', 'Adobe Photoshop';
    windows_cmd 'CANamingAdapter'       -> 'traversys', 'Adobe ColdFusion Server Adaptor';
    windows_cmd 'ccmgr'                 -> 'traversys', 'Adobe ColdFusion Monitoring Service (ClusterCATS Service)';
    windows_cmd 'cfexec'                -> 'traversys', 'Adobe ColdFusion Executive (Cold Fusion Executive)';
    windows_cmd 'cfrdsservice'          -> 'traversys', 'Adobe ColdFusion RDS';
    windows_cmd 'cfserver'              -> 'traversys', 'Adobe Cold Fusion Application Server';
    windows_cmd 'distill'               -> 'traversys', 'Adobe Acrobat Distiller';
    windows_cmd 'FlexBuilder'           -> 'traversys', 'Adobe Flex Builder';
    windows_cmd 'reader_sl'             -> 'traversys', 'Adobe Reader SpeedLauncher';
    windows_cmd 'swagent'               -> 'traversys', 'Adobe ColdFusion MX ODBC Agent';
    unix_cmd 'CANamingAdapter'          -> 'traversys', 'Adobe ColdFusion Server Adaptor';
    unix_cmd 'acroread'                 -> 'traversys', 'Adobe Acrobat Reader';
end identify;

identify AMD 1.0
  tags AMD;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'ati2plxx' -> 'traversys', 'AMD ATI Display Adapter';
    windows_cmd 'Atiptaxx' -> 'traversys', 'AMD ATI Display Adapter';
end identify;

identify Arcana 1.0
  tags Arcana;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'adscheduler' -> 'traversys', 'Arcana Development Scheduler';
end identify;

identify Attachmate 1.0
  tags Attachmate;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'ssh-rand-helper' -> 'traversys', 'Attachmate WRQ Reflection Secure';
end identify;

identify Avaya 1.0
  tags Avaya;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'acsApp'    -> 'traversys', 'Avaya CMS Supervisor';
    windows_cmd 'acsCNTRL'  -> 'traversys', 'Avaya CMS Supervisor';
    windows_cmd 'acsRep'    -> 'traversys', 'Avaya CMS Supervisor Report Component';
    windows_cmd 'acsSRV'    -> 'traversys', 'Avaya CMS Supervisor Server Component';
    windows_cmd 'ACSTrans'  -> 'traversys', 'Avaya CMS Supervisor';
    windows_cmd 'asaisrvc'  -> 'traversys', 'Avaya ASAI Server';
end identify;

identify BEA 1.4
    tags BEA;
    DiscoveredProcess cmd -> set_by, simple_identity;
        windows_cmd 'AutonomyIDOLServer'  -> 'traversys', 'BEA Weblogic Autonomy IDOL Server';
        windows_cmd 'BBL'                 -> 'traversys', 'BEA Tuxedo System Administrative Bulletin Board Liaison';
        windows_cmd 'BEACMRepoFetch'      -> 'traversys', 'BEA Weblogic Autonomy Search';
        windows_cmd 'beasvc'              -> 'traversys', 'BEA Weblogic Node Manager';
        windows_cmd 'JREPSVR'             -> 'traversys', 'BEA Jolt Repository Server';
        windows_cmd 'slisten'             -> 'traversys', 'BEA Tuxedo Listener';
        windows_cmd 'tuxipc'              -> 'traversys', 'BEA Tuxedo System IPC Helper';
        unix_cmd 'BBL'                    -> 'traversys', 'BEA Tuxedo System Administrative Bulletin Board Liaison';
        unix_cmd 'beasvc'                 -> 'traversys', 'BEA Weblogic Node Manager';
        unix_cmd 'JREPSVR'                -> 'traversys', 'BEA Jolt Repository Server';
        unix_cmd 'slisten'                -> 'traversys', 'BEA Tuxedo Listener';
        unix_cmd 'tuxipc'                 -> 'traversys', 'BEA Tuxedo System IPC Helper';
end identify;

identify Bitvise 1.0
  tags Bitvise;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'winsshd' -> 'traversys', 'Bitvise WinSSHD';
end identify;

identify BMC 1.1
  tags BMC;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'arplugin' -> 'traversys', 'BMC Remedy ARPlugin Server';
    windows_cmd 'arrecond' -> 'traversys', 'BMC Reconciliation Engine';
    windows_cmd 'arserver' -> 'traversys', 'BMC Remedy AR Server';
    unix_cmd 'arforkd' -> 'traversys', 'BMC Remedy Action Request System';
    unix_cmd 'armonitor' -> 'traversys', 'BMC ARS Server Monitor';
    unix_cmd 'arplugin' -> 'traversys', 'BMC Remedy ARPlugin Server';
    unix_cmd 'brsvcbrie' -> 'traversys', 'BMC SLA Application Server';
    regex '(?i)Magic\sJob\sProcessor\s-\sMagicMBA' -> 'traversys', 'BMC Magic Job Processor';
    regex '(?i)(arserver|ar).*\/armonitor' -> 'traversys', 'BMC ARS Server Monitor';
    regex '(?i)ar\ssystem.*\\armonitor' -> 'traversys', 'BMC ARS Server Monitor';
end identify;

identify Broadcom 1.0
  tags Broadcom;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'BacsTray' -> 'traversys', 'Broadcom Advanced Control Suite Tray Icon';
    windows_cmd 'BAsfIpM' -> 'traversys', 'Broadcom ASF IP Monitoring Service';
end identify;

identify Broadgun 1.0
  tags Broadgun;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'bgsmsnd' -> 'traversys', 'Broadgun pdfMachine Background PDF Generator';
end identify;

identify Computer_Associates 1.7
  tags Computer_Associates;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'auto_wto' -> 'traversys', 'Computer Associates Unicenter AutoSys Message transfer';
    unix_cmd 'aws_snmp' -> 'traversys', 'Computer Associates Unicenter AgentWorks SNMP Gateway';
    unix_cmd 'ca_calendar' -> 'traversys', 'Computer Associates Unicenter Calender Service';
    unix_cmd 'caagentd' -> 'traversys', 'Computer Associates ARCServe Client Agent';
    unix_cmd 'cacritmgr' -> 'traversys', 'Computer Associates UniCenter LAN Control';
    unix_cmd 'CaemRtS' -> 'traversys', 'Computer Associates Remote Server';
    unix_cmd 'caft' -> 'traversys', 'Computer Associates Message Queuing File Transfer';
    unix_cmd 'caiccid' -> 'traversys', 'Computer Associates Common Communication Interface';
    unix_cmd 'caiopr' -> 'traversys', 'Computer Associates Unicenter EventManagement';
    unix_cmd 'cam' -> 'traversys', 'Computer Associates Message Queuing Server';
    unix_cmd 'carp_monitor' -> 'traversys', 'Computer Associates Unicenter';
    unix_cmd 'catrapd' -> 'traversys', 'Computer Associates TNGSNM - SNMP Management';
    unix_cmd 'catrapmuxd' -> 'traversys', 'Computer Associates Unicenter CATRAP';
    unix_cmd 'ccirmtd' -> 'traversys', 'Computer Associates Unicenter Remote';
    unix_cmd 'dnasvcd' -> 'traversys', 'Computer Associates Dynamic Node Administrator';
    unix_cmd 'evtcell' -> 'traversys', 'Computer Associates Unicenter TNG Event Manager';
    unix_cmd 'hpaAgent' -> 'traversys', 'Computer Associates Unicenter System Performance';
    unix_cmd 'igateway' -> 'traversys', 'Computer Associates iTechnology Application Server';
    unix_cmd 'mdbcell' -> 'traversys', 'Computer Associates Unicenter Network and Systems Management';
    unix_cmd 'oprsafd' -> 'traversys', 'Computer Associates Unicenter OPR StoreAndForward (SAF)';
    unix_cmd 'ukbsvcd' -> 'traversys', 'Computer Associates Unicenter Knowledgebase Service';
    unix_cmd 'xcomd' -> 'traversys', 'Computer Associates XCOM Advantage Scheduler Service';
    windows_cmd 'addressprocessor' -> 'traversys', 'Computer Associates iLumin Assentor';
    windows_cmd 'ALERT' -> 'traversys', 'Computer Associates Alert Service';
    windows_cmd 'asdscsvc' -> 'traversys', 'Computer Associates ARCServe Discovery Service';
    windows_cmd 'Asmgr' -> 'traversys', 'Computer Associates ARCServe Backup';
    windows_cmd 'Assentor.*\bArchiver' -> 'traversys', 'Assentor Archiver Service';
    windows_cmd 'assentorcontroller' -> 'traversys', 'Computer Associates Assentor Controller';
    windows_cmd 'AssentorMIME' -> 'traversys', 'Computer Associates AssentorMIME';
    windows_cmd 'AssentorQStarMgr.exe$' -> 'traversys', 'Computer Associates Assentor QStarMgr';
    windows_cmd 'autosysd' -> 'traversys', 'Computer Associates Autosys';
    windows_cmd 'aws_dsm' -> 'traversys', 'Computer Associates Unicenter Distributed State Machine Component';
    windows_cmd 'aws_listen' -> 'traversys', 'Computer Associates NetworkIT Trap MUX';
    windows_cmd 'aws_orb' -> 'traversys', 'Computer Associates Unicenter Distributed Services Bus';
    windows_cmd 'aws_sadmin' -> 'traversys', 'Computer Associates Unicenter SNMP Administrator';
    windows_cmd 'aws_snmp' -> 'traversys', 'Computer Associates Unicenter AgentWorks SNMP Gateway';
    windows_cmd 'aws_store' -> 'traversys', 'Computer Associates Object Store Service';
    windows_cmd 'aws_wvgate' -> 'traversys', 'Computer Associates Unicenter WorldView Gateway';
    windows_cmd 'awservices' -> 'traversys', 'Computer Associates Unicenter Service Control Manager';
    windows_cmd 'bb2processor.exe$' -> 'traversys', 'Computer Associates Assentor Bloomberg2 Processor';
    windows_cmd 'BrightStorMgr' -> 'traversys', 'Computer Associates ARCServe Manager';
    windows_cmd 'BulkApprove.exe$' -> 'traversys', 'Computer Associates Assentor BulkApprove';
    windows_cmd 'ca_cal.exe$' -> 'traversys', 'Computer Associates Unicenter Calender Service';
    windows_cmd 'CA_Server.exe$' -> 'traversys', 'Computer Associates Cyrnel Analytics Server';
    windows_cmd 'caamssend' -> 'traversys', 'Computer Associates Unicenter NSM Repository Service Component';
    windows_cmd 'caamssrv' -> 'traversys', 'Computer Associates AMS Windows Service';
    windows_cmd 'CaemRtA.exe$' -> 'traversys', 'Computer Associates Web Interface Service subprocess';
    windows_cmd 'caemrts.exe$' -> 'traversys', 'Computer Associates Unicenter Event Manager Remote Server';
    windows_cmd 'caenfdmn' -> 'traversys', 'Computer Associates Common Services';
    windows_cmd 'caft' -> 'traversys', 'Computer Associates Message Queuing File Transfer';
    windows_cmd 'caftf' -> 'traversys', 'Computer Associates Message Queuing File Transfer';
    windows_cmd 'caiLogA2' -> 'traversys', 'Computer Associates Unicenter Agent Monitoring';
    windows_cmd 'caintos' -> 'traversys', 'Computer Associates Unicenter TNG NT System Agent';
    windows_cmd 'caiSqlA2' -> 'traversys', 'Computer Associates Unicenter SQL A2 Agent';
    windows_cmd 'caiW2kOs' -> 'traversys', 'Computer Associates Unicenter W2K OS Agent';
    windows_cmd 'cam' -> 'traversys', 'Computer Associates Message Queuing Server';
    windows_cmd 'canotify' -> 'traversys', 'Computer Associates Common Services';
    windows_cmd 'caoprdmn' -> 'traversys', 'Computer Associates Common Services';
    windows_cmd 'caoprlog' -> 'traversys', 'Computer Associates Common Services';
    windows_cmd 'caoprsaf' -> 'traversys', 'Computer Associates Common Services';
    windows_cmd 'caschsrv' -> 'traversys', 'Computer Associates Unicenter WorkLoad Agent';
    windows_cmd 'casmrtbk.exe$' -> 'traversys', 'Computer Associates BrightStor ARCServe Backup Client for Windows';
    windows_cmd 'CASmtpService.exe$' -> 'traversys', 'Computer Associates Unicenter SMTP Service';
    windows_cmd 'caSqlAgent.exe$' -> 'traversys', 'Computer Associates Unicenter SQL Server Agent';
    windows_cmd 'casrvmon' -> 'traversys', 'Computer Associates Common Services';
    windows_cmd 'CATNG2D' -> 'traversys', 'Computer Associates Common Services';
    windows_cmd 'catrapd' -> 'traversys', 'Computer Associates TNGSNM - SNMP Management';
    windows_cmd 'cau9mtr' -> 'traversys', 'Computer Associates Common Services';
    windows_cmd 'cau9rmt' -> 'traversys', 'Computer Associates Common Services';
    windows_cmd 'CAUDIRHD' -> 'traversys', 'Computer Associates Unicenter Common Services';
    windows_cmd 'caudirsv' -> 'traversys', 'Computer Associates Common Services';
    windows_cmd 'CAUGUI' -> 'traversys', 'Computer Associates Enterprise Management GUI Application';
    windows_cmd 'caunisrv' -> 'traversys', 'Computer Associates Unicenter Common Services';
    windows_cmd 'CAUTFLD.EXE$' -> 'traversys', 'Computer Associates Unicenter TNG';
    windows_cmd 'cautguid.exe$' -> 'traversys', 'Computer Associates Unicenter Event Management GUI Service';
    windows_cmd 'cauwvdmn' -> 'traversys', 'Computer Associates Unicenter WorldView agent';
    windows_cmd 'ccinrcd' -> 'traversys', 'Computer Associates Unicenter NR-Client';
    windows_cmd 'ccinrsd' -> 'traversys', 'Computer Associates Unicenter NR-Server';
    windows_cmd 'ccirmtd' -> 'traversys', 'Computer Associates Unicenter Remote';
    windows_cmd 'collator' -> 'traversys', 'Computer Associates Assentor Collator';
    windows_cmd 'CPSProcess' -> 'traversys', 'Computer Associates Common Services';
    windows_cmd 'DataRoutSend' -> 'traversys', 'Computer Associates Assentor DataRoutSend';
    windows_cmd 'dbloader' -> 'traversys', 'Computer Associates Assentor Database Loader';
    windows_cmd 'dna' -> 'traversys', 'Computer Associates Dynamic Node Administrator';
    windows_cmd 'dnasvc' -> 'traversys', 'Computer Associates Dynamic Node Administrator Service';
    windows_cmd 'EMServer' -> 'traversys', 'Computer Associates Unicenter TNG/NMS Component';
    windows_cmd 'ErrBox' -> 'traversys', 'Computer Associates Licensing Error';
    windows_cmd 'evtcell' -> 'traversys', 'Computer Associates Unicenter TNG Event Manager';
    windows_cmd 'hpaAgent' -> 'traversys', 'Computer Associates Unicenter System Performance';
    windows_cmd 'iijdbc' -> 'traversys', 'Computer Associates Advantage Ingres JDBC Server';
    windows_cmd 'IluminSDS' -> 'traversys', 'Computer Associates iLumin SDS';
    windows_cmd 'IMProcessor' -> 'traversys', 'Computer Associates Assentor IM Link';
    windows_cmd 'Infopump' -> 'traversys', 'Computer Associates Platinum Infopump';
    windows_cmd 'logonserver' -> 'traversys', 'Computer Associates Unicenter TNG/NMS Component';
    windows_cmd 'mdbcell' -> 'traversys', 'Computer Associates Unicenter Network and Systems Management';
    windows_cmd 'mengine' -> 'traversys', 'Computer Associates Assentor Mail Engine';
    windows_cmd 'Ofant' -> 'traversys', 'Computer Associates Backup Agent for Open Files Service';
    windows_cmd 'quarantinemanager' -> 'traversys', 'Computer Associates Assentor Quarantine Manager';
    windows_cmd 'quenetd' -> 'traversys', 'Computer Associates Unicenter Transport';
    windows_cmd 'RCManClient' -> 'traversys', 'Computer Associates Unicenter TNG Remote Control Client';
    windows_cmd 'RCManServer' -> 'traversys', 'Computer Associates Unicenter TNG Remote Control Service';
    windows_cmd 'RCOService' -> 'traversys', 'Computer Associates Unicenter TNG Remote Control Option';
    windows_cmd 'realmon' -> 'traversys', 'Computer Associates eTrust InoculateIT Agent';
    windows_cmd 'rmcmd' -> 'traversys', 'Computer Associates Unicenter WorkLoad Control Center Remote Command';
    windows_cmd 'rp32serv' -> 'traversys', 'Computer Associates Remote Possible/32 Service';
    windows_cmd 'rp32u' -> 'traversys', 'Computer Associates Unicenter TNG Remote Control Option';
    windows_cmd 'ServiceWrapper' -> 'traversys', 'Computer Associates Wily Introscope';
    windows_cmd 'servproc' -> 'traversys', 'Computer Associates Unicenter WorkLoad Control Center';
    windows_cmd 'SEVPROP' -> 'traversys', 'Computer Associates Unicenter TND Severity Propagation';
    windows_cmd 'tndmdmgr' -> 'traversys', 'Computer Associates Unicenter Network and Systems Management';
    windows_cmd 'ukb' -> 'traversys', 'Computer Associates Unicenter Knowledgebase';
    windows_cmd 'ukbsvc' -> 'traversys', 'Computer Associates Unicenter Knowledgebase Service';
    windows_cmd 'w2fwserv' -> 'traversys', 'Computer Associates Unicenter NSM Auxiliary Services';
    windows_cmd 'w2Tree' -> 'traversys', 'Computer Associates Unicenter TNG/NMS Component';
    windows_cmd 'wvschdsv' -> 'traversys', 'Computer Associates Unicenter Discovery Scheduler';
end identify;

identify Computer_Associates 1.1
  tags Computer_Associates;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'stardaemon' -> 'traversys', 'CA Unicenter NSM Star Daemon';
end identify;

identify Cisco 1.0
  tags Cisco;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'NSnGeniusNative.exe$'  -> 'traversys', 'Cisco nGenius RealTime Monitor';
    unix_cmd 'NSnGeniusNative'          -> 'traversys', 'Cisco nGenius RealTime Monitor';
    unix_cmd 'PsMiddleware'             -> 'traversys', 'Cisco nGenius RealTime Monitor';
end identify;

identify Citrix 1.0
  tags Citrix;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'ActivationServiceHost' -> 'traversys', 'Citrix Citrix Advanced Access Control agent';
    windows_cmd 'AgentSVC'              -> 'traversys', 'Citrix ADF Installer Service';
    windows_cmd 'CitrixExplorer'        -> 'traversys', 'Citrix Citrix Explorer';
    windows_cmd 'ctxactivesync'         -> 'traversys', 'Citrix Citrix Active Sync';
    windows_cmd 'CtxSecGwy'             -> 'traversys', 'Citrix Secure Gateway Service';
    windows_cmd 'fbserver'              -> 'traversys', 'Citrix Firebird EdgeSight Agent';
    windows_cmd 'HCAService'            -> 'traversys', 'Citrix Health Monitoring and Recovery';
    windows_cmd 'IMAAdvanceSrv'         -> 'traversys', 'Citrix Services Manager';
    windows_cmd 'mfcom'                 -> 'traversys', 'Citrix MetaFrame Component Object Model';
    windows_cmd 'PNAMain'               -> 'traversys', 'Citrix Program Neighbourhood Agent';
    windows_cmd 'pn'                    -> 'traversys', 'Citrix Program Neighbourhood';
    windows_cmd 'RadeObj'               -> 'traversys', 'Citrix Streaming Service';
    windows_cmd 'RadeSvc'               -> 'traversys', 'Citrix Streaming Service';
    windows_cmd 'rscorsvc'              -> 'traversys', 'Citrix System Monitoring Agent Service';
    windows_cmd 'saginst'               -> 'traversys', 'Citrix Installer Service';
    windows_cmd 'SemsService'           -> 'traversys', 'Citrix Edgesight Session Experience Monitoring Service';
    windows_cmd 'streamprocess'         -> 'traversys', 'Citrix Stream Service';
    windows_cmd 'StreamService'         -> 'traversys', 'Citrix Stream Service';
    windows_cmd 'stuisrv'               -> 'traversys', 'Citrix Enhanced Logon Status Service';
    windows_cmd 'ctxhide'               -> 'traversys', 'Citrix MetaFrame Presentation Server UserLogon DOS Window Hide';
    unix_cmd 'ctxcdmd'                  -> 'traversys', 'Citrix Client Drive Mapping';
    unix_cmd 'ctxclipboard'             -> 'traversys', 'Citrix MetaFrame for Unix Cut and Paste Activity';
    unix_cmd 'ctxfm'                    -> 'traversys', 'Citrix MetaFrame for Unix Frame Manager';
    unix_cmd 'ctxgrab'                  -> 'traversys', 'Citrix MetaFrame for Unix Cut and Paste Graphics Activity';
    unix_cmd 'ctxibrowser'              -> 'traversys', 'Citrix MetaFrame for Unix ICA Browser';
    unix_cmd 'ctxxmld'                  -> 'traversys', 'Citrix MetaFrame for Unix XML Service';
end identify;

identify Corel 1.0
    tags Corel;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'WZZIP' -> 'traversys', 'Corel WinZip';
end identify;

identify Creative_Labs 1.0
  tags Creative_Labs;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'CTsvcCDA' -> 'traversys', 'Creative Labs Creative Service for CD-ROM Access';
end identify;

identify CrypKey 1.0
  tags CrypKey;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'crypserv' -> 'traversys', 'CrypKey Server';
end identify;

identify Deutsche_Borse 1.0
  tags Deutsche_Borse;
  DiscoveredProcess cmd -> set_by, simple_identity;
    regex '(?i)base\d{2}.*\\avm' -> 'traversys', 'Deutsche Borse GATE Availability Manager';
    regex '(?i)base\d{2}.*\\brcrec' -> 'traversys', 'Deutsche Borse GATE Broadcast Receiver';
    regex '(?i)base\d{2}.*\\gwc' -> 'traversys', 'Deutsche Borse GATE GateWatchClient';
    regex '(?i)base\d{2}.*\\lantc' -> 'traversys', 'Deutsche Borse GATE Lan Transport Client';
    regex '(?i)base\d{2}.*\\PBH' -> 'traversys', 'Deutsche Borse GATE Process Background Handler';
    regex '(?i)base\d{2}.*\\ses' -> 'traversys', 'Deutsche Borse GATE Session Manager';
    unix_cmd 'brcrec' -> 'traversys', 'Deutsche Borse GATE Broadcast Receiver';
    unix_cmd 'gwc' -> 'traversys', 'Deutsche Borse GATE GateWatchClient';
    unix_cmd 'gws' -> 'traversys', 'Deutsche Borse GATE GateWatchServer';
end identify;

identify EAS 1.0
  tags EAS;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'KCBulkLoad'        -> 'traversys', 'EAS Knowledge Capture Bulk Load Module';
    windows_cmd 'KCBulkLoadService' -> 'traversys', 'EAS Knowledge Capture Bulk Load Module';
end identify;

identify Encoded_Media 1.0
  tags Encoded_Media;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'AdminServer' -> 'traversys', 'Encoded Media TV Admin Server';
end identify;

identify Eurex 1.0
  tags Eurex;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'eurexPTC' -> 'traversys', 'Eurex Eurex Printable Trade Confirmations';
end identify;

identify Business_Objects 1.6
    tags Business_Objects;
    DiscoveredProcess cmd -> set_by, simple_identity;
        regex '(?i)[^iona].*\bitconfig_rep' -> 'traversys', 'Business Objects Configuration Repository';
        regex '(?i)[^iona].*\bitlocator' -> 'traversys', 'Business Objects Locator';
        regex '(?i)[^iona].*\bitnaming' -> 'traversys', 'Business Objects Naming Service Database';
        regex '(?i)[^iona].*\bitnode_daemon' -> 'traversys', 'Business Objects Node Daemon';
        unix_cmd 'AAAnalytics' -> 'traversys', 'Business Objects XI AAAnalytics Server';
        unix_cmd 'AADashboard' -> 'traversys', 'Business Objects XI AA Dashboard';
        unix_cmd 'AADMining' -> 'traversys', 'Business Objects AA Predictive Analytic Server';
        unix_cmd 'AADMining\.bin' -> 'traversys', 'Business Objects XI AA Mining Engine';
        unix_cmd 'AAMetrics' -> 'traversys', 'Business Objects XI Probe Engine';
        unix_cmd 'AAProfiler' -> 'traversys', 'Business Objects XI Profile Engine';
        unix_cmd 'AAQueryMgr' -> 'traversys', 'Business Objects XI Query Manager';
        unix_cmd 'AARepoMgt' -> 'traversys', 'Business Objects XI Report Manager';
        unix_cmd 'AARules' -> 'traversys', 'Business Objects XI Rule Engine';
        unix_cmd 'AASPC' -> 'traversys', 'Business Objects XI SPC Engine';
        unix_cmd 'al_jobservice\.e' -> 'traversys', 'Business Objects Data Integrator Job Server';
        unix_cmd 'boe_cachesd' -> 'traversys', 'Business Objects Enterprise XI Cache Server';
        unix_cmd 'boe_cmsd' -> 'traversys', 'Business Objects Enterprise XI Central Management Server';
        unix_cmd 'boe_crcached\.bin' -> 'traversys', 'Business Objects Enterprise XI Cache Daemon';
        unix_cmd 'boe_crprocd\.bin' -> 'traversys', 'Business Objects Enterprise XI Process Daemon';
        unix_cmd 'boe_crystalra' -> 'traversys', 'Business Objects Enterprise XI Report Application Server';
        unix_cmd 'boe_crystalras' -> 'traversys', 'Business Objects Enterprise XI Report Application Server';
        unix_cmd 'boe_crystalrasd' -> 'traversys', 'Business Objects Crystal Report App Server';
        unix_cmd 'boe_crystalrasd\.bin' -> 'traversys', 'Business Objects Enterprise XI Report Application Server';
        unix_cmd 'boe_eventsd' -> 'traversys', 'Business Objects Enterprise XI Events Server';
        unix_cmd 'boe_fccached' -> 'traversys', 'Business Objects Enterprise XI Desktop Intelligence Cache Server';
        unix_cmd 'boe_fcprocd' -> 'traversys', 'Business Objects Enterprise XI Desktop Intelligence Report Server';
        unix_cmd 'boe_filesd' -> 'traversys', 'Business Objects Enterprise XI Input FRS';
        unix_cmd 'boe_jobcd' -> 'traversys', 'Business Objects Edge Professional XI Job Server Child';
        unix_cmd 'boe_jobsd' -> 'traversys', 'Business Objects Edge Professional XI Job Server';
        unix_cmd 'boe_pagesd' -> 'traversys', 'Business Objects Enterprise XI Page Server';
        unix_cmd 'boe_pagesd\.bin' -> 'traversys', 'Business Objects Enterprise XI Page Server';
        unix_cmd 'BOManager' -> 'traversys', 'Business Objects WebIntelligence Process Launcher';
        unix_cmd 'crystalmsd' -> 'traversys', 'Business Objects Crystal Reports Management Server';
        unix_cmd 'crystalras' -> 'traversys', 'Business Objects Crystal Reports XI Report Application Server';
        unix_cmd 'crystalrasd\.bin' -> 'traversys', 'Business Objects Crystal Reports XI Report Application Server';
        unix_cmd 'WIOrb' -> 'traversys', 'Business Objects CORBA Orb Process';
        unix_cmd 'WIQT' -> 'traversys', 'Business Objects WebIntelligence Query Technique';
        unix_cmd 'WIReportServer' -> 'traversys', 'Business Objects WebIntelligence Report Server';
        windows_cmd 'al_accessserver' -> 'traversys', 'Business Objects Data Integrator Access Server';
        windows_cmd 'al_engine' -> 'traversys', 'Business Objects Data Integrator Engine';
        windows_cmd 'al_jobserver' -> 'traversys', 'Business Objects Data Integrator Job Server';
        windows_cmd 'al_jobservice' -> 'traversys', 'Business Objects Data Integrator Service';
        windows_cmd 'BCAPSupportMgr' -> 'traversys', 'Business Objects Broadcast Agent Support Manager';
        windows_cmd 'BCAPublisherService' -> 'traversys', 'Business Objects BCA Publisher Web Application';
        windows_cmd 'BcsCons' -> 'traversys', 'Business Objects BCA Cluster Manager Console';
        windows_cmd 'BOMgr' -> 'traversys', 'Business Objects Manager';
        windows_cmd 'busobj' -> 'traversys', 'Business Objects Business Reporter';
        windows_cmd 'cacheserver' -> 'traversys', 'Business Objects Crystal Decisions Cache Server';
        windows_cmd 'crcache' -> 'traversys', 'Business Objects Enterprise XI Cache ';
        windows_cmd 'crproc' -> 'traversys', 'Business Objects Enterprise XI';
        windows_cmd 'CrystalAPS' -> 'traversys', 'Business Objects Crystal APS';
        windows_cmd 'CrystalMS' -> 'traversys', 'Business Objects Crystal Management Server';
        windows_cmd 'crystalras' -> 'traversys', 'Business Objects Crystal Reports XI Report Application Server';
        windows_cmd 'designer' -> 'traversys', 'Business Objects Designer SDK';
        windows_cmd 'fileserver' -> 'traversys', 'Business Objects Enterprise Fileserver';
        windows_cmd 'gatekeeper' -> 'traversys', 'Business Objects WebIntelligence Gatekeeper';
        windows_cmd 'itconfig_rep' -> 'traversys', 'Business Objects Configuration Repository';
        windows_cmd 'itlocator' -> 'traversys', 'Business Objects Locator';
        windows_cmd 'itnaming' -> 'traversys', 'Business Objects Naming Service Database';
        windows_cmd 'itnode_daemon' -> 'traversys', 'Business Objects Node Daemon';
        windows_cmd 'outputfileserver' -> 'traversys', 'Business Objects Crystal Output File Repository Server';
        windows_cmd 'webint.*\bjre' -> 'traversys', 'Business Objects WebIntelligence Java';
        windows_cmd 'WIOrb' -> 'traversys', 'Business Objects CORBA Orb Process';
        windows_cmd 'wiqt' -> 'traversys', 'Business Objects WebIntelligence Query Technique';
        windows_cmd 'WIReportServer' -> 'traversys', 'Business Objects WebIntelligence Report Server';
end identify;

identify Fujitsu_Siemens 1.0
  tags Fujitsu_Siemens;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'adaptagt' -> 'traversys', 'Fujitsu Siemens Prime Power ServerView Suite Subagent';
end identify;

identify Global_Maintech_Corp 1.0
  tags Global_Maintech_Corp;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'gwconsole' -> 'traversys', 'Global Maintech Corp Virtual Command Center Console Window';
    unix_cmd 'gwconsolemgrd' -> 'traversys', 'Global Maintech Corp Virtual Command Center Console Manager';
    unix_cmd 'gwEventMgrD' -> 'traversys', 'Global Maintech Corp Virtual Command Center Event Manager';
    unix_cmd 'gwPingerD' -> 'traversys', 'Global Maintech Corp Virtual Command Center Pinger';
    unix_cmd 'gwserialmgrd' -> 'traversys', 'Global Maintech Corp Virtual Command Center Serial Manager';
    unix_cmd 'gwStatMgrD' -> 'traversys', 'Global Maintech Corp Virtual Command Center Stat Manager';
end identify;

identify HP 1.9
  tags HP;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd '\.acuxebin' -> 'traversys', 'HP-UX Configuration Utility for SA5300 RAID Controller';
    unix_cmd '\.adubin' -> 'traversys', 'HP Array Diagnostic Utility';
    unix_cmd 'agdbserver' -> 'traversys', 'HP OpenView Performance Manager Alarmgen DB Server';
    unix_cmd 'alarmgen' -> 'traversys', 'HP OpenView Performance Manager Alarmgen';
    unix_cmd 'cmasasd' -> 'traversys', 'HP SAS Storage Agent';
    unix_cmd 'cmc_em' -> 'traversys', 'HP Support Tools Manager CMC Monitor';
    unix_cmd 'CMServer' -> 'traversys', 'HP Softbench CM Server';
    unix_cmd 'cpe_em' -> 'traversys', 'HP Support Tools Manager Corrected Platform Error (CPE) Monitor for IA-64 Systems';
    unix_cmd 'diagmond' -> 'traversys', 'HP Support Tools Manager';
    unix_cmd 'disk_em' -> 'traversys', 'HP Support Tools Manager Disk Monitor';
    unix_cmd 'dm_chassis' -> 'traversys', 'HP Support Tools Manager Chassis Hardware Monitor';
    unix_cmd 'dm_core_hw' -> 'traversys', 'HP Support Tools Manager Core Hardware Monitor';
    unix_cmd 'dm_FCMS_adapter' -> 'traversys', 'HP Support Tools Manager Fibre Channel Adapters Monitor';
    unix_cmd 'dm_memory' -> 'traversys', 'HP Support Tools Manager Memory Monitor';
    unix_cmd 'dm_ql_adapter' -> 'traversys', 'HP Support Tools Manager Fibre Channel Adapter';
    unix_cmd 'dm_raid_adapter' -> 'traversys', 'HP Support Tools Manager RAID Adapters';
    unix_cmd 'dm_stape' -> 'traversys', 'HP Support Tools Manager SCSI Tape Devices Monitor';
    unix_cmd 'dm_TL_adapter' -> 'traversys', 'HP Support Tools Manager Fibre Channel Adapter';
    unix_cmd 'dtfile' -> 'traversys', 'HP CDE File Manager';
    unix_cmd 'dthelpview' -> 'traversys', 'HP CDE online Help Viewer';
    unix_cmd 'emsagent' -> 'traversys', 'HP Event Monitoring Service Subagent';
    unix_cmd 'fpl_em' -> 'traversys', 'HP Support Tools Manager Corrected Platform Error (CPE) Monitor for IA-64 Systems';
    unix_cmd 'gazemon' -> 'traversys', 'HP StorageWorks DS2500 Monitor';
    unix_cmd 'hagsglsmd' -> 'traversys', 'HP Group Services';
    unix_cmd 'hostAgent' -> 'traversys', 'HP StorageWorks HostAgent';
    unix_cmd 'hp_unixagt' -> 'traversys', 'HP OpenView SNMP subagent';
    unix_cmd 'hpasmd' -> 'traversys', 'HP Advanced System Management';
    unix_cmd 'hpasmxld' -> 'traversys', 'HP Integrated Lights-Out 2 (iLO 2) Management Controller';
    unix_cmd 'hplog' -> 'traversys', 'HP High Performance Logger';
    unix_cmd 'hpnpd' -> 'traversys', 'HP JetDirect Printer Installer';
    unix_cmd 'hpnpf' -> 'traversys', 'HP Direct Delivery Filter';
    unix_cmd 'hpsmh.*rotatelogs' -> 'traversys', 'HP System Management Homepage Logrotate';
    unix_cmd 'hpsmhd' -> 'traversys', 'HP System Management Homepage Monitor';
    unix_cmd 'hpuxci' -> 'traversys', 'HP-UX DMI Component';
    unix_cmd 'hpvmmcnt' -> 'traversys', 'HP Virtual Machine Management Agent';
    unix_cmd 'hpwebjetd' -> 'traversys', 'HP Web Jetadmin Service';
    unix_cmd 'ia64_corehw' -> 'traversys', 'HP Support Tools Manager Core Hardware Monitor for IA-64 Systems';
    unix_cmd 'icodd' -> 'traversys', 'HP Instant Capacity on Demand (iCOD)';
    unix_cmd 'isis-protos' -> 'traversys', 'HP OpenView Operations Manager';
    unix_cmd 'lpmc_em' -> 'traversys', 'HP Support Tools Manager CPU Monitor';
    unix_cmd 'memory_ia64' -> 'traversys', 'HP Support Tools Manager Itanium Memory Monitor';
    unix_cmd 'mib2agt' -> 'traversys', 'HP-UX SNMP MIB-2 Subagent';
    unix_cmd 'opceca' -> 'traversys', 'HP OpenView Operations Event Correlation Agent';
    unix_cmd 'opcecaas' -> 'traversys', 'HP OpenView ECS Annotate Server Agent';
    unix_cmd 'opcmona' -> 'traversys', 'HP OpenView Operations Monitoring Agent';
    unix_cmd 'opctrapi' -> 'traversys', 'HP OpenView Operations Trap Interceptor';
    unix_cmd 'ovbbccb' -> 'traversys', 'HP OpenView Communication Broker';
    unix_cmd 'ovconfd' -> 'traversys', 'HP OpenView Config and Deploy';
    unix_cmd 'ovcs' -> 'traversys', 'HP OpenView Certificate Server';
    unix_cmd 'ovdbrun' -> 'traversys', 'HP OpenView NNM Embedded DB';
    unix_cmd 'ovhelp' -> 'traversys', 'HP OpenView Windows Help Subsystem';
    unix_cmd 'ovtopmd' -> 'traversys', 'HP OpenView Topology Manager Daemon Service';
    unix_cmd 'ovw' -> 'traversys', 'HP OpenView Windows Graphical User Interface';
    unix_cmd 'perflbd' -> 'traversys', 'HP OpenView Measureware Performance Agent';
    unix_cmd 'ptydaemon' -> 'traversys', 'HP-UX Core OS Job Control';
    unix_cmd 'RemoteMonitor' -> 'traversys', 'HP Support Tools Manager Remote Monitor';
    unix_cmd 'sdm' -> 'traversys', 'HP Enterprise Management Command View SDM Plugin for Unicenter TNG';
    unix_cmd 'smhstartd' -> 'traversys', 'HP System Management Homepage';
    unix_cmd 'ssm' -> 'traversys', 'HP Output Server Startup Manager';
    unix_cmd 'swagentd' -> 'traversys', 'HP-UX SD Software Management Tasks Agent';
    unix_cmd 'sysstat_em' -> 'traversys', 'HP Support Tools Manager System Status Monitor';
    unix_cmd 'vx_attrsync_thread' -> 'traversys', 'HP-UX JFS daemon sync thread';
    unix_cmd 'vx_delxwri_thread' -> 'traversys', 'HP-UX JFS daemon delxwri thread';
    unix_cmd 'vx_iflush_thread' -> 'traversys', 'HP-UX JFS daemon iflush thread';
    unix_cmd 'vx_ifree_thread' -> 'traversys', 'HP-UX JFS daemon ifree thread';
    unix_cmd 'vx_inactive_cache_thread' -> 'traversys', 'HP-UX JFS daemon inactive cache thread';
    unix_cmd 'vx_inactive_thread' -> 'traversys', 'HP-UX JFS daemon inactive thread';
    unix_cmd 'vx_logflush_thread' -> 'traversys', 'HP-UX JFS daemon logflush thread';
    unix_cmd 'vx_sched_thread' -> 'traversys', 'HP-UX JFS daemon scheduler thread';
    unix_cmd 'vxfsd' -> 'traversys', 'HP-UX JFS';
    unix_cmd 'xnmbrowser' -> 'traversys', 'HP Mib Browser';
    unix_cmd 'xnmevents' -> 'traversys', 'HP Events Browser';
    windows_cmd 'aes_twd' -> 'traversys', 'HP Mercury Application Management Self-Alert Monitor Aggregated Evernt Engine';
    windows_cmd 'agdbserver' -> 'traversys', 'HP OpenView Performance Manager Alarmgen DB Server';
    windows_cmd 'Aggregation' -> 'traversys', 'HP Mercury Application Management Offline Aggregation Engine';
    windows_cmd 'alarmgen' -> 'traversys', 'HP OpenView Performance Manager Alarmgen';
    windows_cmd 'AlertEngineMdrvExt' -> 'traversys', 'HP Application Management Alert Engine';
    windows_cmd 'AsyncEventService' -> 'traversys', 'HP StorageWorks Command Console Client';
    windows_cmd 'BttnServ' -> 'traversys', 'HP Compaq Easy Access Button Server';
    windows_cmd 'CHKADMIN' -> 'traversys', 'HP Compaq Network Management System Tray Icon';
    windows_cmd 'cim' -> 'traversys', 'HP Compaq Insight Manager';
    windows_cmd 'cimserver' -> 'traversys', 'HP WBEM/CIM Server';
    windows_cmd 'cissesrv' -> 'traversys', 'HP Smart Array SAS/SATA Event Notification Service';
    windows_cmd 'conitsvc' -> 'traversys', 'HP Connect-it Installation';
    windows_cmd 'conslogd' -> 'traversys', 'HP Console Logger';
    windows_cmd 'CPMEXEC' -> 'traversys', 'HP Compaq Power Manager UPS monitor';
    windows_cmd 'cpqalert' -> 'traversys', 'HP Insight Local Alert Service';
    windows_cmd 'cpqdmi' -> 'traversys', 'HP Compaq DMI Service Extension';
    windows_cmd 'CPQEADM' -> 'traversys', 'HP Easy Access Software Demon';
    windows_cmd 'CPQEAKSYSTEMTRAY' -> 'traversys', 'HP CpqEAKSystemTray MFC Application';
    windows_cmd 'cpqriis' -> 'traversys', 'HP ProLiant Rack Infrastructure Service';
    windows_cmd 'CPQSVMGR' -> 'traversys', 'HP Compaq Smart Array Redundancy Software';
    windows_cmd 'cpqteam' -> 'traversys', 'HP Network Configuration Utility';
    windows_cmd 'crvw' -> 'traversys', 'HP Winrunner Record Engine';
    windows_cmd 'DoubleTake' -> 'traversys', 'HP OpenView Storage Mirroring DoubleTake';
    windows_cmd 'EmailReportsMdrv' -> 'traversys', 'HP Self Alert Monitors Scheduled Reports Engine';
    windows_cmd 'HostAgent' -> 'traversys', 'HP StorageWorks HostAgent';
    windows_cmd 'hpacubin' -> 'traversys', 'HP Array Configuration Utility';
    windows_cmd 'HPBOID' -> 'traversys', 'HP Status Server Module';
    windows_cmd 'HPBPRO' -> 'traversys', 'HP PortResolver Module';
    windows_cmd 'hpbs2e' -> 'traversys', 'HP Digital Sender Module';
    windows_cmd 'hpdiags' -> 'traversys', 'HP Systems Insight Diagnostics';
    windows_cmd 'hpesysvc' -> 'traversys', 'HP Fault Monitoring Event Sync Service';
    windows_cmd 'hpevtsvc' -> 'traversys', 'HP Event Log Service';
    windows_cmd 'hpjfpmd' -> 'traversys', 'HP Federation Package Manager Service';
    windows_cmd 'hplopts' -> 'traversys', 'HP Lights-Out Passthrough Service';
    windows_cmd 'hpmcalog' -> 'traversys', 'HP Systems Insight Manager MCA monitor';
    windows_cmd 'hpmgtsvc' -> 'traversys', 'HP Systems Insight Manager Service';
    windows_cmd 'hpmpsvc' -> 'traversys', 'HP Systems Insight Manager Processor Service';
    windows_cmd 'HPNRA' -> 'traversys', 'HP Network Registry Agent';
    windows_cmd 'hpsimsvc' -> 'traversys', 'HP Systems Insight Manager Service';
    windows_cmd 'hpsmh.*rotatelogs' -> 'traversys', 'HP System Management Homepage Logrotate';
    windows_cmd 'hpsmhd' -> 'traversys', 'HP System Management Homepage Monitor';
    windows_cmd 'HpssCVManagementServer' -> 'traversys', 'HP StorageWorks Command View Management Server';
    windows_cmd 'HpssSecurity' -> 'traversys', 'HP StorageWorks Security';
    windows_cmd 'hpvmmsvc' -> 'traversys', 'HP ESX Virtual Machine';
    windows_cmd 'hpwebjetd' -> 'traversys', 'HP Web Jetadmin Service';
    windows_cmd 'ipmi_service_main' -> 'traversys', 'HP IMPI';
    windows_cmd 'JWrapper_CVManagementServer' -> 'traversys', 'HP StorageWorks Command View Management Server';
    windows_cmd 'JWrapper_HpssSecurity' -> 'traversys', 'HP StorageWorks Security';
    windows_cmd 'llbserver' -> 'traversys', 'HP OpenView Operations BBC Local Location Broker (LLB)';
    windows_cmd 'magentproc' -> 'traversys', 'HP Load Generator Agent';
    windows_cmd 'magentservice' -> 'traversys', 'HP Load Generator Agent';
    windows_cmd 'mmdrv' -> 'traversys', 'HP Loadrunner Monitoring Agent';
    windows_cmd 'nanny' -> 'traversys', 'HP Application Manager';
    windows_cmd 'opcle' -> 'traversys', 'HP OpenView Operations Logfile Encapsulator';
    windows_cmd 'opcmona' -> 'traversys', 'HP OpenView Operations Monitoring Agent';
    windows_cmd 'opcmsgi' -> 'traversys', 'HP OpenView Operations Message Interceptor';
    windows_cmd 'perflbd' -> 'traversys', 'HP OpenView Measureware Performance Agent';
    windows_cmd 'radexecd' -> 'traversys', 'HP Radia OpenView';
    windows_cmd 'radsched' -> 'traversys', 'HP Radia OpenView';
    windows_cmd 'Radstgms' -> 'traversys', 'HP Radia OpenView';
    windows_cmd 'rgsender_gui' -> 'traversys', 'HP Remote Graphics Sender GUI';
    windows_cmd 'rgsender' -> 'traversys', 'HP Remote Graphics Sender';
    windows_cmd 'smhstart' -> 'traversys', 'HP System Management Homepage Service';
    windows_cmd 'TMU' -> 'traversys', 'HP Business Availability Center';
    windows_cmd 'topaz_pm' -> 'traversys', 'HP Self Alert Monitors Partition Manager';
    windows_cmd 'tp_loader' -> 'traversys', 'HP Self Alert Monitors Database Loading';
    windows_cmd 'tpaggregator_server' -> 'traversys', 'HP Self Alert Monitors Online Aggregation Engine ';
    windows_cmd 'UPService' -> 'traversys', 'HP Utilization Provider Service';
    windows_cmd 'WMINParProvider' -> 'traversys', 'HP WMI nPar Provider';
    windows_cmd 'wrun' -> 'traversys', 'HP Winrunner';
end identify;

identify Traversys20090122_HP 1.1
  tags HP;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'dm_sas_adapter' -> 'traversys', 'HP EMS Hardware Monitor on HP-UX SAS Mass Storage Adapter Monitor';
    windows_cmd 'DMIIND\~1' -> 'traversys', 'HP Insight Manager DMI Indications Service';
    windows_cmd 'hpsdnsvc' -> 'traversys', 'HP Systems Insight Manager Service';
    windows_cmd 'online' -> 'traversys', 'HP LoadRunner Online Analysis';
    windows_cmd 'pmp' -> 'traversys', 'HP Performance Management Pack';
    windows_cmd 'pmptools' -> 'traversys', 'HP Performance Management Pack Tools Service';
    windows_cmd 'smf' -> 'traversys', 'HP Storage Manager Foundation ';
    windows_cmd 'Tuner' -> 'traversys', 'HP Software Manager Tuner';
    windows_cmd 'WebDmi' -> 'traversys', 'HP Insight Manager Web Management Agent';
end identify;

identify HP 1.1
  tags HP;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'watchdog' -> 'traversys', 'HP Compaq SANworks HP (Compaq) SANworks StorageWork Watchdog';
    unix_cmd 'watchdog'    -> 'traversys', 'HP Compaq SANworks HP (Compaq) SANworks StorageWork Watchdog';
end identify;


identify Hummingbird 1.0
  tags Hummingbird;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'xsession' -> 'traversys', 'Hummingbird Exceed Xsession';
end identify;


identify IBM 2.0
  tags IBM;
  DiscoveredProcess cmd -> set_by, simple_identity;
    regex '\.db2set\.' -> 'traversys', 'IBM DB2 Profile Registry Command';
    regex 'Tivoli\\lcf.*\\admin' -> 'traversys', 'IBM Tivoli Management Framework Event Management';
    unix_cmd 'actionsvr' -> 'traversys', 'IBM Tivoli NetView Object Manager';
    unix_cmd 'activmon\.srv' -> 'traversys', 'IBM Sametime Active Monitor Server';
    unix_cmd 'ainbe' -> 'traversys', 'IBM Infoprint Print Services Facility Backend';
    unix_cmd 'ainhyper' -> 'traversys', 'IBM Infoprint Print Services Facility/AD Manager';
    unix_cmd 'albd_server' -> 'traversys', 'IBM Rational ClearCase Master_Server Atria Location Broker';
    unix_cmd 'amqsblst' -> 'traversys', 'IBM MQ Sample Program';
    unix_cmd 'amserver' -> 'traversys', 'IBM Cognos Access Manager Server';
    unix_cmd 'archpro' -> 'traversys', 'IBM DB2 CommonStore Subcomponent';
    unix_cmd 'arsacif' -> 'traversys', 'IBM DB2 Content Manager OnDemand';
    unix_cmd 'arsjesd' -> 'traversys', 'IBM DB2 Content Manager OnDemand';
    unix_cmd 'arsload' -> 'traversys', 'IBM DB2 Content Manager OnDemand';
    unix_cmd 'arsmaint' -> 'traversys', 'IBM DB2 Content Manager OnDemand';
    unix_cmd 'arssockd' -> 'traversys', 'IBM ARS DB2 Communicator';
    unix_cmd 'BIBusTKServerMain' -> 'traversys', 'IBM Cognos ReportNet Report Service';
    unix_cmd 'C5d' -> 'traversys', 'IBM Tivoli NetView Mid-Level Manager';
    unix_cmd 'calconn' -> 'traversys', 'IBM Lotus Notes Callendar Collector';
    unix_cmd 'cimlistener' -> 'traversys', 'IBM Systems Director Listener';
    unix_cmd 'clappmond' -> 'traversys', 'IBM Application Monitor';
    unix_cmd 'clcomd' -> 'traversys', 'IBM HACMP Cluster Security';
    unix_cmd 'cldbdir' -> 'traversys', 'IBM Cluster Database Manager';
    unix_cmd 'cleartool' -> 'traversys', 'IBM Rational ClearCase CLI tool';
    unix_cmd 'clearviewupdate' -> 'traversys', 'IBM Rational ClearCase Snapshot View Update Tool';
    unix_cmd 'cllockd' -> 'traversys', 'IBM Cluster Lock Manger';
    unix_cmd 'clresmgrd' -> 'traversys', 'IBM Cluster Systems Management';
    unix_cmd 'clsmuxpd' -> 'traversys', 'IBM HACMP for AIX Cluster SNMP Multiplexing Peer';
    unix_cmd 'clstrmgr' -> 'traversys', 'IBM AIX Cluster Manager';
    unix_cmd 'cogbootstrapservice' -> 'traversys', 'IBM Cognos Business Intelligence Boot Strap Service';
    unix_cmd 'collector' -> 'traversys', 'IBM Collecter Tool';
    unix_cmd 'css\.summlog' -> 'traversys', 'IBM PSSP CSS Logging';
    unix_cmd 'cssadm' -> 'traversys', 'IBM PSSP Switch Admin';
    unix_cmd 'daemonize' -> 'traversys', 'IBM Director Agent';
    unix_cmd 'db2admin' -> 'traversys', 'IBM DB2 Administration Server';
    unix_cmd 'db2agentgp' -> 'traversys', 'IBM DB2 Intra Parallel Agent';
    unix_cmd 'db2agnti' -> 'traversys', 'IBM DB2 Replay Master';
    unix_cmd 'db2aud' -> 'traversys', 'IBM DB2 Audit Facility';
    unix_cmd 'db2auditd' -> 'traversys', 'IBM DB2 Audit Facility';
    unix_cmd 'db2batch' -> 'traversys', 'IBM DB2 Benchmark Tool';
    unix_cmd 'db2ckbkp' -> 'traversys', 'IBM DB2 Check Backup Command';
    unix_cmd 'db2dart' -> 'traversys', 'IBM DB2 Database Analysis and Reporting Tool';
    unix_cmd 'db2event' -> 'traversys', 'IBM DB2 Event Monitor';
    unix_cmd 'db2evmgi' -> 'traversys', 'IBM DB2 SQLM BDS Start Monitor';
    unix_cmd 'db2fcmdm' -> 'traversys', 'IBM DB2 Fast Communications Manager';
    unix_cmd 'db2fcmr' -> 'traversys', 'IBM DB2 Fast Communications Manager Receiver';
    unix_cmd 'db2fcms' -> 'traversys', 'IBM DB2 Fast Communications Manager Sender';
    unix_cmd 'db2flsn' -> 'traversys', 'IBM DB2 Find Log Sequence Number';
    unix_cmd 'db2fm' -> 'traversys', 'IBM DB2 Fenced Mode Processes Executor';
    unix_cmd 'db2fmp32' -> 'traversys', 'IBM DB2 Fenced Mode Processes 32-bit Library';
    unix_cmd 'db2fmpr' -> 'traversys', 'IBM DB2 UDB Fenced Mode Stored Procedure';
    unix_cmd 'db2fmpr32' -> 'traversys', 'IBM DB2 UDB DB2 UDB Common Trace API 32-bit Library';
    unix_cmd 'db2hadrp' -> 'traversys', 'IBM DB2 HADR Primary Server';
    unix_cmd 'db2hadrs' -> 'traversys', 'IBM DB2 HADR Standby Server';
    unix_cmd 'db2hmon' -> 'traversys', 'IBM DB2 Health Center';
    unix_cmd 'db2jd' -> 'traversys', 'IBM DB2 JDBC Applet Server Service';
    unix_cmd 'db2lfr' -> 'traversys', 'IBM DB2 LOAD Formatter';
    unix_cmd 'db2licd' -> 'traversys', 'IBM DB2 License';
    unix_cmd 'db2logmgr' -> 'traversys', 'IBM DB2 Log Manager';
    unix_cmd 'db2pdbc' -> 'traversys', 'IBM DB2 Parallel Database Controller';
    unix_cmd 'db2redom' -> 'traversys', 'IBM DB2 Redo Master';
    unix_cmd 'db2redow' -> 'traversys', 'IBM DB2 Redo Worker';
    unix_cmd 'db2set' -> 'traversys', 'IBM DB2 Profile Registry Command';
    unix_cmd 'db2shred' -> 'traversys', 'IBM DB2 Log recorder';
    unix_cmd 'db2spmlw' -> 'traversys', 'IBM DB2 SPM Log Writer EDU';
    unix_cmd 'db2spmrm' -> 'traversys', 'IBM DB2 SPM Restart/Resync EDU';
    unix_cmd 'db2spmrsy' -> 'traversys', 'IBM DB2 Sync Point Manager';
    unix_cmd 'db2stmm' -> 'traversys', 'IBM DB2 Self Tuning Memory Manager';
    unix_cmd 'db2syscr' -> 'traversys', ' IBM DB2 Main Root System Controller Service';
    unix_cmd 'db2taskd' -> 'traversys', 'IBM DB2 Background DB Task Manager';
    unix_cmd 'db2uext2' -> 'traversys', 'IBM DB2 User Exit';
    unix_cmd 'diagd' -> 'traversys', 'IBM CAPP Diagnostics';
    unix_cmd 'dm_ep_engine\.ex' -> 'traversys', 'IBM Tivoli Distributed Monitoring Endpoint Engine';
    unix_cmd 'ds_init' -> 'traversys', 'IBM FileNet';
    unix_cmd 'ds_notify' -> 'traversys', 'IBM FileNet Document Services Notify';
    unix_cmd 'dsmadmc' -> 'traversys', 'IBM Tivoli Storage Manager Administrative Client';
    unix_cmd 'dsmc' -> 'traversys', 'IBM Tivoli Storage Manager Backup Archive CLI Client';
    unix_cmd 'DSMFAgent' -> 'traversys', 'IBM Tivoli Monitoring DSMF Agent';
    unix_cmd 'dsmmonitord' -> 'traversys', 'IBM Tivoli HSM Space Monitor';
    unix_cmd 'dsmrecalld' -> 'traversys', 'IBM Tivoli Storage Manager HSM Recall';
    unix_cmd 'dsmrootd' -> 'traversys', 'IBM Tivoli Storage Manager HSM Root';
    unix_cmd 'dsmscoutd' -> 'traversys', 'IBM Tivoli Storage Manager HSM Scout';
    unix_cmd 'dsmsta' -> 'traversys', 'IBM Tivoli Storage Manager Set Storage Server Agent';
    unix_cmd 'eif_ep_engine' -> 'traversys', 'IBM EIF Event Management Proces';
    unix_cmd 'emsrv' -> 'traversys', 'IBM VisualAge Smalltalk EMSRV';
    unix_cmd 'fault_service_Worm_RTG_SP' -> 'traversys', 'IBM PSSP Fault Service';
    unix_cmd 'fmcamain' -> 'traversys', 'IBM WebSphere MQ Administration Server';
    unix_cmd 'fmccmain' -> 'traversys', 'IBM WebSphere MQ Workflow Cleanup Server';
    unix_cmd 'fmcemain' -> 'traversys', 'IBM WebSphere MQ Workflow Execution Server';
    unix_cmd 'gsclvmd' -> 'traversys', 'IBM Group Services Concurrent Logical Volume Manager';
    unix_cmd 'hagsd' -> 'traversys', 'IBM Group Services';
    unix_cmd 'hardmon' -> 'traversys', 'IBM PSSP System Monitor';
    unix_cmd 'hc' -> 'traversys', 'IBM Recoverable Virtual Shared Disk';
    unix_cmd 'hrd' -> 'traversys', 'IBM PSSP Event Management';
    unix_cmd 'i4glbcd' -> 'traversys', 'IBM AIX iFOR/LS Global Location Broker Cleanup';
    unix_cmd 'IBM\.AuditRMd' -> 'traversys', 'IBM Audit Log Resource Manager';
    unix_cmd 'IBM\.ConfigRMd' -> 'traversys', 'IBM RSCT Configuration Resource Manager';
    unix_cmd 'IBM\.CSMAgentRMd' -> 'traversys', 'IBM Cluster Systems Management';
    unix_cmd 'IBM\.DMSRMd' -> 'traversys', 'IBM Resource Monitoring and Control HMC';
    unix_cmd 'IBM\.DRMd' -> 'traversys', 'IBM DRM Resource Manager';
    unix_cmd 'IBM\.ERrmd' -> 'traversys', 'IBM RSCT Event Response';
    unix_cmd 'IBM\.FSrmd' -> 'traversys', 'IBM RSCT Filesystem';
    unix_cmd 'IBM\.HostRMd' -> 'traversys', 'IBM RSCT Host';
    unix_cmd 'IBM\.HWCTRLRMd' -> 'traversys', 'IBM CSM Hardware Control Resource Manager';
    unix_cmd 'IBM\.LPRMd' -> 'traversys', 'IBM RSCT';
    unix_cmd 'IBM\.SensorRMd' -> 'traversys', 'IBM RMC Sensor Resource Manager';
    unix_cmd 'IBM\.ServiceRMd' -> 'traversys', 'IBM Hardware Management Notification';
    unix_cmd 'ibmasm' -> 'traversys', 'IBM Advanced System Management';
    unix_cmd 'ibmproxy' -> 'traversys', 'IBM Proxy Server';
    unix_cmd 'icmplsap' -> 'traversys', 'IBM DB2 CommonStore SAP';
    unix_cmd 'ipmap' -> 'traversys', 'IBM Tivoli NetView IPMap';
    unix_cmd 'iwagent' -> 'traversys', 'IBM Intelliwatch';
    unix_cmd 'iwcrdet' -> 'traversys', 'IBM Database Scan Trigger';
    unix_cmd 'kadmind' -> 'traversys', 'IBM PSSP Kerberos Database';
    unix_cmd 'kdy_xa' -> 'traversys', 'IBM TEMA for WebSphere Agent';
    unix_cmd 'kerberos' -> 'traversys', 'IBM PSSP Kerberos Authentication Service';
    unix_cmd 'kmcrca' -> 'traversys', 'IBM Tivoli Omegamon XE for WebSphere MQ Configuration agent';
    unix_cmd 'kpkagent' -> 'traversys', 'IBM Tivoli Monitoring System Edition';
    unix_cmd 'kqiagent' -> 'traversys', 'IBM Tivoli Omegamon WS Message Broker Monitoring Agent';
    unix_cmd 'kt2agent' -> 'traversys', 'IBM Tivoli Monitoring System Edition';
    unix_cmd 'kvaagent' -> 'traversys', 'IBM Tivoli Monitoring System Edition';
    unix_cmd 'la_event_d' -> 'traversys', 'IBM PSSP SP Switch2';
    unix_cmd 'lockmgr' -> 'traversys', 'IBM Rational ClearCase Lock Manager';
    unix_cmd 'logasio' -> 'traversys', 'IBM Lotus Notes Logger Task';
    unix_cmd 'mgragentd' -> 'traversys', 'IBM Tivoli NetView Client/Server Communications';
    unix_cmd 'mirrord' -> 'traversys', 'IBM AIX AIX Mirror Module';
    unix_cmd 'mmfsd64' -> 'traversys', 'IBM 64-bit Multimedia File System';
    unix_cmd 'mmsdrserv' -> 'traversys', 'IBM GPFS Listening Port Service';
    unix_cmd 'netcool' -> 'traversys', 'IBM Netcool';
    unix_cmd 'netmon' -> 'traversys', 'IBM Tivoli NetView Network Monitor';
    unix_cmd 'netviewd' -> 'traversys', 'IBM Tivoli NetView Console';
    unix_cmd 'nntask' -> 'traversys', 'IBM Lotus Notes NAV (Norton Anti-Virus) component';
    unix_cmd 'nvcold' -> 'traversys', 'IBM Tivoli NetView Collections';
    unix_cmd 'nvcorrd' -> 'traversys', 'IBM Tivoli NetView Correlation';
    unix_cmd 'nvpagerd' -> 'traversys', 'IBM Tivoli NetView Pager';
    unix_cmd 'nvsecd' -> 'traversys', 'IBM Tivoli NetView';
    unix_cmd 'OracleSQLEngine8' -> 'traversys', 'IBM Tivoli Management Agent for Oracle';
    unix_cmd 'ovelmd' -> 'traversys', 'IBM Tivoli NetView Event Log';
    unix_cmd 'ovesmd' -> 'traversys', 'IBM Tivoli NetView Event Sieve';
    unix_cmd 'ovwdb' -> 'traversys', 'IBM Tivoli NetView Caching';
    unix_cmd 'pcl2afpd' -> 'traversys', 'IBM Infoprint PCL to AFP Transform';
    unix_cmd 'pmand' -> 'traversys', 'IBM PSSP Problem Management';
    unix_cmd 'portmapsv' -> 'traversys', 'IBM Ports Map Service';
    unix_cmd 'postemsg' -> 'traversys', 'IBM Command for Non-Tivoli Messages';
    unix_cmd 'postzmsg' -> 'traversys', 'IBM Process for Post Non-Tivoli Events';
    unix_cmd 'ps2afpd' -> 'traversys', 'IBM Infoprint PostScript and PDF Transform';
    unix_cmd 'ps2afpi' -> 'traversys', 'IBM Infoprint PostScript/PDF-to-AFP Interpreter';
    unix_cmd 'psfapid' -> 'traversys', 'IBM Infoprint Print Services Facility API';
    unix_cmd 'psql' -> 'traversys', 'IBM Netcool PostgreSQL Interactive Terminal';
    unix_cmd 'rcproxy' -> 'traversys', 'IBM Tivoli Remote Control Proxy';
    unix_cmd 'RIM_DB2_Agent' -> 'traversys', 'IBM DB2 Referential Information Manager Agent';
    unix_cmd 'RIM_DB2_prog' -> 'traversys', 'IBM DB2 Referential Information Manager';
    unix_cmd 'RIM_Oracle_Agent' -> 'traversys', 'IBM Tivoli RDBMS Oracle Interface Module Agent';
    unix_cmd 'RIM_Oracle_prog' -> 'traversys', 'IBM Tivoli RDBMS Oracle Interface Module';
    unix_cmd 'rmagent' -> 'traversys', 'IBM SNMP Mib Agent';
    unix_cmd 'rmcd' -> 'traversys', 'IBM RMC';
    unix_cmd 'runmqbrk' -> 'traversys', 'IBM WebSphere MQ Broker Control Job';
    unix_cmd 'runmqdlq' -> 'traversys', 'IBM WebSphere MQ Dead Letter Queue';
    unix_cmd 'runmqlsr_nd' -> 'traversys', 'IBM WebSphere MQ Listener';
    unix_cmd 'runmqtmc' -> 'traversys', 'IBM Client Trigger Monitor';
    unix_cmd 'runmqtrm_duo' -> 'traversys', 'IBM WebSphere MQ Trigger Monitor';
    unix_cmd 'runmqtrm_pcclass' -> 'traversys', 'IBM WebSphere MQ Trigger Monitor';
    unix_cmd 'runmqtrm_relta' -> 'traversys', 'IBM WebSphere MQ Trigger Monitor';
    unix_cmd 'runmqtrm_reltap' -> 'traversys', 'IBM WebSphere MQ Trigger Monitor';
    unix_cmd 'rwp' -> 'traversys', 'IBM Rational ClearCase Web Platform';
    unix_cmd 's70d' -> 'traversys', 'IBM PSSP S70';
    unix_cmd 'sdrd' -> 'traversys', 'IBM PSSP System Data Repository';
    unix_cmd 'SDRGetObjects' -> 'traversys', 'IBM Parallel System Support Program';
    unix_cmd 'ServeRAID' -> 'traversys', 'IBM ServeRAID Software Matrix';
    unix_cmd 'shlap' -> 'traversys', 'IBM AIX 64-bit Init';
    unix_cmd 'shlap64' -> 'traversys', 'IBM Shared Library Support';
    unix_cmd 'snacfgdae' -> 'traversys', 'IBM SNA';
    unix_cmd 'snadaemon' -> 'traversys', 'IBM SNA 32-bit';
    unix_cmd 'sp_configd' -> 'traversys', 'IBM PSSP SNMP Proxy';
    unix_cmd 'splogd' -> 'traversys', 'IBM PSSP SP Logging';
    unix_cmd 'statlog' -> 'traversys', 'IBM Lotus Notes DB Monitoring Utility';
    unix_cmd 'sysctld' -> 'traversys', 'IBM PSSP Server';
    unix_cmd 'task_endpoint' -> 'traversys', 'IBM Tivoli Management Agent Task Endpoint';
    unix_cmd 'tmdb2ms8' -> 'traversys', 'IBM Tivoli Monitoring DB2 Monitor';
    unix_cmd 'tmnt_hb_eng' -> 'traversys', 'IBM Tivoli Monitoring Heartbeat Engine Trace';
    unix_cmd 'tmnt_rm_eng' -> 'traversys', 'IBM Tivoli Request Manager Trace';
    unix_cmd 'tmnt_task_eng' -> 'traversys', 'IBM Tivoli Monitoring Task Engine Tracelog';
    unix_cmd 'tmw2k_ep' -> 'traversys', 'IBM Tivoli Monitoring Endpoint Engine Tracelog';
    unix_cmd 'trapgend' -> 'traversys', 'IBM Tivoli NetView Trapgend';
    unix_cmd 'tsmigrated' -> 'traversys', 'IBM GPFS';
    unix_cmd 'updall' -> 'traversys', 'IBM Lotus Domino Administrator Index Rebuilder';
    unix_cmd 'usr/lpp/X11/bin/X' -> 'traversys', 'IBM AIX AIX Specific Graphical Display Server';
    unix_cmd 'uvsh' -> 'traversys', 'IBM UniVerse Shell';
    unix_cmd 'x_st_mgrd' -> 'traversys', 'IBM AIX X-Station Manager';
    windows_cmd 'albd_server' -> 'traversys', 'IBM Rational ClearCase Master_Server Atria Location Broker';
    windows_cmd 'amqmsrvn' -> 'traversys', 'IBM WebSphere MQ DCOM Server';
    windows_cmd 'amqmtbrn' -> 'traversys', 'IBM WebSphere MQ Taskbar';
    windows_cmd 'amqsvc' -> 'traversys', 'IBM MQ Service';
    windows_cmd 'amserver' -> 'traversys', 'IBM Cognos Access Manager Server';
    windows_cmd 'apdc_kill' -> 'traversys', 'IBM Tivoli LCF Agent';
    windows_cmd 'batchup' -> 'traversys', 'IBM Tivoli Workload Scheduler Service';
    windows_cmd 'bfdispatch' -> 'traversys', 'IBM Rational Build Forge Agent Trace Mode';
    windows_cmd 'BIBusTKServerMain' -> 'traversys', 'IBM Cognos ReportNet Report Service';
    windows_cmd 'ccdoctor' -> 'traversys', 'IBM Rational ClearCase Sourcecode Management Tool';
    windows_cmd 'CCS_Server1' -> 'traversys', 'IBM WebSphere MQ Credit Check System';
    windows_cmd 'ccweb' -> 'traversys', 'IBM Rational Clearcase Web Interface';
    windows_cmd 'cimmgr' -> 'traversys', 'IBM Director CIM Manager';
    windows_cmd 'clearfindco' -> 'traversys', 'IBM Rational Clearcase Find Checkouts Tool';
    windows_cmd 'clearhistory' -> 'traversys', 'IBM Rational Clearcase History Browser';
    windows_cmd 'clearhomebase' -> 'traversys', 'IBM Rational Clearcase Home Base';
    windows_cmd 'clearlstype' -> 'traversys', 'IBM Rational Clearcase  Type Explorer';
    windows_cmd 'clearprojexp' -> 'traversys', 'IBM Rational Clearcase Project Explorer';
    windows_cmd 'cleartool' -> 'traversys', 'IBM Rational Clearcase CLI tool';
    windows_cmd 'clearviewtool' -> 'traversys', 'IBM Rational Clearcase View Creation Tool';
    windows_cmd 'clearvtree' -> 'traversys', 'IBM Rational ClearCase Version Tree Browser';
    windows_cmd 'CMService' -> 'traversys', 'IBM Redbrick Warehouse Copy Management Service';
    windows_cmd 'cogbootstrapservice' -> 'traversys', 'IBM Cognos Business Intelligence Boot Strap Service';
    windows_cmd 'Connect' -> 'traversys', 'IBM Lotus Notes Sametime Client';
    windows_cmd 'CQINTS\~2' -> 'traversys', 'IBM Rational ClearQuest UCM Project';
    windows_cmd 'cqintsvr11' -> 'traversys', 'IBM ClearQuest UCM Project';
    windows_cmd 'ctelock' -> 'traversys', 'IBM DB2 Net Search Extender';
    windows_cmd 'db2' -> 'traversys', 'IBM DB2 UDB';
    windows_cmd 'db2govds' -> 'traversys', 'IBM DB2 Governor';
    windows_cmd 'db2serv' -> 'traversys', 'IBM DB2 Server';
    windows_cmd 'dm_ep_engine\.ex' -> 'traversys', 'IBM Tivoli Distributed Monitoring Endpoint Engine';
    windows_cmd 'ds_notify' -> 'traversys', 'IBM FileNet Document Services Notify';
    windows_cmd 'dsmadmc' -> 'traversys', 'IBM Tivoli Storage Manager Administrative Client';
    windows_cmd 'dsmcsvc' -> 'traversys', 'IBM Tivoli Storage Manager Scheduler Service Client';
    windows_cmd 'EclipseSvc' -> 'traversys', 'IBM Tivoli Storage Manager Integrated Solutions Console';
    windows_cmd 'EQNRCMAI' -> 'traversys', 'IBM Tivoli Remote Control Target';
    windows_cmd 'FAAOTPTK' -> 'traversys', 'IBM CICS Transaction Comm Server';
    windows_cmd 'fmcemain' -> 'traversys', 'IBM WebSphere MQ Workflow Execution Server';
    windows_cmd 'HTTPDL' -> 'traversys', 'IBM IMNNQ NetQ Web Server';
    windows_cmd 'I4LLMD' -> 'traversys', 'IBM Nodelock License Server';
    windows_cmd 'ibmasrex' -> 'traversys', 'IBM Automatic Server Restart Executable';
    windows_cmd 'ibmasrsv' -> 'traversys', 'IBM Automatic Server Restart';
    windows_cmd 'IBMHPASV' -> 'traversys', 'IBM Active PCI Alert Service';
    windows_cmd 'IBMIASRW' -> 'traversys', 'IBM Automatic Server Restart Service for IPMI';
    windows_cmd 'ibmsmbus' -> 'traversys', 'IBM SMBus Package';
    windows_cmd 'ibmsprem' -> 'traversys', 'IBM Remote Supervisor Adapter';
    windows_cmd 'ibmspsvc' -> 'traversys', 'IBM Advanced System Management Remote Mouse';
    windows_cmd 'INFO_Server' -> 'traversys', 'IBM InfoSphere Information Server';
    windows_cmd 'itm_apdc' -> 'traversys', 'IBM Tivoli Monitoring';
    windows_cmd 'iwcrdet' -> 'traversys', 'IBM DB2 UDB Database Scan Trigger';
    windows_cmd 'iwmcg' -> 'traversys', 'IBM IntelliWatch MCG';
    windows_cmd 'JavaLauncher' -> 'traversys', 'IBM Sametime Links App Launcher';
    windows_cmd 'jconsole' -> 'traversys', 'IBM Domino Server';
    windows_cmd 'jmxservice' -> 'traversys', 'IBM Tivoli Monitoring TP 5.3 Management Agent';
    windows_cmd 'kkfhelpsvr' -> 'traversys', 'IBM Tivoli Monitoring Eclipse Help Server';
    windows_cmd 'kmqagent_.*' -> 'traversys', 'IBM Tivoli Monitoring KMQ Agent';
    windows_cmd 'KO9COLL' -> 'traversys', 'IBM Tivoli Monitoring for Databases';
    windows_cmd 'KOQCOLL' -> 'traversys', 'IBM Tivoli Monitoring for Databases';
    windows_cmd 'kudcma_DB2' -> 'traversys', 'IBM DB2 Monitoring Agent';
    windows_cmd 'kuma620' -> 'traversys', 'IBM Tivoli Monitoring Universal Agent Primary';
    windows_cmd 'kynagent' -> 'traversys', 'IBM Tivoli Monitoring Websphere Application Server Agent';
    windows_cmd 'lcfep' -> 'traversys', 'IBM Tivoli Endpoint Statistics';
    windows_cmd 'lockmgr' -> 'traversys', 'IBM Rational ClearCase Lock Manager';
    windows_cmd 'miniwinagent' -> 'traversys', 'IBM Flashcopy Agent';
    windows_cmd 'nBES' -> 'traversys', 'IBM BES for Lotus Notes';
    windows_cmd 'nCatalog' -> 'traversys', 'IBM Lotus Notes Catalog Task';
    windows_cmd 'nCollect' -> 'traversys', 'IBM Lotus Notes Administrator Module';
    windows_cmd 'ncompact' -> 'traversys', 'IBM Lotus Notes DB Compact tool';
    windows_cmd 'nDECS' -> 'traversys', 'IBM Lotus Domino Enterprise Connection Service';
    windows_cmd 'nDIIOP' -> 'traversys', 'IBM Lotus Domino Internet Inter-ORB Protocol Service';
    windows_cmd 'nFIXUP' -> 'traversys', 'IBM Lotus NT Server Utility';
    windows_cmd 'nIWAGENT' -> 'traversys', 'IBM Intelliwatch Domino Server Agent';
    windows_cmd 'nIWINFO' -> 'traversys', 'IBM Intelliwatch Domino Server Extension Manager Add-In';
    windows_cmd 'nLEI' -> 'traversys', 'IBM Lotus Enterprise Integration';
    windows_cmd 'nleicsm' -> 'traversys', 'IBM Lotus Enterprise Integration';
    windows_cmd 'nNOTESMM' -> 'traversys', 'IBM Lotus Notes Shared Memory Manager';
    windows_cmd 'nntask' -> 'traversys', 'IBM Lotus Notes Server Task';
    windows_cmd 'NotesStats' -> 'traversys', 'IBM Lotus Notes Mail Box Statistics Probe';
    windows_cmd 'NOTRIX' -> 'traversys', 'IBM Lotus Domino Axceler (plugin - not IBM)';
    windows_cmd 'nprocmon' -> 'traversys', 'IBM Nserver Process Monitor';
    windows_cmd 'nRnRMgr' -> 'traversys', 'IBM Lotus Domino Rooms and Resources Manager';
    windows_cmd 'nsqle32' -> 'traversys', 'IBM Lotus NotesSQL';
    windows_cmd 'nSTAddin' -> 'traversys', 'IBM Sametime Service starter';
    windows_cmd 'nStatlog' -> 'traversys', 'IBM Database Usage Statistics';
    windows_cmd 'nstmeetingserver' -> 'traversys', 'IBM Lotus Notes Meeting Services';
    windows_cmd 'ntbtrv' -> 'traversys', 'IBM CICS Transaction';
    windows_cmd 'NTDBSMGR' -> 'traversys', 'IBM CICS Transaction';
    windows_cmd 'ntivoliv60' -> 'traversys', 'IBM Lotus Domino Server module';
    windows_cmd 'ntprocinfo' -> 'traversys', 'IBM Tivoli Task List Utility';
    windows_cmd 'nUpdAll' -> 'traversys', 'IBM Lotus DB Repair Utility';
    windows_cmd 'PCS_AGNT' -> 'traversys', 'IBM Always Resident Pcomm';
    windows_cmd 'PCSCM' -> 'traversys', 'IBM iSeries Access for Windows';
    windows_cmd 'pcsnops' -> 'traversys', 'IBM SNA Node Operations';
    windows_cmd 'pcsws' -> 'traversys', 'IBM AS/400 Client Access';
    windows_cmd 'portmapsv' -> 'traversys', 'IBM Ports Map Service';
    windows_cmd 'qlremote' -> 'traversys', 'IBM FastT MS Java Utility';
    windows_cmd 'RaidServ' -> 'traversys', 'IBM ServeRAID Manager Agent';
    windows_cmd 'RAServer' -> 'traversys', 'IBM Agent Controller';
    windows_cmd 'REXX' -> 'traversys', 'IBM PC DOS REXX Interpreter';
    windows_cmd 'RqProxy' -> 'traversys', 'IBM Rational RequisitePro';
    windows_cmd 'rtvuc' -> 'traversys', 'IBM Rational Robot Generic Windows Virtual User';
    windows_cmd 'runmqsrv' -> 'traversys', 'IBM MQSeries Administration Wrapper Service';
    windows_cmd 'rwp' -> 'traversys', 'IBM Rational Web Platform';
    windows_cmd 'RXAPI' -> 'traversys', 'IBM Object REXX API Manager';
    windows_cmd 'SMmonitor' -> 'traversys', 'IBM Storage Manager 10 Event Monitor';
    windows_cmd 'StAdminSrv' -> 'traversys', 'IBM Sametime Admin';
    windows_cmd 'STAuthenticationServer' -> 'traversys', 'IBM Lotus Domino Authentication Server';
    windows_cmd 'stav' -> 'traversys', 'IBM Sametime Audio Video Service';
    windows_cmd 'stbroadcastgateway' -> 'traversys', 'IBM Sametime Broadcast Gateway';
    windows_cmd 'StBuddyList' -> 'traversys', 'IBM Sametime Community Buddy List Services';
    windows_cmd 'stcapabilities' -> 'traversys', 'IBM Lotus Domino ST Capabilities';
    windows_cmd 'STChatLogging' -> 'traversys', 'IBM Sametime Community Chat Logging Services';
    windows_cmd 'StCommLaunch' -> 'traversys', 'IBM Sametime Community Services Launcher';
    windows_cmd 'StCommunity' -> 'traversys', 'IBM Sametime Community Services';
    windows_cmd 'StConference' -> 'traversys', 'IBM Sametime Community Conference Services';
    windows_cmd 'StConfiguration' -> 'traversys', 'IBM Sametime Community Services Configuration';
    windows_cmd 'stconfigurationbridge' -> 'traversys', 'IBM Lotus Domino Configuration Bridge';
    windows_cmd 'StDirectory' -> 'traversys', 'IBM Sametime Community Directory Services';
    windows_cmd 'steventserver' -> 'traversys', 'IBM Lotus Domino Event Server';
    windows_cmd 'STFileTransfer' -> 'traversys', 'IBM Sametime File Transfer';
    windows_cmd 'StGateway' -> 'traversys', 'IBM Sametime SIP/SIMPLE Gateway';
    windows_cmd 'stgwcontroller' -> 'traversys', 'IBM Sametime Gateway Controller';
    windows_cmd 'STGWService' -> 'traversys', 'IBM Sametime Broadcast Gateway Services';
    windows_cmd 'STLaunch' -> 'traversys', 'IBM Sametime Server';
    windows_cmd 'stlinks' -> 'traversys', 'IBM Sametime Links App Launcher';
    windows_cmd 'StLogger' -> 'traversys', 'IBM Sametime Community Logging Services';
    windows_cmd 'stmaterialmanager' -> 'traversys', 'IBM Sametime Materials Manager';
    windows_cmd 'stmeetinglogger' -> 'traversys', 'IBM Sametime Logger';
    windows_cmd 'stmmp' -> 'traversys', 'IBM Multimedia Processor Services';
    windows_cmd 'STMSActivityProvider' -> 'traversys', 'IBM Sametime Activity Provider';
    windows_cmd 'stmsservice' -> 'traversys', 'IBM Sametime Meeting Server';
    windows_cmd 'StMux' -> 'traversys', 'IBM Sametime Community Services Multiplexer';
    windows_cmd 'StOnlineDir' -> 'traversys', 'IBM Sametime Community Online Directory Services';
    windows_cmd 'StPlaces' -> 'traversys', 'IBM Sametime Places Services';
    windows_cmd 'stpolicy' -> 'traversys', 'IBM Sametime Policy Service';
    windows_cmd 'STPolling' -> 'traversys', 'IBM Sametime Community Polling Services';
    windows_cmd 'STPrivacy' -> 'traversys', 'IBM Sametime User Privacy Information';
    windows_cmd 'streflector' -> 'traversys', 'IBM Sametime Audio Reflector';
    windows_cmd 'StResolve' -> 'traversys', 'IBM Sametime User Name Resolution';
    windows_cmd 'STSecurity' -> 'traversys', 'IBM Sametime Security Services';
    windows_cmd 'stservicemanager' -> 'traversys', 'IBM Sametime Java Service Manager';
    windows_cmd 'STT120MCU' -> 'traversys', 'IBM Sametime T.120 MCU';
    windows_cmd 'StUsers' -> 'traversys', 'IBM Sametime Community Users Services';
    windows_cmd 'StUserStorage' -> 'traversys', 'IBM Sametime User Connect List and Prefs';
    windows_cmd 'STWBServer' -> 'traversys', 'IBM Sametime Whiteboard Service';
    windows_cmd 'syncmgr_server' -> 'traversys', 'IBM Synchronization Manager';
    windows_cmd 'tapmagent' -> 'traversys', 'IBM Tivoli ARM agent';
    windows_cmd 'ticscanagent' -> 'traversys', 'IBM Director TicUnix Subagent';
    windows_cmd 'TivoliMonitor' -> 'traversys', 'IBM Tivoli Monitoring TivoliMonitor Node';
    windows_cmd 'tksSvc' -> 'traversys', 'IBM Tivoli Kernel Services MQRestarter';
    windows_cmd 'tmnt_hb_eng' -> 'traversys', 'IBM Tivoli Monitoring Heartbeat Engine Trace';
    windows_cmd 'tmnt_task_eng' -> 'traversys', 'IBM Tivoli Monitoring Task Engine Tracelog';
    windows_cmd 'tmw2k_ep' -> 'traversys', 'IBM Tivoli Monitoring Endpoint Engine Tracelog';
    windows_cmd 'Tmw2k' -> 'traversys', 'IBM Tivoli Monitoring Endpoint';
    windows_cmd 'tokensrv' -> 'traversys', 'IBM Workload Scheduler Tivoli Token Service';
    windows_cmd 'tpam' -> 'traversys', 'IBM Sync Point Attach Manager';
    windows_cmd 'twgrcagt' -> 'traversys', 'IBM Director Remote Control Service';
    windows_cmd 'twgswinv' -> 'traversys', 'IBM Director Software Inventory Collector';
    windows_cmd 'twgtopo' -> 'traversys', 'IBM Director Topology Subscriber Client';
    windows_cmd 'wmiapsrv' -> 'traversys', 'IBM Systems Director WMI Performance Adaptor';
    windows_cmd 'wmicimsv' -> 'traversys', 'IBM Director WMI CIM Server';
    windows_cmd 'xxxDataAccess' -> 'traversys', 'IBM Impromptu Web Reports PowerPrompts Data Access Server';
end identify;

identify Traversys20090122a_IBM 1.0
  tags IBM;
  DiscoveredProcess cmd, args -> set_by, simple_identity;
    unix_cmd '\d+', regex '(?i)^view_server\s/usr/ClearCaseStorage' -> 'traversys', 'traversys', 'IBM Rational ClearCase View Activity Manager';
end identify;

identify Traversys20090122b_IBM 1.0
  tags IBM;
  DiscoveredProcess cmd -> set_by, simple_identity;
    regex 'opt/Tivoli.*\badmin' -> 'traversys', 'IBM Tivoli Management Framework Event Management';
    regex 'opt/TMWD\b.*\badmin' -> 'traversys', 'IBM Tivoli Management Framework Event Management';
    unix_cmd 'dirsnmpd' -> 'traversys', 'IBM Director SNMP DPI2 Agent';
    unix_cmd 'khtagent' -> 'traversys', 'IBM ITCAM WebServer Agent';
    unix_cmd 'koyagent' -> 'traversys', 'IBM Tivoli Monitoring Sybase Server Monitoring Agent';
    unix_cmd 'kuma620' -> 'traversys', 'IBM Tivoli Monitoring Universal Agent';
    unix_cmd 'kynagent' -> 'traversys', 'IBM Tivoli Monitoring WAS Agent';
    unix_cmd 'sidd' -> 'traversys', 'IBM HTTP Server Session ID Cache';
    windows_cmd 'ASBAgent' -> 'traversys', 'IBM Information Server ASB Agent';
    windows_cmd 'batchman' -> 'traversys', 'IBM Tivoli Workload Scheduler (Maestro) Batchman';
    windows_cmd 'jobmon' -> 'traversys', 'IBM Tivoli Workload Scheduler (Maestro) Jobman';
    windows_cmd 'kflm' -> 'traversys', 'IBM ITCAM Web Response Time Agent Collector';
    windows_cmd 'mailman' -> 'traversys', 'IBM Tivoli Workload Scheduler (Maestro) Mailman';
    windows_cmd 'netman' -> 'traversys', 'IBM Tivoli Workload Scheduler (Maestro) Netman';
    windows_cmd 'RAService' -> 'traversys', 'IBM Agent Controller';
end identify;

identify IBM 1.1
  tags IBM;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'wmicimserver\.ex' -> 'traversys', 'IBM Systems Director Agent WMI CIM Server';
    windows_cmd 'writer'        -> 'traversys', 'IBM Tivoli Workload Scheduler (Maestro) Writer';
end identify;

identify Interactive_Intelligence 1.0
  tags Interactive_Intelligence;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'AccServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Accumulator Server';
    windows_cmd 'AcdServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Automatic Call Distributor';
    windows_cmd 'AdminServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Admin Server';
    windows_cmd 'AlertServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Alert Service';
    windows_cmd 'ClientServicesU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Client Services';
    windows_cmd 'CompressorManagerU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Compressor Manager';
    windows_cmd 'DataManagerU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Data Manager';
    windows_cmd 'DSServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Server DS Server';
    windows_cmd 'FaxServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Fax Server';
    windows_cmd 'HostServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Host Server';
    windows_cmd 'IPDBServer2U' -> 'traversys', 'Interactive Intelligence Interaction Center Server IP PBX Server';
    windows_cmd 'IPDBServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Server IP PBX Server';
    windows_cmd 'IpServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Server IP PBX Server';
    windows_cmd 'IPU' -> 'traversys', 'Interactive Intelligence Interaction Center Server IP PBX Server';
    windows_cmd 'IRServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Routing Server';
    windows_cmd 'IRTranServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Routing Server';
    windows_cmd 'MailAcctMonU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Mail Monitor Service';
    windows_cmd 'NotifierU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Notification Service';
    windows_cmd 'PostOfficeServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Message Access Service';
    windows_cmd 'RecoSubsystemU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Recorder SubSystem';
    windows_cmd 'RSTrapMonitorU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Trap Monitor';
    windows_cmd 'SMSServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Server SMS Service';
    windows_cmd 'StatServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Status Service';
    windows_cmd 'TrackerSvrU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Tracker Service';
    windows_cmd 'TrackerTranU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Tracker Tran Service';
    windows_cmd 'TsServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Server TsServer';
    windows_cmd 'WebProcessorU' -> 'traversys', 'Interactive Intelligence Interaction Center Server Web Service';
end identify;

identify Invensys 1.0
  tags Invensys;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'aahDrvSvc' -> 'traversys', 'Invensys WonderWare Industrial SQL System Driver Service';
    windows_cmd 'aahEventSvc' -> 'traversys', 'Invensys WonderWare Industrial SQL Event Systen Service';
    windows_cmd 'aahIDASSvc' -> 'traversys', 'Invensys WonderWare Industrial SQL Data Acquistion Service';
    windows_cmd 'aahIndexSvc' -> 'traversys', 'Invensys WonderWare Industrial SQL Indexing Service';
    windows_cmd 'aahIOSvrSvc' -> 'traversys', 'Invensys WonderWare Industrial SQL Data Retrieval Service';
    windows_cmd 'aaHistClientReportingService' -> 'traversys', 'Invensys Wonderware Active Factory Reporting Service';
    windows_cmd 'aahManStSvc' -> 'traversys', 'Invensys WonderWare Industrial SQL Data Storage Service';
    windows_cmd 'aahRetSvc' -> 'traversys', 'Invensys WonderWare Industrial SQL Data Retrieval Service';
    windows_cmd 'aahSCM' -> 'traversys', 'Invensys WonderWare Industrial SQL Status Info Service';
    windows_cmd 'aahStoreSvc' -> 'traversys', 'Invensys WonderWare Industrial SQL Data Storage Service';
    windows_cmd 'aaLogger' -> 'traversys', 'Invensys ArchestrA Logging Service';
    windows_cmd 'aaTrend' -> 'traversys', 'Invensys Wonderware Active Factory Trend Files';
    windows_cmd 'alarmmgr' -> 'traversys', 'Invensys InTouch Wonderware InTouch Alarm Manager';
    windows_cmd 'hCfgSvc' -> 'traversys', 'Invensys WonderWare Industrial SQL Configuration Request Service';
end identify;

identify Iona 1.0
  tags Iona;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd '(?i)iona.*\bitifr' -> 'traversys', 'Iona Orbix Interface Repository';
    unix_cmd '(?i)iona.*\bitlocator' -> 'traversys', 'Iona Orbix Locator';
    unix_cmd '(?i)iona.*\bitmanagement' -> 'traversys', 'Iona Orbix Services Management';
    unix_cmd '(?i)iona.*\bitnaming' -> 'traversys', 'Iona Orbix Naming Service Database';
    unix_cmd '(?i)iona.*\bitnode_daemon' -> 'traversys', 'Iona Orbix Node';
    unix_cmd '(?i)iona.*\btconfig_rep' -> 'traversys', 'Iona Orbix Configuration Repository';
end identify;

identify Ipswitch 1.0
  tags Ipswitch;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'iFtpSvc' -> 'traversys', 'Ipswitch File Transfer WS_FTP Server';
    windows_cmd 'WhatsUpG' -> 'traversys', 'Ipswitch WhatsUp Gold WhatsUp Gold';
end identify;

identify KDE 1.0
  tags KDE;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'kblankscrn\.kss' -> 'traversys', 'KDE ScreenSaver';
end identify;

identify Kalab 1.0
  tags Kalab;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'cron' -> 'traversys', 'Kalab Cron Tool for Windows';
end identify;

identify Kiwi 1.0
  tags Kiwi;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'CatTools_Client' -> 'traversys', 'Kiwi CatTools Client';
    windows_cmd 'CatTools_Manager' -> 'traversys', 'Kiwi CatTools Service Manager';
    windows_cmd 'CatTools_Service' -> 'traversys', 'Kiwi CatTools Service';
end identify;

identify Kofax 1.0
  tags Kofax;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'ACIRsa' -> 'traversys', 'Kofax Ascent Capture Internet Server Remote Sync Agent';
    windows_cmd 'ACLicUtl' -> 'traversys', 'Kofax Ascent Capture Internet Server License Utility';
    windows_cmd 'ACSAI' -> 'traversys', 'Kofax Ascent Capture Import Connector';
    windows_cmd 'ACSvc' -> 'traversys', 'Kofax Ascent Capture Service';
    windows_cmd 'ACXMLAI' -> 'traversys', 'Kofax Ascent Capture XML Import Utility';
    windows_cmd 'Fp' -> 'traversys', 'Kofax Ascent Capture Recognition Server';
    windows_cmd 'Index' -> 'traversys', 'Kofax Ascent Capture Validation';
    windows_cmd 'kfxPdf' -> 'traversys', 'Kofax Ascent Capture PDF Generator';
    windows_cmd 'ocr32ex' -> 'traversys', 'Kofax Ascent Capture OCR Full Text';
    windows_cmd 'Ocr' -> 'traversys', 'Kofax Ascent Capture OCR Full Text';
    windows_cmd 'Ops' -> 'traversys', 'Kofax Ascent Capture Batch Manager';
    windows_cmd 'Release' -> 'traversys', 'Kofax Ascent Capture Release Module';
    windows_cmd 'scan' -> 'traversys', 'Kofax Ascent Capture Scan Service';
end identify;

identify Linux 1.1
  tags Linux;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'cfexecd' -> 'traversys', 'Linux Network Configuration Engine';
    unix_cmd 'dtksh' -> 'traversys', 'Linux Korn Shell X11 Enabled Korn Shell';
    unix_cmd 'kate' -> 'traversys', 'Linux Kate Text Editor';
    unix_cmd 'lsof' -> 'traversys', 'Linux OS Tool Unix lsof';
    unix_cmd 'vimx' -> 'traversys', 'Linux X11 X Windows System subprocess';
    unix_cmd 'xconsole' -> 'traversys', 'Linux X11 Terminal Emulator';
    unix_cmd 'Xsun' -> 'traversys', 'Linux X11 SUNWxwplt X Windows Platform Software';
end identify;

identify Macrovision 1.0
  tags Macrovision;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'CDAC11BA' -> 'traversys', 'Macrovision SafeCast Copy Protection';
end identify;

identify McCabe 1.0
  tags McCabe;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'adc\.module' -> 'traversys', 'McCabe TrueChange ADC Module';
end identify;

identify Micro_Focus 1.0
  tags Micro_Focus;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'xsrvmfe' -> 'traversys', 'Micro Focus XDB Server for MFE';
    windows_cmd 'xsrvnx' -> 'traversys', 'Micro Focus XDB Server for NX';
end identify;

identify Microsoft 1.1
  tags Microsoft;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'admd' -> 'traversys', 'Microsoft Active Server Pages';
    unix_cmd 'admdog' -> 'traversys', 'Microsoft Active Server Pages';
    unix_cmd 'admeng' -> 'traversys', 'Microsoft Active Server Pages';
    unix_cmd 'BTSmmc\.msc' -> 'traversys', 'Microsoft Biztalk Administration';
    windows_cmd '_ISCHAgent' -> 'traversys', 'Microsoft IIS Debug Tools Crash and Hang Monitoring Agent';
    windows_cmd 'acmsvc' -> 'traversys', 'Microsoft Site Server';
    windows_cmd 'aspnet_state' -> 'traversys', 'Microsoft ASP .Net Framework State Server';
    windows_cmd 'AUTMGR32' -> 'traversys', 'Microsoft Windows Remote Automation Manager';
    windows_cmd 'bcp' -> 'traversys', 'Microsoft SQL Server Bulk Copy Utility';
    windows_cmd 'bmss' -> 'traversys', 'Microsoft Windows NT BMonitor Session Manager';
    windows_cmd 'BOARDSERVER' -> 'traversys', 'Microsoft Windows NT BMonitor Session Manager';
    windows_cmd 'btservice' -> 'traversys', 'Microsoft BizTalk Service Account';
    windows_cmd 'cacls' -> 'traversys', 'Microsoft Windows Access Control List Tool';
    windows_cmd 'calc' -> 'traversys', 'Microsoft Windows Calculator';
    windows_cmd 'ccmsetup' -> 'traversys', 'Microsoft Windows System Center Configuration Manager';
    windows_cmd 'choice' -> 'traversys', 'Microsoft Windows Choice Command';
    windows_cmd 'ClearSaverSvc' -> 'traversys', 'Microsoft Windows Clear Screen Saver';
    windows_cmd 'clipsrv' -> 'traversys', 'Microsoft Windows Clipboard Server';
    windows_cmd 'collector' -> 'traversys', 'Microsoft Windows Inventory Tool/LanDesk Application';
    windows_cmd 'conime' -> 'traversys', 'Microsoft Windows Console IME';
    windows_cmd 'crssrv' -> 'traversys', 'Microsoft Site Server Content Deployment';
    windows_cmd 'csc' -> 'traversys', 'Microsoft Visual Studio C# Command Line Compiler';
    windows_cmd 'cscript' -> 'traversys', 'Microsoft Windows Console Based Script Host';
    windows_cmd 'cvs' -> 'traversys', 'Microsoft Windows CVS shell command';
    windows_cmd 'DRWTSN32' -> 'traversys', 'Microsoft Windows Common System Process';
    windows_cmd 'ecsrv' -> 'traversys', 'Microsoft Windows Secure Service';
    windows_cmd 'nscm' -> 'traversys', 'Microsoft Windows Media Station Service';
    windows_cmd 'nspm' -> 'traversys', 'Microsoft Windows Media Program Service';
    windows_cmd 'NSPMON' -> 'traversys', 'Microsoft Windows Media Monitor Service';
    windows_cmd 'proquota' -> 'traversys', 'Microsoft Windows System Process';
    windows_cmd 'wins' -> 'traversys', 'Microsoft Windows WINS Server';
end identify;

identify Nagios 1.0
  tags Nagios;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'nagios' -> 'traversys', 'Nagios System Monitoring Software';
end identify;

identify Oracle 1.5
    tags Oracle;
    DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'BIService' -> 'traversys', 'Oracle Hyperion Business Intelligence Service';
    unix_cmd 'cmadmin' -> 'traversys', 'Oracle Connection Administrative Manager';
    unix_cmd 'cman\.ora' -> 'traversys', 'Oracle Connection Manager Configuration File';
    unix_cmd 'cmgw' -> 'traversys', 'Oracle Connection Manager Gateway';
    unix_cmd 'crs_stat\.bin' -> 'traversys', 'Oracle RAC CRS Stats command';
    unix_cmd 'd2lc60' -> 'traversys', 'Oracle Developer Load Balancer Client';
    unix_cmd 'd2ls60' -> 'traversys', 'Oracle Developer Load Balancer Server';
    unix_cmd 'db-unload\.ora10' -> 'traversys', 'Oracle DB Unload Utility';
    unix_cmd 'ESSBASE' -> 'traversys', 'Oracle Hyperion Essbase';
    unix_cmd 'essmsh' -> 'traversys', 'Oracle Hyperion Essbase MaxL Shell';
    unix_cmd 'ESSSVR' -> 'traversys', 'Oracle Hyperion Essbase';
    unix_cmd 'exp' -> 'traversys', 'Oracle Essbase Hyperion Essbase';
    unix_cmd 'expres63' -> 'traversys', 'Oracle Express Server';
    unix_cmd 'f60webmx' -> 'traversys', 'Oracle Apps Forms Session';
    unix_cmd 'FNDCRM' -> 'traversys', 'Oracle FND Conflict Resolution Manager';
    unix_cmd 'FNDLIBR' -> 'traversys', 'Oracle Application Object Library (FND)';
    unix_cmd 'FNDSCH' -> 'traversys', 'Oracle FND Concurrent Manager Internal Scheduler Manager';
    unix_cmd 'FNDSM' -> 'traversys', 'Oracle FND GSM Core Component';
    unix_cmd 'gsdproxy' -> 'traversys', 'Oracle GSD Service Requests for 9i RAC Management Clients';
    unix_cmd 'names' -> 'traversys', 'Oracle Names';
    unix_cmd 'oad' -> 'traversys', 'Oracle Application Dealer';
    unix_cmd 'oclskd\.bin' -> 'traversys', 'Oracle Utility';
    unix_cmd 'ocssd\.bin' -> 'traversys', 'Oracle Cluster Synchronization Service';
    unix_cmd 'ons' -> 'traversys', 'Oracle Notification Service';
    unix_cmd 'oprocd' -> 'traversys', 'Oracle Process Monitor';
    unix_cmd 'oprocd\.bin' -> 'traversys', 'Oracle Process Monitor';
    unix_cmd 'perf_collect\.co' -> 'traversys', 'Oracle Performance Collector for Oracle Forms';
    unix_cmd 'PSDBGSRV' -> 'traversys', 'Oracle PeopleSoft PeopleCode Debugger';
    unix_cmd 'PSDSTSRV' -> 'traversys', 'Oracle PeopleSoft Distribution Agent';
    unix_cmd 'PSPRCSRV' -> 'traversys', 'Oracle PeopleSoft Process Scheduler Server Agent';
    unix_cmd 'PSPUBDSP' -> 'traversys', 'Oracle PeopleSoft Publication Dispatcher';
    unix_cmd 'PSPUBHND' -> 'traversys', 'Oracle PeopleSoft Publication Handler';
    unix_cmd 'PSQCKSRV' -> 'traversys', 'Oracle PeopleSoft Quick Server Manager';
    unix_cmd 'PSQRYSRV' -> 'traversys', 'Oracle PeopleSoft Query Server';
    unix_cmd 'PSRENSRV' -> 'traversys', 'Oracle PeopleSoft REN Server';
    unix_cmd 'PSSAMSRV' -> 'traversys', 'Oracle PeopleSoft Sql Access Manager';
    unix_cmd 'PSSUBDSP' -> 'traversys', 'Oracle PeopleSoft Subscription Dispatcher';
    unix_cmd 'PSSUBHND' -> 'traversys', 'Oracle PeopleSoft Subscription Handler';
    unix_cmd 'racgimon' -> 'traversys', 'Oracle Real Application Clusters';
    unix_cmd 'racgmain' -> 'traversys', 'Oracle Real Application Clusters';
    unix_cmd 'RCVOLTM' -> 'traversys', 'Oracle Apps Receiving Transaction Manager';
    unix_cmd 'rwmts60' -> 'traversys', 'Oracle Reports Server';
    unix_cmd 'sp_cop' -> 'traversys', 'Quest SharePlex for Oracle';
    unix_cmd 'svrmgrl' -> 'traversys', 'Oracle Server Manager Command';
    unix_cmd 'tnsping' -> 'traversys', 'Oracle TNS Ping Utility';
    unix_cmd 'xsdaemon' -> 'traversys', 'Oracle Express Server';
    windows_cmd 'admincon' -> 'traversys', 'Oracle Hyperion Enterprise Performance Management System Administration Services Console';
    windows_cmd 'adminsvr' -> 'traversys', 'Oracle Hyperion Essbase Administration Server';
    windows_cmd 'BIService' -> 'traversys', 'Oracle Hyperion Business Intelligence Service';
    windows_cmd 'cmsrvr' -> 'traversys', 'Oracle CMS Service';
    windows_cmd 'DiscSrvcStat' -> 'traversys', 'Oracle Discover Service Status';
    windows_cmd 'essbase' -> 'traversys', 'Oracle Hyperion Essbase';
    windows_cmd 'EssbaseEnterprise' -> 'traversys', 'Oracle Hyperion Essbase Enterprise';
    windows_cmd 'ESSERV\~1' -> 'traversys', 'Oracle Hyperion Essbase';
    windows_cmd 'ESSSVR' -> 'traversys', 'Oracle Hyperion Essbase';
    windows_cmd 'expres63' -> 'traversys', 'Oracle Express Server';
    windows_cmd 'fmsplnr' -> 'traversys', 'Oracle Financial Analyzer';
    windows_cmd 'HRCommSrv' -> 'traversys', 'Oracle Hyperion Reports Communication Server';
    windows_cmd 'HRPrintSrv' -> 'traversys', 'Oracle Hyperion Reports Print Server';
    windows_cmd 'HSFServer' -> 'traversys', 'Oracle Hyperion Strategic Finance Server';
    windows_cmd 'hsodbc' -> 'traversys', 'Oracle Heterogeneous Agent ODBC driver';
    windows_cmd 'HsvrCtrl' -> 'traversys', 'Oracle Hyperion Enterprise Application Server';
    windows_cmd 'HYPENT' -> 'traversys', 'Oracle Hyperion Enterprise';
    windows_cmd 'HyperionJavaService' -> 'traversys', 'Oracle Hyperion RMI Registry Service';
    windows_cmd 'HYSLD' -> 'traversys', 'Oracle Hyperion Essbase License';
    windows_cmd 'ifrun60' -> 'traversys', 'Oracle Forms Runform';
    windows_cmd 'JREW' -> 'traversys', 'Oracle Universal Installer (Java)';
    windows_cmd 'mdm_ntier_engine' -> 'traversys', 'Oracle Hyperion Master Data Management Installation';
    windows_cmd 'mdm_ntier_rio' -> 'traversys', 'Oracle Hyperion Data Relationship Manager NTier Event Publisher';
    windows_cmd 'MDM_WE\~2' -> 'traversys', 'Oracle Hyperion Data Relationship Manager Web Publishing NT service';
    windows_cmd 'mdm_web_publishing' -> 'traversys', 'Oracle Hyperion Data Relationship Manager Web Publishing NT Service';
    windows_cmd 'OCOPY' -> 'traversys', 'Oracle File Copy Utility';
    windows_cmd 'ocssd' -> 'traversys', 'Oracle Cluster Synchronization Service';
    windows_cmd 'OracleOBJService' -> 'traversys', 'Oracle Object Service';
    windows_cmd 'OraClrAgnt' -> 'traversys', 'Oracle XE Clr Agent';
    windows_cmd 'perf_collect\.co' -> 'traversys', 'Oracle Performance Collector for Oracle Forms';
    windows_cmd 'perf_collect\.com' -> 'traversys', 'Oracle Performance Collector for Oracle Forms';
    windows_cmd 'psae' -> 'traversys', 'Oracle PeopleSoft Application Engine';
    windows_cmd 'PSAESRV' -> 'traversys', 'Oracle PeopleSoft Application Engine Server';
    windows_cmd 'PSANALYTICSRV' -> 'traversys', 'Oracle PeopleSoft Analytic Server';
    windows_cmd 'PSAPPSRV' -> 'traversys', 'Oracle PeopleSoft Application Server';
    windows_cmd 'PSBRKDSP' -> 'traversys', 'Oracle PeopleSoft Publication Broker Server Dispatcher';
    windows_cmd 'PSBRKHND' -> 'traversys', 'Oracle PeopleSoft Broker Dispatcher';
    windows_cmd 'psdaemon' -> 'traversys', 'Oracle PeopleSoft Application Engine';
    windows_cmd 'PSDSTSRV' -> 'traversys', 'Oracle PeopleSoft Distribution Agent';
    windows_cmd 'PSMONITORSRV' -> 'traversys', 'Oracle PeopleSoft Performance Monitor';
    windows_cmd 'PSMSTPRC' -> 'traversys', 'Oracle PeopleSoft Master Scheduler Server';
    windows_cmd 'psntsrv' -> 'traversys', 'Oracle PeopleSoft Process Scheduler';
    windows_cmd 'PSPRCSRV' -> 'traversys', 'Oracle PeopleSoft Process Scheduler Server Agent';
    windows_cmd 'PSPUBDSP' -> 'traversys', 'Oracle PeopleSoft Publication Dispatcher';
    windows_cmd 'PSPUBHND' -> 'traversys', 'Oracle PeopleSoft Publication Handler';
    windows_cmd 'PSSAMSRV' -> 'traversys', 'Oracle PeopleSoft Sql Access Manager';
    windows_cmd 'PSSUBDSP' -> 'traversys', 'Oracle PeopleSoft Subscription Dispatcher';
    windows_cmd 'PSSUBHND' -> 'traversys', 'Oracle PeopleSoft Subscription Handler';
    windows_cmd 'PSWATCHSRV' -> 'traversys', 'Oracle PeopleSoft Watch Server';
    windows_cmd 'siebmtsh' -> 'traversys', 'Oracle Siebel Server Shell';
    windows_cmd 'siebmtshmw' -> 'traversys', 'Oracle Siebel Server Shell';
    windows_cmd 'siebsvc' -> 'traversys', 'Oracle Siebel Server';
    windows_cmd 'startEAS' -> 'traversys', 'Oracle Hyperion Essbase Administration Server';
    windows_cmd 'strtdb80' -> 'traversys', 'Oracle StartORCL';
    windows_cmd 'tg4msql' -> 'traversys', 'Oracle Transparent Gateway for MS-SQL Server';
    windows_cmd 'tg4sybs' -> 'traversys', 'Oracle Transparent Gateway for Sybase';
    windows_cmd 'tnsping' -> 'traversys', 'Oracle Net Services Oracle TNS Ping Utility';
    windows_cmd 'Toad' -> 'traversys', 'Quest TOAD for Oracle';
    windows_cmd 'xsaagent' -> 'traversys', 'Oracle OLAP Agent';
end identify;

identify Orbograph 1.0
  tags Orbograph;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'A2iARCPg' -> 'traversys', 'Orbograph Accura Checkreader Server Service Executable';
end identify;

identify 3Com 1.0
  tags inference.simple_identity_3Com;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd '3cmlink' -> 'traversys', '3Com Winmodem Driver';
end identify;

identify 3Ware 1.0
  tags inference.simple_identity_3Ware;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd '3dmd' -> 'traversys', '3Ware 3DM Disc Monitor';
    windows_cmd '3dm' -> 'traversys', '3Ware 3DM Disc Monitor';
end identify;

identify A2iA 1.0
  tags inference.simple_identity_A2iA;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'A2iARCPg' -> 'traversys', 'A2iA Checkreader Server Service Executable';
    windows_cmd 'A2iA_Service' -> 'traversys', 'A2iA Checkreader Server Service Executable';
end identify;

identify Actimize 1.0
  tags inference.simple_identity_Actimize;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'AISSrv' -> 'traversys', 'Actimize Analytics Intelligence Server Service';
end identify;

identify ActivePDF 1.0
  tags inference.simple_identity_ActivePDF;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'APDCDFLT' -> 'traversys', 'ActivePDF Default Processor';
    windows_cmd 'APDCEX2K' -> 'traversys', 'ActivePDF Excel 2000 DocConverter';
    windows_cmd 'APDCPOST' -> 'traversys', 'ActivePDF PostScript DocConverter';
    windows_cmd 'APDCPP2K' -> 'traversys', 'ActivePDF PowerPoint 2000 DocConverter';
    windows_cmd 'APDCSYSO' -> 'traversys', 'ActivePDF DocConverter SystemOnly Launch';
    windows_cmd 'APDCWD2K' -> 'traversys', 'ActivePDF Word 2000 DocConverter';
    windows_cmd 'APDOCCNV' -> 'traversys', 'ActivePDF DocConverter';
    windows_cmd 'APSERVER' -> 'traversys', 'activePDF Server';
    windows_cmd 'APSPOOL' -> 'traversys', 'ActivePDF Spooler';
    windows_cmd 'APWEBGRB' -> 'traversys', 'activePDF WebGrabber';
end identify;

identify Actuate 1.0
  tags inference.simple_identity_Actuate;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'actuatewindowsservice' -> 'traversys', 'Actuate Windows Service';
end identify;

identify AcuCorp 1.0
  tags inference.simple_identity_AcuCorp;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'acurcl' -> 'traversys', 'AcuCorp AcuConnect Listener';
    unix_cmd 'acushare' -> 'traversys', 'AcuCorp Acushare License Manager Service';
end identify;

identify Adaptec 1.0
  tags inference.simple_identity_Adaptec;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'aqagent' -> 'traversys', 'Adaptec Application Quiesce Agent';
end identify;

identify AdLib 1.0
  tags inference.simple_identity_AdLib;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'AdlibFMR' -> 'traversys', 'AdLib Express Data Execution Prevention';
    windows_cmd 'AdlibPDF' -> 'traversys', 'AdLib Express Data Execution Prevention';
end identify;

identify Adobe 1.0
  tags inference.simple_identity_Adobe;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'acroread' -> 'traversys', 'Adobe Acrobat Reader';
    unix_cmd 'CANamingAdapter' -> 'traversys', 'Adobe ColdFusion Server Adaptor';
    unix_cmd 'distill' -> 'traversys', 'Adobe Acrobat Distiller';
    windows_cmd 'acrobat' -> 'traversys', 'Adobe Acrobat Writer';
    windows_cmd 'AcrobatElementsServer' -> 'traversys', 'Adobe Elements Server';
    windows_cmd 'acrodist' -> 'traversys', 'Adobe Acrobat Distiller';
    windows_cmd 'Adobe\sMedia\sPlayer' -> 'traversys', 'Adobe Media Player';
    windows_cmd 'AdobeUpdateManager' -> 'traversys', 'Adobe Update Manager';
    windows_cmd 'AdobeUpdater' -> 'traversys', 'Adobe Updater';
    windows_cmd 'AOM' -> 'traversys', 'Adobe Automatic Updater';
    windows_cmd 'apdproxy' -> 'traversys', 'Adobe Photoshop';
    windows_cmd 'CANamingAdapter' -> 'traversys', 'Adobe ColdFusion Server Adaptor';
    windows_cmd 'ccmgr' -> 'traversys', 'Adobe ColdFusion Monitoring Service (ClusterCATS Service)';
    windows_cmd 'cfexec' -> 'traversys', 'Adobe ColdFusion Executive (Cold Fusion Executive)';
    windows_cmd 'cfrdsservice' -> 'traversys', 'Adobe ColdFusion RDS';
    windows_cmd 'cfserver' -> 'traversys', 'Adobe Cold Fusion Application Server';
    windows_cmd 'FlexBuilder' -> 'traversys', 'Adobe Flex Builder';
    windows_cmd 'reader_sl' -> 'traversys', 'Adobe Reader SpeedLauncher';
    windows_cmd 'swagent' -> 'traversys', 'Adobe ColdFusion MX ODBC Agent';
end identify;

identify AMD 1.0
  tags inference.simple_identity_AMD;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'ati2plxx' -> 'traversys', 'AMD ATI Display Adapter';
    windows_cmd 'Atiptaxx' -> 'traversys', 'AMD ATI Display Adapter';
end identify;

identify Arcana 1.0
  tags inference.simple_identity_Arcana;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'adscheduler' -> 'traversys', 'Arcana Development Scheduler';
end identify;

identify Attachmate 1.0
  tags inference.simple_identity_Attachmate;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'ssh-rand-helper' -> 'traversys', 'Attachmate WRQ Reflection Secure';
end identify;

identify Avaya 1.0
  tags inference.simple_identity_Avaya;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'acsApp' -> 'traversys', 'Avaya CMS Supervisor';
    windows_cmd 'acsCNTRL' -> 'traversys', 'Avaya CMS Supervisor';
    windows_cmd 'acsRep' -> 'traversys', 'Avaya CMS Supervisor Report Component';
    windows_cmd 'acsSRV' -> 'traversys', 'Avaya CMS Supervisor Server Component';
    windows_cmd 'ACSTrans' -> 'traversys', 'Avaya CMS Supervisor';
    windows_cmd 'asaisrvc' -> 'traversys', 'Avaya ASAI Server';
end identify;

identify Bitvise 1.0
  tags inference.simple_identity_Bitvise;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'winsshd' -> 'traversys', 'Bitvise WinSSHD';
end identify;

identify BMC 1.0
  tags inference.simple_identity_BMC;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd '(?i)^armonitor' -> 'traversys', 'BMC ARS Server Monitor';
    unix_cmd '(arserver|ar).*\/armonitor' -> 'traversys', 'BMC ARS Server Monitor';
    unix_cmd 'arforkd' -> 'traversys', 'BMC Remedy Action Request System';
    unix_cmd 'arplugin' -> 'traversys', 'BMC Remedy ARPlugin Server';
    unix_cmd 'brsvcbrie' -> 'traversys', 'BMC SLA Application Server';
    windows_cmd 'ar\ssystem.*\\armonitor' -> 'traversys', 'BMC ARS Server Monitor';
    windows_cmd 'arplugin' -> 'traversys', 'BMC Remedy ARPlugin Server';
    windows_cmd 'arrecond' -> 'traversys', 'BMC Reconciliation Engine';
    windows_cmd 'arserver' -> 'traversys', 'BMC Remedy AR Server';
    windows_cmd 'Magic\sJob\sProcessor\s-\sMagicMBA' -> 'traversys', 'BMC Magic Job Processor';
end identify;

identify Broadcom 1.0
  tags inference.simple_identity_Broadcom;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'BacsTray' -> 'traversys', 'Broadcom Advanced Control Suite Tray Icon';
    windows_cmd 'BAsfIpM' -> 'traversys', 'Broadcom ASF IP Monitoring Service';
end identify;

identify Broadgun 1.0
  tags inference.simple_identity_Broadgun;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'bgsmsnd' -> 'traversys', 'Broadgun pdfMachine Background PDF Generator';
end identify;

identify Cisco 1.0
  tags inference.simple_identity_Cisco;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'NSnGeniusNative.exe$' -> 'traversys', 'Cisco nGenius RealTime Monitor';
    unix_cmd 'NSnGeniusNative' -> 'traversys', 'Cisco nGenius RealTime Monitor';
    unix_cmd 'PsMiddleware' -> 'traversys', 'Cisco nGenius RealTime Monitor';
end identify;

identify Citrix 1.0
  tags inference.simple_identity_Citrix;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'ctxcdmd' -> 'traversys', 'Citrix Client Drive Mapping';
    windows_cmd 'ActivationServiceHost' -> 'traversys', 'Citrix Citrix Advanced Access Control agent';
    windows_cmd 'AgentSVC' -> 'traversys', 'Citrix ADF Installer Service';
    windows_cmd 'CitrixExplorer' -> 'traversys', 'Citrix Citrix Explorer';
    windows_cmd 'ctxactivesync' -> 'traversys', 'Citrix Citrix Active Sync';
    windows_cmd 'CtxSecGwy' -> 'traversys', 'Citrix Secure Gateway Service';
    windows_cmd 'fbserver' -> 'traversys', 'Citrix Firebird EdgeSight Agent';
    windows_cmd 'HCAService' -> 'traversys', 'Citrix Health Monitoring and Recovery';
    windows_cmd 'IMAAdvanceSrv' -> 'traversys', 'Citrix Services Manager';
    windows_cmd 'mfcom' -> 'traversys', 'Citrix MetaFrame Component Object Model';
    windows_cmd 'pn' -> 'traversys', 'Citrix Program Neighbourhood';
    windows_cmd 'PNAMain' -> 'traversys', 'Citrix Program Neighbourhood Agent';
    windows_cmd 'RadeObj' -> 'traversys', 'Citrix Streaming Service';
    windows_cmd 'RadeSvc' -> 'traversys', 'Citrix Streaming Service';
    windows_cmd 'rscorsvc' -> 'traversys', 'Citrix System Monitoring Agent Service';
    windows_cmd 'saginst' -> 'traversys', 'Citrix Installer Service';
    windows_cmd 'SemsService' -> 'traversys', 'Citrix Edgesight Session Experience Monitoring Service';
    windows_cmd 'streamprocess' -> 'traversys', 'Citrix Stream Service';
    windows_cmd 'StreamService' -> 'traversys', 'Citrix Stream Service';
    windows_cmd 'stuisrv' -> 'traversys', 'Citrix Enhanced Logon Status Service';
end identify;

identify Citrix 1.0
  tags inference.simple_identity_Citrix;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'ctxclipboard' -> 'traversys', 'Citrix MetaFrame for Unix Cut and Paste Activity';
    unix_cmd 'ctxfm' -> 'traversys', 'Citrix MetaFrame for Unix Frame Manager';
    unix_cmd 'ctxgrab' -> 'traversys', 'Citrix MetaFrame for Unix Cut and Paste Graphics Activity';
    unix_cmd 'ctxibrowser' -> 'traversys', 'Citrix MetaFrame for Unix ICA Browser';
    unix_cmd 'ctxxmld' -> 'traversys', 'Citrix MetaFrame for Unix XML Service';
    windows_cmd 'ctxhide' -> 'traversys', 'Citrix MetaFrame Presentation Server UserLogon DOS Window Hide';
end identify;

identify Corel 1.0
    tags inference.simple_identity_Corel;
    DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'WZZIP' -> 'traversys', 'Corel WinZip';
end identify;

identify Creative_Labs 1.0
  tags inference.simple_identity_Creative_Labs;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'CTsvcCDA' -> 'traversys', 'Creative Labs Creative Service for CD-ROM Access';
end identify;

identify CrypKey 1.0
  tags inference.simple_identity_CrypKey;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'crypserv' -> 'traversys', 'CrypKey Server';
end identify;

identify Deutsche_Borse 1.0
  tags inference.simple_identity_Deutsche_Borse;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'base90.*\\avm' -> 'traversys', 'Deutsche Borse GATE Availability Manager (Production)';
    windows_cmd 'base90.*\\brcrec' -> 'traversys', 'Deutsche Borse GATE Broadcast Receiver (Production)';
    windows_cmd 'base90.*\\gwc' -> 'traversys', 'Deutsche Borse GATE GateWatchClient (Production)';
    windows_cmd 'base90.*\\lantc' -> 'traversys', 'Deutsche Borse GATE Lan Transport Client (Production)';
    windows_cmd 'base90.*\\PBH' -> 'traversys', 'Deutsche Borse GATE Process Background Handler (Production)';
    windows_cmd 'base90.*\\ses' -> 'traversys', 'Deutsche Borse GATE Session Manager (Production)';
    windows_cmd 'base91.*\\avm' -> 'traversys', 'Deutsche Borse GATE Availability Manager (Simulation)';
    windows_cmd 'base91.*\\brcrec' -> 'traversys', 'Deutsche Borse GATE Broadcast Receiver (Simulation)';
    windows_cmd 'base91.*\\gwc' -> 'traversys', 'Deutsche Borse GATE GateWatchClient (Simulation)';
    windows_cmd 'base91.*\\lantc' -> 'traversys', 'Deutsche Borse GATE Lan Transport Client (Simulation)';
    windows_cmd 'base91.*\\ses' -> 'traversys', 'Deutsche Borse GATE Session Manager (Simulation)';
    unix_cmd '\./brcrec' -> 'traversys', 'Deutsche Borse GATE Broadcast Receiver (Production)';
    unix_cmd '\./gwc' -> 'traversys', 'Deutsche Borse GATE GateWatchClient';
    unix_cmd '\./gws' -> 'traversys', 'Deutsche Borse GATE GateWatchServer';
end identify;

identify EAS 1.0
  tags inference.simple_identity_EAS;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'KCBulkLoad' -> 'traversys', 'EAS Knowledge Capture Bulk Load Module';
    windows_cmd 'KCBulkLoadService' -> 'traversys', 'EAS Knowledge Capture Bulk Load Module';
end identify;

identify Encoded_Media 1.0
  tags inference.simple_identity_Encoded_Media;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'AdminServer' -> 'traversys', 'Encoded Media TV Admin Server';
end identify;

identify Eurex 1.0
  tags inference.simple_identity_Eurex;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'eurexPTC' -> 'traversys', 'Eurex Eurex Printable Trade Confirmations';
end identify;

identify Fujitsu_Siemens 1.0
  tags inference.simple_identity_Fujitsu_Siemens;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'adaptagt' -> 'traversys', 'Fujitsu Siemens Prime Power ServerView Suite Subagent';
end identify;

identify Global_Maintech_Corp 1.0
  tags inference.simple_identity_Global_Maintech_Corp;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'gwconsole' -> 'traversys', 'Global Maintech Corp Virtual Command Center Console Window';
    unix_cmd 'gwconsolemgrd' -> 'traversys', 'Global Maintech Corp Virtual Command Center Console Manager';
    unix_cmd 'gwEventMgrD' -> 'traversys', 'Global Maintech Corp Virtual Command Center Event Manager';
    unix_cmd 'gwPingerD' -> 'traversys', 'Global Maintech Corp Virtual Command Center Pinger';
    unix_cmd 'gwserialmgrd' -> 'traversys', 'Global Maintech Corp Virtual Command Center Serial Manager';
    unix_cmd 'gwStatMgrD' -> 'traversys', 'Global Maintech Corp Virtual Command Center Stat Manager';
end identify;

identify Hummingbird 1.0
  tags inference.simple_identity_Hummingbird;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'xsession' -> 'traversys', 'Hummingbird Exceed Xsession';
end identify;

identify Interactive_Intelligence 1.1
  tags inference.simple_identity_Interactive_Intelligence;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'AccServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Accumulator Server';
    windows_cmd 'AcdServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Automatic Call Distributor';
    windows_cmd 'AdminServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Admin Server';
    windows_cmd 'AlertServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Alert Service';
    windows_cmd 'ClientServicesU' -> 'traversys', 'Interactive Intelligence Interaction Center Client Services';
    windows_cmd 'CompressorManagerU' -> 'traversys', 'Interactive Intelligence Interaction Center Compressor Manager';
    windows_cmd 'DataManagerU' -> 'traversys', 'Interactive Intelligence Interaction Center Data Manager';
    windows_cmd 'DSServerU' -> 'traversys', 'Interactive Intelligence Interaction Center DS Server';
    windows_cmd 'FaxServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Fax Server';
    windows_cmd 'HostServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Host Server';
    windows_cmd 'IPDBServer2U' -> 'traversys', 'Interactive Intelligence Interaction Center IP PBX Server';
    windows_cmd 'IPDBServerU' -> 'traversys', 'Interactive Intelligence Interaction Center IP PBX Server';
    windows_cmd 'IpServerU' -> 'traversys', 'Interactive Intelligence Interaction Center IP PBX Server';
    windows_cmd 'IPU' -> 'traversys', 'Interactive Intelligence Interaction Center IP PBX Server';
    windows_cmd 'IRServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Routing Server';
    windows_cmd 'IRTranServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Routing Server';
    windows_cmd 'MailAcctMonU' -> 'traversys', 'Interactive Intelligence Interaction Center Mail Monitor Service';
    windows_cmd 'NotifierU' -> 'traversys', 'Interactive Intelligence Interaction Center Notification Service';
    windows_cmd 'PostOfficeServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Message Access Service';
    windows_cmd 'RecoSubsystemU' -> 'traversys', 'Interactive Intelligence Interaction Center Recorder SubSystem';
    windows_cmd 'RSTrapMonitorU' -> 'traversys', 'Interactive Intelligence Interaction Center Trap Monitor';
    windows_cmd 'SMSServerU' -> 'traversys', 'Interactive Intelligence Interaction Center SMS Service';
    windows_cmd 'StatServerU' -> 'traversys', 'Interactive Intelligence Interaction Center Status Service';
    windows_cmd 'TrackerSvrU' -> 'traversys', 'Interactive Intelligence Interaction Center Tracker Service';
    windows_cmd 'TrackerTranU' -> 'traversys', 'Interactive Intelligence Interaction Center Tracker Tran Service';
    windows_cmd 'TsServerU' -> 'traversys', 'Interactive Intelligence Interaction Center TsServer';
    windows_cmd 'WebProcessorU' -> 'traversys', 'Interactive Intelligence Interaction Center Web Service';
end identify;

identify Invensys 1.0
  tags inference.simple_identity_Invensys;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'aahDrvSvc' -> 'traversys', 'Invensys WonderWare Industrial SQL System Driver Service';
    windows_cmd 'aahEventSvc' -> 'traversys', 'Invensys WonderWare Industrial SQL Event Systen Service';
    windows_cmd 'aahIDASSvc' -> 'traversys', 'Invensys WonderWare Industrial SQL Data Acquistion Service';
    windows_cmd 'aahIndexSvc' -> 'traversys', 'Invensys WonderWare Industrial SQL Indexing Service';
    windows_cmd 'aahIOSvrSvc' -> 'traversys', 'Invensys WonderWare Industrial SQL Data Retrieval Service';
    windows_cmd 'aaHistClientReportingService' -> 'traversys', 'Invensys Wonderware Active Factory Reporting Service';
    windows_cmd 'aahManStSvc' -> 'traversys', 'Invensys WonderWare Industrial SQL Data Storage Service';
    windows_cmd 'aahRetSvc' -> 'traversys', 'Invensys WonderWare Industrial SQL Data Retrieval Service';
    windows_cmd 'aahSCM' -> 'traversys', 'Invensys WonderWare Industrial SQL Status Info Service';
    windows_cmd 'aahStoreSvc' -> 'traversys', 'Invensys WonderWare Industrial SQL Data Storage Service';
    windows_cmd 'aaLogger' -> 'traversys', 'Invensys ArchestrA Logging Service';
    windows_cmd 'aaTrend' -> 'traversys', 'Invensys Wonderware Active Factory Trend Files';
    windows_cmd 'alarmmgr' -> 'traversys', 'Invensys InTouch Wonderware InTouch Alarm Manager';
    windows_cmd 'hCfgSvc' -> 'traversys', 'Invensys WonderWare Industrial SQL Configuration Request Service';
end identify;

identify Iona 1.0
  tags inference.simple_identity_Iona;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd '(?i)iona.*\bitifr' -> 'traversys', 'Iona Orbix Interface Repository';
    unix_cmd '(?i)iona.*\bitlocator' -> 'traversys', 'Iona Orbix Locator';
    unix_cmd '(?i)iona.*\bitmanagement' -> 'traversys', 'Iona Orbix Services Management';
    unix_cmd '(?i)iona.*\bitnaming' -> 'traversys', 'Iona Orbix Naming Service Database';
    unix_cmd '(?i)iona.*\bitnode_daemon' -> 'traversys', 'Iona Orbix Node';
    unix_cmd '(?i)iona.*\btconfig_rep' -> 'traversys', 'Iona Orbix Configuration Repository';
end identify;

identify Ipswitch 1.0
  tags inference.simple_identity_Ipswitch;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'iFtpSvc' -> 'traversys', 'Ipswitch File Transfer WS_FTP Server';
    windows_cmd 'WhatsUpG' -> 'traversys', 'Ipswitch WhatsUp Gold WhatsUp Gold';
end identify;

identify Kalab 1.0
  tags inference.simple_identity_Kalab;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'cron' -> 'traversys', 'Kalab Cron Tool for Windows';
end identify;

identify KDE 1.0
  tags inference.simple_identity_KDE;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'kblankscrn\.kss' -> 'traversys', 'KDE ScreenSaver';
end identify;

identify Kiwi 1.0
  tags inference.simple_identity_Kiwi;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'CatTools_Client' -> 'traversys', 'Kiwi CatTools Client';
    windows_cmd 'CatTools_Manager' -> 'traversys', 'Kiwi CatTools Service Manager';
    windows_cmd 'CatTools_Service' -> 'traversys', 'Kiwi CatTools Service';
end identify;

identify Kofax 1.1
  tags inference.simple_identity_Kofax;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'ACIRsa' -> 'traversys', 'Kofax Ascent Capture Internet Server Remote Sync Agent';
    windows_cmd 'ACLicUtl' -> 'traversys', 'Kofax Ascent Capture Internet Server License Utility';
    windows_cmd 'ACSAI' -> 'traversys', 'Kofax Ascent Capture Import Connector';
    windows_cmd 'ACSvc' -> 'traversys', 'Kofax Ascent Capture Service';
    windows_cmd 'ACXMLAI' -> 'traversys', 'Kofax Ascent Capture XML Import Utility';
    windows_cmd 'Fp' -> 'traversys', 'Kofax Ascent Capture Recognition Server';
    windows_cmd 'Index' -> 'traversys', 'Kofax Ascent Capture Validation';
    windows_cmd 'kfxPdf' -> 'traversys', 'Kofax Ascent Capture PDF Generator';
    windows_cmd 'ocr32ex' -> 'traversys', 'Kofax Ascent Capture OCR Full Text';
    windows_cmd 'Ocr' -> 'traversys', 'Kofax Ascent Capture OCR Full Text';
    windows_cmd 'Ops' -> 'traversys', 'Kofax Ascent Capture Batch Manager';
    windows_cmd 'Release' -> 'traversys', 'Kofax Ascent Capture Release Module';

end identify;

identify Linux 1.1
  tags inference.simple_identity_Linux;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'cfexecd' -> 'traversys', 'Linux Network Configuration Engine';
    unix_cmd 'dtksh' -> 'traversys', 'Linux X11 Enabled Korn Shell';
    unix_cmd 'kate' -> 'traversys', 'Linux Kate Text Editor';
    unix_cmd 'lsof' -> 'traversys', 'Linux OS Tool Unix lsof';
    unix_cmd 'vimx' -> 'traversys', 'Linux X11 X Windows System subprocess';
    unix_cmd 'xconsole' -> 'traversys', 'Linux X11 Terminal Emulator';
    unix_cmd 'Xsun' -> 'traversys', 'Linux X11 SUNWxwplt X Windows Platform Software';
end identify;

identify Macrovision 1.0
  tags inference.simple_identity_Macrovision;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'CDAC11BA' -> 'traversys', 'Macrovision SafeCast Copy Protection';
end identify;

identify McCabe 1.0
  tags inference.simple_identity_McCabe;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'adc\.module' -> 'traversys', 'McCabe TrueChange ADC Module';
end identify;

identify Micro_Focus 1.0
  tags inference.simple_identity_Micro_Focus;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'xsrvmfe' -> 'traversys', 'Micro Focus XDB Server for MFE';
    windows_cmd 'xsrvnx' -> 'traversys', 'Micro Focus XDB Server for NX';
end identify;

identify Microsoft 1.1
  tags inference.simple_identity_Microsoft;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'admd' -> 'traversys', 'Microsoft Active Server Pages';
    unix_cmd 'admdog' -> 'traversys', 'Microsoft Active Server Pages';
    unix_cmd 'admeng' -> 'traversys', 'Microsoft Active Server Pages';
    unix_cmd 'BTSmmc\.msc' -> 'traversys', 'Microsoft Biztalk Administration';
    windows_cmd '_ISCHAgent' -> 'traversys', 'Microsoft IIS Debug Tools Crash and Hang Monitoring Agent';
    windows_cmd 'acmsvc' -> 'traversys', 'Microsoft Site Server';
    windows_cmd 'admd' -> 'traversys', 'Microsoft Active Server Pages';
    windows_cmd 'aspnet_state' -> 'traversys', 'Microsoft ASP .Net Framework State Server';
    windows_cmd 'AUTMGR32' -> 'traversys', 'Microsoft Windows Remote Automation Manager';
    windows_cmd 'bcp' -> 'traversys', 'Microsoft SQL Server Bulk Copy Utility';
    windows_cmd 'bmss' -> 'traversys', 'Microsoft Windows NT BMonitor Session Manager';
    windows_cmd 'BOARDSERVER' -> 'traversys', 'Microsoft Windows NT BMonitor Session Manager';
    windows_cmd 'btservice' -> 'traversys', 'Microsoft BizTalk Service Account';
    windows_cmd 'cacls' -> 'traversys', 'Microsoft Windows Access Control List Tool';
    windows_cmd 'calc' -> 'traversys', 'Microsoft Windows Calculator';
    windows_cmd 'ccmsetup' -> 'traversys', 'Microsoft Windows System Center Configuration Manager';
    windows_cmd 'choice' -> 'traversys', 'Microsoft Windows Choice Command';
    windows_cmd 'ClearSaverSvc' -> 'traversys', 'Microsoft Windows Clear Screen Saver';
    windows_cmd 'clipsrv' -> 'traversys', 'Microsoft Windows Clipboard Server';
    windows_cmd 'collector' -> 'traversys', 'Microsoft Windows Inventory Tool/LanDesk Application';
    windows_cmd 'conime' -> 'traversys', 'Microsoft Windows Console IME';
    windows_cmd 'crssrv' -> 'traversys', 'Microsoft Site Server Content Deployment';
    windows_cmd 'csc' -> 'traversys', 'Microsoft Visual Studio C# Command Line Compiler';
    windows_cmd 'cscript' -> 'traversys', 'Microsoft Windows Console Based Script Host';
    windows_cmd 'cvs' -> 'traversys', 'Microsoft Windows CVS shell command';
    windows_cmd 'DRWTSN32' -> 'traversys', 'Microsoft Windows Common System Process';
    windows_cmd 'ecsrv' -> 'traversys', 'Microsoft Windows Secure Service';
    windows_cmd 'nscm' -> 'traversys', 'Microsoft Windows Media Station Service';
    windows_cmd 'nspm' -> 'traversys', 'Microsoft Windows Media Program Service';
    windows_cmd 'NSPMON' -> 'traversys', 'Microsoft Windows Media Monitor Service';
    windows_cmd 'proquota' -> 'traversys', 'Microsoft Windows System Process';
    windows_cmd 'wins' -> 'traversys', 'Microsoft Windows WINS Server';
end identify;

identify Nagios 1.0
  tags inference.simple_identity_Nagios;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'nagios' -> 'traversys', 'Nagios System Monitoring Software';
end identify;

//identify Orbograph 1.0
//  tags inference.simple_identity_Orbograph;
//  DiscoveredProcess cmd -> set_by, simple_identity;

//end identify;

identify Pervasive 1.0
  tags inference.simple_identity_Pervasive;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'W32MKDE' -> 'traversys', 'Pervasive Btrieve Database MicroKernel Database Engine';
    windows_cmd 'w3sqlmgr' -> 'traversys', 'Pervasive PSQL Pervasive SQL Server (Relational)';
end identify;

identify Platform 1.0
  tags inference.simple_identity_Platform;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'bqueues' -> 'traversys', 'Platform LSF Batch Queues Information Manual Command';
end identify;

identify Progress 1.0
  tags inference.simple_identity_Progress;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd '_progres' -> 'traversys', 'Progress OpenEdge DB Client Dataserver Executable';
    unix_cmd '_prohlc' -> 'traversys', 'Progress OpenEdge Database';
    unix_cmd '_sqlsrv2' -> 'traversys', 'Progress OpenEdge DB SQL Client';
    windows_cmd '_sqlsrv2' -> 'traversys', 'Progress OpenEdge DB SQL Client';
    windows_cmd 'AdmSrvc' -> 'traversys', 'Progress AdminService for Progress Database';
end identify;

identify Quest 1.1
  tags inference.simple_identity_Quest;
  DiscoveredProcess cmd -> set_by, simple_identity;
    regex '(?i)\besm_log_restart' -> 'traversys', 'Quest Foglight LogFilter restart';
    regex '(?i)\bfgaOraAgent' -> 'traversys', 'Quest Foglight fgaOra Agent';
    regex '(?i)\bFGLServerMonitor@' -> 'traversys', 'Quest Foglight Server Monitor Agent';
    regex '(?i)\bFileSystem@' -> 'traversys', 'Quest Foglight Filesystem Agent';
    regex '(?i)\bfoglight.*\bApacheSvr' -> 'traversys', 'Quest Foglight Apache Agent';
    regex '(?i)\bfoglight.*\bDB2_db2' -> 'traversys', 'Quest Foglight DB2 Agent';
    regex '(?i)\bfoglight.*\bDB2_Website' -> 'traversys', 'Quest Foglight DB2 Agent';
    regex '(?i)\bfoglight.*\bDB2Monitor' -> 'traversys', 'Quest Foglight DB2 Monitor Agent';
    regex '(?i)\bfoglight.*\bLogFilter' -> 'traversys', 'Quest Foglight LogFilter';
    regex '(?i)\bfoglight.*\bNetMonitor@' -> 'traversys', 'Quest Foglight NetMonitor';
    regex '(?i)\bfoglight.*\bNT_System@' -> 'traversys', 'Quest Foglight NT System Agent';
    regex '(?i)\bfoglight.*\bOracleHost@' -> 'traversys', 'Quest Foglight OracleHost Agent';
    regex '(?i)\bfoglight.*\bSQLServer' -> 'traversys', 'Quest Foglight SQLServer Agent';
    unix_cmd 'AppMonitor' -> 'traversys', 'Quest Foglight Foundation System Application Monitoring Agent';
    unix_cmd 'dalsrv' -> 'traversys', 'Quest Foglight dalsrv';
    unix_cmd 'dbquery' -> 'traversys', 'Quest Foglight DB Query';
    unix_cmd 'dm' -> 'traversys', 'Quest Foglight dm';
    unix_cmd 'FCFM_LogFilter' -> 'traversys', 'Quest Foglight LogFilter';
    unix_cmd 'fglam' -> 'traversys', 'Quest Foglight Agent Manager';
    unix_cmd 'fglDBServer' -> 'traversys', 'Quest Foglight fgldb server';
    unix_cmd 'fglschd' -> 'traversys', 'Quest Foglight fglschd';
    unix_cmd 'fglslpd' -> 'traversys', 'Quest Foglight fglslp';
    windows_cmd 'AppMonitor' -> 'traversys', 'Quest Foglight Foundation System Application Monitoring Agent';
    windows_cmd 'dalsrv' -> 'traversys', 'Quest Foglight dalsrv';
    windows_cmd 'dbquery' -> 'traversys', 'Quest Foglight DB Query';
    windows_cmd 'dm' -> 'traversys', 'Quest Foglight dm';
    windows_cmd 'fgaSQLServer' -> 'traversys', 'Quest Foglight SQL';
    windows_cmd 'fglam' -> 'traversys', 'Quest Foglight Agent Manager';
    windows_cmd 'fglschd' -> 'traversys', 'Quest Foglight fglschd';
    windows_cmd 'fglslpd' -> 'traversys', 'Quest Foglight fglslp';
    windows_cmd 'ne' -> 'traversys', 'Quest Foglight ne';
    windows_cmd 'nss' -> 'traversys', 'Quest Foglight nss';
    windows_cmd 'rapsd' -> 'traversys', 'Quest Foglight rapsd';
    windows_cmd 'rapsService' -> 'traversys', 'Quest Foglight rapsService';
    windows_cmd 'serverd' -> 'traversys', 'Quest Foglight Server';
end identify;

identify Raxco 1.0
  tags inference.simple_identity_Raxco;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'pdagent' -> 'traversys', 'Raxco PerfectDisk PDAgent Module';
end identify;

identify RepliWeb 1.0
  tags inference.simple_identity_RepliWeb;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'active_server' -> 'traversys', 'RepliWeb Active Server Directory Synchronization';
    windows_cmd 'archive_server' -> 'traversys', 'RepliWeb Archive Server Directory Synchronization';
    windows_cmd 'fcservice' -> 'traversys', 'RepliWeb FastCopy Service Directory Synchronization';
    windows_cmd 'gastart' -> 'traversys', 'RepliWeb FastCopy Service Directory Synchronization';
    windows_cmd 'repliweb_scheduler_service' -> 'traversys', 'RepliWeb Scheduler Service Directory Synchronization';
    windows_cmd 'repliweb_server' -> 'traversys', 'RepliWeb RDS Server Directory Synchronization';
    windows_cmd 'sched_api_server' -> 'traversys', 'RepliWeb Scheduler Service Directory Synchronization';
    windows_cmd 'submit_server' -> 'traversys', 'RepliWeb Scheduler Service Directory Synchronization';
end identify;

identify Thomson_Reuters 1.0
  tags inference.simple_identity_Thomson_Reuters;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'rxmssync' -> 'traversys', 'Thomson Reuters XMS Sync';
end identify;

identify RJS 1.0
  tags inference.simple_identity_RJS;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd '400Convert' -> 'traversys', 'RJS RTF Report Converter';
end identify;

identify RSA 1.0
  tags inference.simple_identity_RSA;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd '_aceserver_be' -> 'traversys', 'RSA SecureID Server ACE Authentication Engine Backend';
    unix_cmd '_aceserver_fe' -> 'traversys', 'RSA SecureID Server ACE Authentication Engine Frontend';
    unix_cmd 'aceapi_rpc_server' -> 'traversys', 'RSA SecureID Server ACE WebAgent';
    unix_cmd 'aceService' -> 'traversys', 'RSA SecureID Server ACE Authentication Engine';
    unix_cmd 'acesyncd' -> 'traversys', 'RSA SecureID Server ACE Background Comms';
    windows_cmd 'acesrvc_be' -> 'traversys', 'RSA SecureID Server ACE Authentication Engine Backend';
    windows_cmd 'acesrvc' -> 'traversys', 'RSA SecureID Server ACE Authentication Engine';
    windows_cmd 'apidemon' -> 'traversys', 'RSA SecureID Server Authentication Manager';
    windows_cmd 'brksrv' -> 'traversys', 'RSA SecureID Authentication Manager Broker Service';
    windows_cmd 'da_svc' -> 'traversys', 'RSA SecureID Authentication Manager Authentication Agent';
    windows_cmd 'jsed' -> 'traversys', 'RSA SecureID Authentication Manager Job Executor';
    windows_cmd 'logmaintthd' -> 'traversys', 'RSA SecureID Authentication Manager Log Maintenance';
    windows_cmd 'radius' -> 'traversys', 'RSA SecureID Authentication Manager Radius Service';
    windows_cmd 'sdadmind' -> 'traversys', 'RSA SecureID Authentication Manager ACE Remote Administration Authentication';
    windows_cmd 'sdcommd_session' -> 'traversys', 'RSA SecureID Authentication Manager ACE Quick Admin';
    windows_cmd 'sdcommd' -> 'traversys', 'RSA SecureID Authentication Manager ACE Quick Admin';
    windows_cmd 'syncsrvc' -> 'traversys', 'RSA SecureID Authentication Manager Replication';
end identify;

identify Sage 1.0
  tags inference.simple_identity_Sage;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'actdcsvc' -> 'traversys', 'Sage ACT Log Processsor Service';
    windows_cmd 'Act\.Framework\.Synchronization\.Service' -> 'traversys', 'Sage ACT Framework Sync Service';
    windows_cmd 'act\.scheduler' -> 'traversys', 'Sage ACT Scheduler';
end identify;

identify Squid 1.0
  tags inference.simple_identity_Squid;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'ncsa_auth' -> 'traversys', 'Squid Web Proxy Authentication Helper';
    unix_cmd 'pam_auth' -> 'traversys', 'Squid Web Proxy PAM Authentication Helper';
    unix_cmd 'squid' -> 'traversys', 'Squid Squid Proxy Server';
    unix_cmd 'unlinkd' -> 'traversys', 'Squid Web Proxy';
end identify;

identify SunGard 1.0
  tags inference.simple_identity_SunGard;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'banner' -> 'traversys', 'SunGard SCT Banner';
end identify;

identify Sun_Microsystems 1.0
  tags inference.simple_identity_Sun_Microsystems;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'cmdtool' -> 'traversys', 'Sun Microsystems OpenWindows Enhanced Terminal Window';
    unix_cmd 'jconsole' -> 'traversys', 'Sun Microsystems Java Monitoring and Management Console';
    unix_cmd 'se\.sparcv9' -> 'traversys', 'Sun Microsystems Solaris Net Monitor SE Toolkit';
end identify;

identify Tibco 1.0
  tags inference.simple_identity_Tibco;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'dbagent' -> 'traversys', 'Tibco Mainframe Service Suite Adapter for ActiveDatabase Agent';
end identify;

identify Tideway 1.0
  tags inference.simple_identity_Tideway;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'tw_svc_adslave' -> 'traversys', 'Tideway Foundation AD Slave';
    windows_cmd 'tw_svc_wgslave' -> 'traversys', 'Tideway Foundation WG Slave';
end identify;

identify Tordex 1.0
  tags inference.simple_identity_Tordex;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'adcstart' -> 'traversys', 'Tordex Truesoft Launch Bar';
end identify;

identify Unix 1.1
  tags inference.simple_identity_Unix;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'ypcat' -> 'traversys', 'Unix NIS Utility (Yellow Pages) Cat';
    unix_cmd 'ypldapd' -> 'traversys', 'Unix NIS Utility (Yellow Pages) LDAPD';
    unix_cmd 'ypmatch' -> 'traversys', 'Unix NIS Utility (Yellow Pages) Match';
    unix_cmd 'yppasswd' -> 'traversys', 'Unix NIS Utility (Yellow Pages) Passwd';
    unix_cmd 'ypset' -> 'traversys', 'Unix NIS Utility (Yellow Pages) Set';
    unix_cmd 'ypwhich' -> 'traversys', 'Unix NIS Utility (Yellow Pages) Which';

end identify;

identify US_Robotics 1.0
  tags inference.simple_identity_US_Robotics;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd '3cshtdwn' -> 'traversys', 'US Robotics Modem Driver';
end identify;

identify ValiCert 1.0
  tags inference.simple_identity_ValiCert;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'agentd' -> 'traversys', 'ValiCert SecureTransport Agent';
end identify;

identify VanDyke 1.0
  tags inference.simple_identity_VanDyke;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'VShell' -> 'traversys', 'VanDyke Vshell';
end identify;

identify Verity 1.0
  tags inference.simple_identity_Verity;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'k2admin' -> 'traversys', 'Verity K2 Toolkit Admin Process (Macromedia Coldfusion Add-on)';
    unix_cmd 'k2broker' -> 'traversys', 'Verity K2 Toolkit Search Request Bro';
    unix_cmd 'k2index' -> 'traversys', 'Verity K2 Toolkit Text Indexing Service';
    unix_cmd 'k2server' -> 'traversys', 'Verity K2 Toolkit K2 Server';
    unix_cmd 'k2spider_srv' -> 'traversys', 'Verity K2 Toolkit Network Search Service';
    unix_cmd 'k2ticket' -> 'traversys', 'Verity K2 Toolkit K2 Ticket Server';
    windows_cmd 'k2admin' -> 'traversys', 'Verity K2 Toolkit Admin Process (Macromedia Coldfusion Add-on)';
    windows_cmd 'k2broker' -> 'traversys', 'Verity K2 Toolkit Search Request Bro';
    windows_cmd 'k2index' -> 'traversys', 'Verity K2 Toolkit Text Indexing Service';
    windows_cmd 'k2server' -> 'traversys', 'Verity K2 Toolkit K2 Server';
end identify;

identify VersaMap 1.0
  tags inference.simple_identity_VersaMap;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'VMap' -> 'traversys', 'VersaMap';
end identify;

identify Versant 1.0
  tags inference.simple_identity_Versant;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'versantd' -> 'traversys', 'Versant ODBMS';
end identify;

identify Visual_Mining 1.0
  tags inference.simple_identity_Visual_Mining;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'ESStart' -> 'traversys', 'Visual Mining ChartWorksR Server';
end identify;

identify VMware 1.0
  tags inference.simple_identity_VMware;
  DiscoveredProcess cmd -> set_by, simple_identity;

    windows_cmd 'VMwareUser' -> 'traversys', 'VMware Tools';
end identify;

identify WebMedia 1.0
  tags inference.simple_identity_WebMedia;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'publish' -> 'traversys', 'WebMedia Web Media Publisher';
end identify;

identify WebTrends 1.0
  tags inference.simple_identity_WebTrends;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'geoserver' -> 'traversys', 'WebTrends Geotrends Server';
    windows_cmd 'uist' -> 'traversys', 'WebTrends User Interface';
    windows_cmd 'wtsysmon' -> 'traversys', 'WebTrends System Monitor';
    windows_cmd 'WTTomcatService' -> 'traversys', 'WebTrends Tomcat';
    windows_cmd 'wtxd' -> 'traversys', 'WebTrends Scheduler Agent';
end identify;

identify Witness_Systems 1.0
  tags inference.simple_identity_Witness_Systems;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'ADInterface' -> 'traversys', 'Witness Systems eQuality Balance Avaya Dialer Adapter';
    windows_cmd 'ALARM' -> 'traversys', 'Witness Systems Alarm';
end identify;

identify Yahoo 1.0
  tags inference.simple_identity_Yahoo;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'YahooMessenger' -> 'traversys', 'Yahoo Instant Messenger Service';
end identify;

identify VMware 1.0
  tags inference.simple_identity_VMware;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'vm-support' -> 'traversys', 'VMware Debugging Tool';
  end identify;

identify Linux 1.0
  tags Linux;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'CheopsAgent' -> 'traversys', 'Linux Cheops-NG Network Monitor Agent';
    unix_cmd 'ftp' -> 'traversys', 'Linux Internet Protocol Suite File Transfer Protocol';
    unix_cmd 'rpc\.ttdbserver' -> 'traversys', 'Linux RPC ToolTalk Database Server';
    unix_cmd 'ssh-agent2' -> 'traversys', 'Linux OS Tool ssh-agent';
    unix_cmd 'xdm' -> 'traversys', 'Linux X Display Manager';
end identify;

identify Linux 1.0
  tags Linux;
  DiscoveredProcess cmd, args -> set_by, simple_identity;
    unix_cmd '^\[\S+', regex '(?i)^<defunct>\]$' -> 'traversys', 'traversys', 'Linux Defunct Process';
end identify;

identify BP_Software 1.0
  tags BP_Software;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'snmpwalk' -> 'traversys', 'BP Software SNMP Walk Utility';
end identify;

identify Nagios 1.0
  tags Nagios;
  DiscoveredProcess cmd, args -> set_by, simple_identity;
    unix_cmd '\d+', regex '(?i)^/apps/nagios/bin/nrpe' -> 'traversys', 'traversys', 'Nagios Remote Plugin Executor';
end identify;

identify Sun_Microsystems 1.0
  tags Sun_Microsystems;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'webservd-wdog\.e' -> 'traversys', 'Sun Microsystems ONE / Java System Webserver WatchDog';
end identify;

identify Microsoft 1.0
  tags Microsoft;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd '_IISCHAgent' -> 'traversys', 'Microsoft IIS Debug Tools Crash and Hang Monitoring Agent';
end identify;

identify Pervasive 1.0
  tags Pervasive;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'W32MKDE' -> 'traversys', 'Pervasive Btrieve Database MicroKernel Database Engine';
    windows_cmd 'w3sqlmgr' -> 'traversys', 'Pervasive PSQL Pervasive SQL Server (Relational)';
end identify;

identify Platform 1.0
  tags Platform;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'bqueues' -> 'traversys', 'Platform LSF Batch Queues Information Manual Command';
end identify;

identify Progress 1.0
  tags Progress;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd '_progres' -> 'traversys', 'Progress OpenEdge DB Client Dataserver Executable';
    unix_cmd '_prohlc' -> 'traversys', 'Progress OpenEdge Database';
    unix_cmd '_sqlsrv2' -> 'traversys', 'Progress OpenEdge DB SQL Client';
    windows_cmd '_sqlsrv2' -> 'traversys', 'Progress OpenEdge DB SQL Client';
    windows_cmd 'AdmSrvc' -> 'traversys', 'Progress AdminService for Progress Database';
end identify;


identify Quest 1.1
  tags Quest;
  DiscoveredProcess cmd -> set_by, simple_identity;
    regex '(?i)\besm_log_restart' -> 'traversys', 'Quest Foglight LogFilter restart';
    regex '(?i)\bfgaOraAgent' -> 'traversys', 'Quest Foglight fgaOra Agent';
    regex '(?i)\bFGLServerMonitor@' -> 'traversys', 'Quest Foglight Server Monitor Agent';
    regex '(?i)\bFileSystem@' -> 'traversys', 'Quest Foglight Filesystem Agent';
    regex '(?i)\bfoglight.*\bApacheSvr' -> 'traversys', 'Quest Foglight Apache Agent';
    regex '(?i)\bfoglight.*\bDB2_db2' -> 'traversys', 'Quest Foglight DB2 Agent';
    regex '(?i)\bfoglight.*\bDB2_Website' -> 'traversys', 'Quest Foglight DB2 Agent';
    regex '(?i)\bfoglight.*\bDB2Monitor' -> 'traversys', 'Quest Foglight DB2 Monitor Agent';
    regex '(?i)\bfoglight.*\bLogFilter' -> 'traversys', 'Quest Foglight LogFilter';
    regex '(?i)\bfoglight.*\bNetMonitor@' -> 'traversys', 'Quest Foglight NetMonitor';
    regex '(?i)\bfoglight.*\bNT_System@' -> 'traversys', 'Quest Foglight NT System Agent';
    regex '(?i)\bfoglight.*\bOracleHost@' -> 'traversys', 'Quest Foglight OracleHost Agent';
    regex '(?i)\bfoglight.*\bSQLServer' -> 'traversys', 'Quest Foglight SQLServer Agent';
    unix_cmd 'AppMonitor' -> 'traversys', 'Quest Foglight Foundation System Application Monitoring Agent';
    unix_cmd 'dalsrv' -> 'traversys', 'Quest Foglight dalsrv';
    unix_cmd 'dbquery' -> 'traversys', 'Quest Foglight DB Query';
    unix_cmd 'dm' -> 'traversys', 'Quest Foglight dm';
    unix_cmd 'FCFM_LogFilter' -> 'traversys', 'Quest Foglight LogFilter';
    unix_cmd 'fglam' -> 'traversys', 'Quest Foglight Agent Manager';
    unix_cmd 'fglDBServer' -> 'traversys', 'Quest Foglight fgldb server';
    unix_cmd 'fglschd' -> 'traversys', 'Quest Foglight fglschd';
    unix_cmd 'fglslpd' -> 'traversys', 'Quest Foglight fglslp';
    unix_cmd 'ne' -> 'traversys', 'Quest Foglight ne';
    windows_cmd 'AppMonitor' -> 'traversys', 'Quest Foglight Foundation System Application Monitoring Agent';
    windows_cmd 'dalsrv' -> 'traversys', 'Quest Foglight dalsrv';
    windows_cmd 'dbquery' -> 'traversys', 'Quest Foglight DB Query';
    windows_cmd 'dm' -> 'traversys', 'Quest Foglight dm';
    windows_cmd 'fgaSQLServer' -> 'traversys', 'Quest Foglight SQL';
    windows_cmd 'fglam' -> 'traversys', 'Quest Foglight Agent Manager';
    windows_cmd 'fglschd' -> 'traversys', 'Quest Foglight fglschd';
    windows_cmd 'fglslpd' -> 'traversys', 'Quest Foglight fglslp';
    windows_cmd 'ne' -> 'traversys', 'Quest Foglight ne';
    windows_cmd 'nss' -> 'traversys', 'Quest Foglight nss';
    windows_cmd 'rapsd' -> 'traversys', 'Quest Foglight rapsd';
    windows_cmd 'rapsService' -> 'traversys', 'Quest Foglight rapsService';
    windows_cmd 'serverd' -> 'traversys', 'Quest Foglight Server';
end identify;

identify RJS 1.0
  tags RJS;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd '400Convert' -> 'traversys', 'RJS RTF Report Converter';
end identify;

identify RSA 1.0
  tags RSA;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd '_aceserver_be' -> 'traversys', 'RSA SecureID Server ACE Authentication Engine Backend';
    unix_cmd '_aceserver_fe' -> 'traversys', 'RSA SecureID Server ACE Authentication Engine Frontend';
    unix_cmd 'aceapi_rpc_server' -> 'traversys', 'RSA SecureID Server ACE WebAgent';
    unix_cmd 'aceService' -> 'traversys', 'RSA SecureID Server ACE Authentication Engine';
    unix_cmd 'acesyncd' -> 'traversys', 'RSA SecureID Server ACE Background Comms';
    windows_cmd 'acesrvc_be' -> 'traversys', 'RSA SecureID Server ACE Authentication Engine Backend';
    windows_cmd 'acesrvc' -> 'traversys', 'RSA SecureID Server ACE Authentication Engine';
    windows_cmd 'apidemon' -> 'traversys', 'RSA SecureID Server Authentication Manager';
    windows_cmd 'brksrv' -> 'traversys', 'RSA SecureID Authentication Manager Broker Service';
    windows_cmd 'da_svc' -> 'traversys', 'RSA SecureID Authentication Manager Authentication Agent';
    windows_cmd 'jsed' -> 'traversys', 'RSA SecureID Authentication Manager Job Executor';
    windows_cmd 'logmaintthd' -> 'traversys', 'RSA SecureID Authentication Manager Log Maintenance';
    windows_cmd 'radius' -> 'traversys', 'RSA SecureID Authentication Manager Radius Service';
    windows_cmd 'sdadmind' -> 'traversys', 'RSA SecureID Authentication Manager ACE Remote Administration Authentication';
    windows_cmd 'sdcommd_session' -> 'traversys', 'RSA SecureID Authentication Manager ACE Quick Admin';
    windows_cmd 'sdcommd' -> 'traversys', 'RSA SecureID Authentication Manager ACE Quick Admin';
    windows_cmd 'syncsrvc' -> 'traversys', 'RSA SecureID Authentication Manager Replication';
end identify;

identify Raxco 1.0
  tags Raxco;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'pdagent' -> 'traversys', 'Raxco PerfectDisk PDAgent Module';
end identify;

identify Red_Hat 1.0
  tags RedHat;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'dlqhandler' -> 'traversys', 'Red Hat Jboss Dead Letter Queue Handler';
    unix_cmd 'kmpathd/\d+' -> 'traversys', 'Red Hat Kernel Thread';
    unix_cmd 'python' -> 'traversys', 'Red Hat Network Applet';
    windows_cmd 'JBossService' -> 'traversys', 'Red Hat JBoss Windows Java Service';
end identify;

identify RepliWeb 1.0
  tags RepliWeb;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'active_server' -> 'traversys', 'RepliWeb Active Server Directory Synchronization';
    windows_cmd 'archive_server' -> 'traversys', 'RepliWeb Archive Server Directory Synchronization';
    windows_cmd 'fcservice' -> 'traversys', 'RepliWeb FastCopy Service Directory Synchronization';
    windows_cmd 'gastart' -> 'traversys', 'RepliWeb FastCopy Service Directory Synchronization';
    windows_cmd 'repliweb_scheduler_service' -> 'traversys', 'RepliWeb Scheduler Service Directory Synchronization';
    windows_cmd 'repliweb_server' -> 'traversys', 'RepliWeb RDS Server Directory Synchronization';
    windows_cmd 'sched_api_server' -> 'traversys', 'RepliWeb Scheduler Service Directory Synchronization';
    windows_cmd 'submit_server' -> 'traversys', 'RepliWeb Scheduler Service Directory Synchronization';
end identify;

identify Reuters 1.0
  tags Reuters;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'rxmssync' -> 'traversys', 'Reuters XMS Sync';
end identify;

identify Sage 1.0
  tags Sage;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'actdcsvc' -> 'traversys', 'Sage ACT Log Processsor Service';
    windows_cmd 'Act\.Framework\.Synchronization\.Service' -> 'traversys', 'Sage ACT Framework Sync Service';
    windows_cmd 'act\.scheduler' -> 'traversys', 'Sage ACT Scheduler';
end identify;

identify Squid 1.0
  tags Squid;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'ncsa_auth' -> 'traversys', 'Squid Web Proxy Authentication Helper';
    unix_cmd 'pam_auth' -> 'traversys', 'Squid Web Proxy PAM Authentication Helper';
    unix_cmd 'squid' -> 'traversys', 'Squid Squid Proxy Server';
    unix_cmd 'unlinkd' -> 'traversys', 'Squid Web Proxy';
end identify;


identify Sterling 1.3
    tags Sterling;
    DiscoveredProcess cmd -> set_by, simple_identity;
        unix_cmd 'cdpmgr' -> 'traversys', 'Sterling ConnectDirect Manager';
        unix_cmd 'ndmcmgr' -> 'traversys', 'Sterling ConnectDirect NDM';
end identify;


identify SunGard 1.0
  tags SunGard;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'banner' -> 'traversys', 'SunGard SCT Banner';
end identify;


identify Sun_Microsystems 1.0
  tags Sun_Microsystems;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'cmdtool' -> 'traversys', 'Sun Microsystems OpenWindows Enhanced Terminal Window';
    unix_cmd 'jconsole' -> 'traversys', 'Sun Microsystems Java Monitoring and Management Console';
    unix_cmd 'se\.sparcv9' -> 'traversys', 'Sun Microsystems Solaris Net Monitor SE Toolkit';
end identify;


identify Sybase 1.0
    tags Sybase;
    DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'asiqsrv12' -> 'traversys', 'Sybase Adaptive ServerIQ';
    unix_cmd 'backupserver' -> 'traversys', 'Sybase Backup Server';
    unix_cmd 'bcp' -> 'traversys', 'Sybase Bulk Copy';
    unix_cmd 'dbsrv7' -> 'traversys', 'Sybase Adaptive Server Anywhere';
    unix_cmd 'dbsrv9' -> 'traversys', 'Sybase Adaptive Server Anywhere';
    unix_cmd 'direct' -> 'traversys', 'Sybase DirectConnect Access Service';
    unix_cmd 'sybload' -> 'traversys', 'Sybase Product Distribution Program';
    windows_cmd '(?i)^DBENG' -> 'traversys', 'Sybase SQL Anywhere Personal DB Server Engine';
    windows_cmd 'Dbsrv' -> 'traversys', 'Sybase SQL Anywhere Network Server';
    windows_cmd 'Direct' -> 'traversys', 'Sybase DirectConnect Access Service';
    windows_cmd 'directc' -> 'traversys', 'Sybase DirectConnect Access Service';
end identify;

identify Tibco 1.0
  tags Tibco;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'dbagent' -> 'traversys', 'Tibco Mainframe Service Suite Adapter for ActiveDatabase Agent';
end identify;

identify Tideway 1.0
  tags Tideway;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'tw_svc_adslave' -> 'traversys', 'Tideway Foundation AD Slave';
    windows_cmd 'tw_svc_wgslave' -> 'traversys', 'Tideway Foundation WG Slave';
end identify;

identify Tordex 1.0
  tags Tordex;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'adcstart' -> 'traversys', 'Tordex Truesoft Launch Bar';
end identify;

identify US_Robotics 1.0
  tags US_Robotics;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd '3cshtdwn' -> 'traversys', 'US Robotics Modem Driver';
end identify;

identify Unix 1.0
  tags Unix;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'ypcat' -> 'traversys', 'Unix NIS Utility (Yellow Pages) Cat';
    unix_cmd 'ypldapd' -> 'traversys', 'Unix NIS Utility (Yellow Pages) LDAPD';
    unix_cmd 'ypmatch' -> 'traversys', 'Unix NIS Utility (Yellow Pages) Match';
    unix_cmd 'yppasswd' -> 'traversys', 'Unix NIS Utility (Yellow Pages) Passwd';
    unix_cmd 'ypset' -> 'traversys', 'Unix NIS Utility (Yellow Pages) Set';
    unix_cmd 'ypwhich' -> 'traversys', 'Unix NIS Utility (Yellow Pages) Which';
    unix_cmd 'ypxfr' -> 'traversys', 'Unix NIS Utility (Yellow Pages) Transfer';
end identify;

identify VMware 1.1
  tags VMware;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'VMwareUser' -> 'traversys', 'VMware Tools';
end identify;

identify ValiCert 1.0
  tags ValiCert;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'agentd' -> 'traversys', 'ValiCert SecureTransport Agent';
end identify;

identify VanDyke 1.0
  tags VanDyke;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'VShell' -> 'traversys', 'VanDyke Vshell';
end identify;

identify Verity 1.0
  tags Verity;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'k2admin' -> 'traversys', 'Verity K2 Toolkit Admin Process (Macromedia Coldfusion Add-on)';
    unix_cmd 'k2broker' -> 'traversys', 'Verity K2 Toolkit Search Request Bro';
    unix_cmd 'k2index' -> 'traversys', 'Verity K2 Toolkit Text Indexing Service';
    unix_cmd 'k2server' -> 'traversys', 'Verity K2 Toolkit K2 Server';
    unix_cmd 'k2spider_srv' -> 'traversys', 'Verity K2 Toolkit Network Search Service';
    unix_cmd 'k2ticket' -> 'traversys', 'Verity K2 Toolkit K2 Ticket Server';
    windows_cmd 'k2admin' -> 'traversys', 'Verity K2 Toolkit Admin Process (Macromedia Coldfusion Add-on)';
    windows_cmd 'k2broker' -> 'traversys', 'Verity K2 Toolkit Search Request Bro';
    windows_cmd 'k2index' -> 'traversys', 'Verity K2 Toolkit Text Indexing Service';
    windows_cmd 'k2server' -> 'traversys', 'Verity K2 Toolkit K2 Server';
end identify;

identify VersaMap 1.0
  tags VersaMap;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'VMap' -> 'traversys', 'VersaMap';
end identify;

identify Versant 1.0
  tags Versant;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'versantd' -> 'traversys', 'Versant ODBMS';
end identify;

identify Visual_Mining 1.0
  tags Visual_Mining;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'ESStart' -> 'traversys', 'Visual Mining ChartWorksR Server';
end identify;

identify WebMedia 1.0
  tags WebMedia;
  DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'publish' -> 'traversys', 'WebMedia Web Media Publisher';
end identify;

identify WebTrends 1.0
  tags WebTrends;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'geoserver' -> 'traversys', 'WebTrends Geotrends Server';
    windows_cmd 'uist' -> 'traversys', 'WebTrends User Interface';
    windows_cmd 'wtsysmon' -> 'traversys', 'WebTrends System Monitor';
    windows_cmd 'WTTomcatService' -> 'traversys', 'WebTrends Tomcat';
    windows_cmd 'wtxd' -> 'traversys', 'WebTrends Scheduler Agent';
end identify;

identify Witness_Systems 1.0
  tags Witness_Systems;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'ADInterface' -> 'traversys', 'Witness Systems eQuality Balance Avaya Dialer Adapter';
    windows_cmd 'ALARM' -> 'traversys', 'Witness Systems Alarm';
end identify;

identify Yahoo 1.0
  tags Yahoo;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'YahooMessenger' -> 'traversys', 'Yahoo Instant Messenger Service';
end identify;

// The MIT License (MIT)

// Copyright Wes Moskal-Fitzpatrick 2013

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