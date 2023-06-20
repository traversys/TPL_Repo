tpl 1.20 module traversys_Congenica;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Congenica';
end metadata;

from traversys_defs import traversys 1.0;

definitions PostgreSQL 1.0
    """Queries for Postgres DB"""

    type := sql_discovery;
    group := "PostgreSQL RDBMS";

    define getBilling
        """
            This SQL query is calling a stored function named `get_customer_billing_patient_counts` that exists in the `core` schema.
            get_customer_billing_patient_counts`: This is the name of the function being called.
        """
       query := "SELECT * FROM core.get_customer_billing_patient_counts(array['']);";
    end define;

end definitions;

configuration defaults 1.0
    """Default Application Config"""

    "install_dir" data_dir := "/data/congenica";

end configuration;

pattern Congica_SI_Control_Plane 1.0
    '''
        Pattern for etcd.
        
        Change History:
        2023-06-16 | 1.0 | WMF | Created.
        
    '''

    overview
        tags custom, traversys, congenica;
    end overview;

    constants
        type := 'Congenica Kube Master';
    end constants;

    triggers
        on p := DiscoveredProcess where cmd matches unix_cmd 'etcd';
    end triggers;

    body

        h:= model.host(p);
        n:= "%type% on %h.name%";
        i:= void;

        // Get container details
        pp := discovery.parent(p);
        if pp and pp.cmd matches "containerd-shim" then
            if pp.args then
                i:= regex.extract(pp.args, regex "(?i)^(\S+])\b", raw '\1');
            end if;
        end if;

        // Get config file
        conf_path := regex.extract(p.args, regex "--config-file(?:=|\s+)*(\S+)", raw '\1');

        if conf_path then
            conf_file:= discovery.fileGet(h, conf_path);
            if conf_file and conf_file.content then
                i:= regex.extract(conf_file.content, regex "(?m)^\s*name:\s*(.+)", raw '\1');
            end if;
        elif p.args then
            i:= regex.extract(p.args, regex "\-\-name=(\S+)", raw '\1');
        end if;

        // Get version info
        get_version := discovery.runCommand(h,'%p.cmd% -version');
        if get_version and get_version.result then
            v := regex.extract(get_version.result, regex '(?i)etcd\s+Version\:\s(\d+(?:\.\d+)*)', raw '\1');
            pv:= regex.extract(v, regex '(\d+(?:\.\d+)?)', raw '\1', no_match := v);
            n := "%type% %pv% on %h.name%";
        else
            v, pv, r, b, d, di:= traversys.getPackages(h, [ regex '^etcd$' ]);
            n := "%type% %pv% on %h.name%";
        end if;

        k := "%type%/%h.key%";

        si := model.SoftwareInstance(
                                    name := n,
                                    type:= type,
                                    key  := k,
                                    version:= v,
                                    product_version := pv,
                                    instance:= i
                                    );
        log.info("Created SI %si.name%");

        // Create Cluster
        communicating_sis:= search(in si processwith communicatingSIs where type = "Congenica Kube Master");
        if size(communicating_sis) > 0 then
            kubectl:= model.SoftwareCluster(name:= "Congenica Infrastructure",
                                            type:= "Kube Control Plane");
            model.addContainment(kubectl,si);
            model.setRemovalGroup(kubectl);
        end if;

    end body;

end pattern;


pattern Congenica_SI_Containers 1.0
    '''

        Pattern for mapping out simple containers architecture.
        
        Change History:
        2023-06-16 | 1.0 | WMF | Created.

    '''

    overview
        tags custom, traversys, congenica;
    end overview;

    constants
        docker_type:= "Docker";
        kube_type:= "Kubernetes";
    end constants;

    triggers
        on p := DiscoveredProcess where cmd matches regex '(?i)\bdockerd?$';
    end triggers;

    body

        h:= model.host(p);
        n:= "%docker_type% on %h.name%";
        si_type:= docker_type;
        container_type:= kube_type;
        install_dir:= defaults.data_dir;

        // Bastion Node Identification
        if p.args matches regex "\bcontainerd\b" then
            si_type:= "Bastion Node";
            n:= "%si_type% on %h.name%";
            // Check for install dir
            //pwd:= discovery.runCommand(h, "echo $PWD");
            customer:= discovery.runCommand(h, "echo $CUSTOMER");
            release:= discovery.runCommand(h, "echo $RELEASE");
            assembly:= discovery.runCommand(h, "echo $ASSEMBLY");
            pipe_release:= discovery.runCommand(h, "echo $PIPELINE_RELEASE");
            web_release:= discovery.runCommand(h, "echo $ASSEMBLY");
            cadd_release:= discovery.runCommand(h, "echo $ASSEMBLY");
            bundle_release:= discovery.runCommand(h, "echo $BUNDLE_RELEASE");
            ref_data_root:= discovery.runCommand(h, "echo $REFDATAROOT");
            //if pwd and pwd.result then
            //    install_dir:= pwd.result;
            //end if;
            root_dir:= discovery.listDirectory(h, install_dir);
            if size(install_dir) > 0 then
                kubespray_dir:= install_dir+"/congenica-deployments/kubespray-deployments";
                reference_dir:= install_dir+"/reference/pipeline/current";
                ref_dir:= discovery.listDirectory(h, reference_dir);
                ansible_f:= discovery.runCommand(h, "cat %install_dir%/ansible.log | grep 'ansible.cfg'");
                if ansible_f and ansible_f.result then
                    ansible_cfg:= regex.extract(ansible_f.result, regex "Using\s(\/\S+)", raw "\1");
                    kubespray_dir:= regex.extract(ansible_f.result, regex "(\/\S+\/kubespray-(\d+\.?)+)", raw "\1");
                    if ansible_cfg then
                        ansible_conf:= discovery.fileGet(h, ansible_cfg);
                    end if;
                    if kubespray_dir then
                        ks_dir:= discovery.listDirectory(h, kubespray_dir);
                        cluster_yml:= discovery.fileGet(h, kubespray_dir+"/cluster.yml");
                        dockerfile:= discovery.fileGet(h, kubespray_dir+"/Dockerfile");
                        kreqs_txt:= discovery.fileGet(h, kubespray_dir+"/requirements.txt");
                        // Check for inventory
                        inventory_dir:= kubespray_dir+"/inventory";
                        if customer then
                            inventory_ini:= discovery.fileGet(h, inventory_dir+"/"+text.strip(text.strip(customer.result, "\n"))+"/inventory.ini");
                        else
                            for file in ks_dir do
                                if file.file_type = "Directory" then
                                    if file.name in [ "sample", "local", "vmware-dev", "vmware-innovation" ] then
                                        //skip
                                        continue;
                                    else
                                        inventory_ini:= discovery.fileGet(h, inventory_dir+file.name+"/inventory.ini");
                                    end if;
                                end if;
                            end for;
                        end if;
                    end if;
                    values_yml:= discovery.fileGet(h, install_dir+"/congenica-deployments/installer_v1/values.yaml");   
                end if;
            end if;

            // Kubernetes info
            k_version:= discovery.runCommand(h, "/usr/local/bin/kubectl version");
            k_nodes:= discovery.runCommand(h, "/usr/local/bin/kubectl get nodes");
            k_labels:= discovery.runCommand(h, "/usr/local/bin/kubectl get nodes --show-labels");
            k_pods:= discovery.runCommand(h, "/usr/local/bin/kubectl -n kube-system get pods");

            // Helm info
            helm_ls:= discovery.runCommand(h, "helm ls -A -a");
            helm_v:= discovery.runCommand(h, "helm version");
            helm_n:= discovery.runCommand(h, "helm -n kube-system ls");

            // Docker info
            images:= discovery.runCommand(h, "docker images");
            


        end if;

        v_cmd:= discovery.runCommand(h, "docker version");
        if v_cmd and v_cmd.result then
            v:= regex.extract(v_cmd.result, regex '(?m)^Server:?[\S\s]*?Version:\s*(\d+(?:\.\d+)*)', raw '\1');
            if not v then
                v:= regex.extract(v_cmd.result, regex '(?im)\s*Server version:\s*(\d+(?:\.\d+)*)', raw '\1');
            end if;
            pv:= regex.extract(v, regex '(\d+(?:\.\d+)?)', raw '\1');
            n := "%docker_type% %pv% on %h.name%";
        else
            v, pv, r, b, d, di:= traversys.getPackages(h, [ regex '^docker(?:[-\.](io|engine|ce|ee))?$' ]);
            n := "%si_type% %pv% on %h.name%";
        end if;

        k := "%docker_type%/%h.key%";

        si := model.SoftwareInstance(name := n,
                                     type := si_type,
                                     key  := k,
                                     version := v,
                                     product_version := pv);
        log.info("Created SI %si.name%");

        // Get list of images
        images_cmd := discovery.runCommand(h, 'docker images --no-trunc --format "{{.Repository}} : {{.Tag}} : {{.Digest}} : {{.ID}} : {{.Size}}" 2>/dev/null' );
        if images_cmd and images_cmd.result then
            images:= images_cmd.result;
        end if;

        // Get Containers
        docker_ps_cmd:= discovery.runCommand(h, "docker inspect --format='{{.Id}} : {{.Image}} : {{.Name}}' $(docker ps -q) 2>/dev/null");
        if docker_ps_cmd and docker_ps_cmd.result then
            docker_ps:= docker_ps_cmd.result;
        
            if docker_ps then

                proc_d:= [];

                procs := search(in si traverse InferredElement:Inference:Primary:DiscoveredProcess);
                if size(procs) >0 then
                    all_procs := discovery.allProcesses(procs[0]);            
                    pd := discovery.descendents(procs[0]);
                    containerd := search(in all_procs where cmd matches regex '(^|/)containerd$');
                    if size(containerd) >0 then
                        containerd_d := discovery.descendents(containerd[0]);
                        for c_d in containerd_d do
                            list.append(proc_d, c_d);
                        end for;
                    end if;
                end if;

                containers:= [];

                for l in text.split(docker_ps, '\n') do

                    // Skip blanks and other irrelevant lines
                    if not l then
                        continue;
                    end if;
                    values := text.split(l, " : ");
                    if size(values) < 3 then
                        continue;
                    end if;

                    id:= text.strip(values[0]);
                    c_image:= text.strip(values[1]);
                    c_name:= text.strip(values[2]);
                    c_name:= text.leftStrip(c_name, "/");
                    
                    ck := "%kube_type%/%si.key%";

                    ct := model.SoftwareInstance(
                                                key:= ck,
                                                name:= "%kube_type% %c_name% on %h.name%",
                                                type:= kube_type,
                                                id:= id)
                                                ;
                    model.addDisplayAttribute(ct, "id");
                    list.append(containers, ct);

                    for proc in proc_d do
                        if (proc.cmd matches regex 'containerd-shim(-current)?$' or proc.cmd matches unix_cmd 'lxc-start' ) and id in proc.args then
                            inference.associate(ct, proc);
                            c := discovery.descendents(proc);
                            inference.associate(ct, c);
                            sis := search(in c traverse Primary:Inference:InferredElement:SoftwareInstance);
                            rels := model.rel.SoftwareContainment(SoftwareContainer := ct,ContainedSoftware := sis);
                        end if;
                    end for;

                end for;

                model.rel.HostedSoftware(Host:=h,RunningSoftware:=containers);
                model.rel.Management(Manager:=containers,ManagedElement:=si);

            end if;

        end if;

    end body;

end pattern;


pattern Congenica_SI_Pipeline 1.0
    """
    Models the Pipeline Node.
    
    Change History:
    2023-06-16 | 1.0 | WF | Created.
    
    """
    metadata
        publishers := 'Congenica';
        products   := 'Congenica';
        urls       := 'https://www.congenica.com/';
        categories := 'Genetic Sequencing & Analysis';
    end metadata;

    overview
        tags traversys, custom, congenica, pipeline;
    end overview;
    
    constants
        type := "Congenica Tertiary Analysis";
    end constants;
    
    triggers
        on p := DiscoveredProcess where cmd matches unix_cmd "kube-controllers";

    end triggers;
    
    body

        h := related.host(p);;

        n := "%type% on %h.name%";
        k := text.hash("%type%/%h.key%");

        si:= model.SoftwareInstance(
                                    key             := k,
                                    type            := type,
                                    name            := n,
                                    _traversys      := true
                                    );
        
    end body;

end pattern;


pattern Congenica_SI_NFS 1.0
    """
    Models the NFS server.
    
    Change History:
    2023-06-14 | 1.0 | WF | Created.
    
    """
    metadata
        publishers := 'Congenica';
        products   := 'Congenica';
        urls       := 'https://www.congenica.com/';
        categories := 'Genetic Sequencing & Analysis';
    end metadata;

    overview
        tags traversys, custom, congenica, nfs;
    end overview;
    
    constants
        type := "NFS Server";
    end constants;
    
    triggers
        on p := DiscoveredProcess where cmd matches unix_cmd "nfsd";

    end triggers;
    
    body

        h := related.host(p);;

        n := "%type% on %h.name%";
        k := text.hash("%type%/%h.key%");

        v, pv, r, b, d, di:= traversys.getPackages(h, [ "nfs-kernel-server" ]);
        
        si:= model.SoftwareInstance(
                                    key             := k,
                                    type            := type,
                                    name            := n,
                                    version         := v,
                                    product_version := pv,
                                    _traversys      := true
                                    );
        
    end body;

end pattern;


pattern Congenica_BAI 1.0
    """
    Models an instance of the Congenica Application.

    Triggers on PostgreSQL runnning sapientia DB.
    
    Change History:
    2023-06-13 | 1.0 | WF | Created.
    
    """
    metadata
        publishers := 'Congenica';
        products   := 'Congenica';
        urls       := 'https://www.congenica.com/';
        categories := 'Genetic Sequencing & Analysis';
    end metadata;

    overview
        tags traversys, custom, congenica;
    end overview;
    
    constants
        type := "Congenica";
        db_instance := "sapientia";
    end constants;
    
    triggers
        on si := SoftwareInstance created, confirmed where type = "PostgreSQL Database Server";
    end triggers;
    
    body

        databases := search(in si traverse ElementWithDetail:Detail:Detail:Database where instance = %db_instance%);
        if size(databases) = 0 then
            // Not a Congenica DB
            stop;
        end if;

        host:= related.host(si);

        // Get Billing info
        if si.port then
            q := PostgreSQL.getBilling(endpoint:= host, database:= db_instance, port:= si.port);
        end if;

        // Congenica Specific Configuration
        conf:= discovery.fileGet(host, "/etc/postgresql/11/main/postgresql.conf");
        if conf and conf.content then
            listen_addresses:= regex.extract(conf.content, regex "\s*[^\#]\s*listen_addresses\s*=\s*['\"](.*?)['\"]", raw "\1");
            si.listen_addresses:= listen_addresses;
            max_connections:= regex.extract(conf.content, regex "\s*[^\#]\s*max_connections\s*=\s*(\d+)", raw "\1");
            si.max_connections:= max_connections;
            shared_buffers := regex.extract(conf.content, regex "\s*[^\#]\s*shared_buffers\s*=\s*(\S+)", raw "\1");
            si.shared_buffers := shared_buffers;
            work_mem := regex.extract(conf.content, regex "\s*[^\#]\s*work_mem\s*=\s*(\S+)", raw "\1");
            si.work_mem := work_mem;
            maintenance_work_mem := regex.extract(conf.content, regex "\s*[^\#]\s*maintenance_work_mem\s*=\s*(\S+)", raw "\1");
            si.maintenance_work_mem := maintenance_work_mem;
            max_stack_depth := regex.extract(conf.content, regex "\s*[^\#]\s*max_stack_depth\s*=\s*(\S+)", raw "\1");
            si.max_stack_depth := max_stack_depth;
            max_wal_size := regex.extract(conf.content, regex "\s*[^\#]\s*max_wal_size\s*=\s*(\S+)", raw "\1");
            si.max_wal_size := max_wal_size;
            min_wal_size := regex.extract(conf.content, regex "\s*[^\#]\s*min_wal_size\s*=\s*(\S+)", raw "\1");
            si.min_wal_size := min_wal_size;
            random_page_cost := regex.extract(conf.content, regex "\s*[^\#]\s*random_page_cost\s*=\s*(\S+)", raw "\1");
            si.random_page_cost := random_page_cost;
            effective_cache := regex.extract(conf.content, regex "\s*[^\#]\s*effective_cache_size\s*=\s*(\S+)", raw "\1");
            si.effective_cache := effective_cache;
            shared_preload := regex.extract(conf.content, regex "\s*[^\#]\s*shared_preload_libraries\s*=\s*(\S+)", raw "\1");
            si.shared_preload := shared_preload;
            max_locks := regex.extract(conf.content, regex "\s*[^\#]\s*max_locks_per_transaction\s*=\s*(\S+)", raw "\1");
            si.max_locks := max_locks;
        end if;

        // Performance Tuning
        sysctl:= discovery.fileGet(host, "/etc/sysctl.conf");
        if sysctl and sysctl.content then
            kernel_sem := regex.extract(sysctl.content, regex "\s*[^\#]\s*kernel.sem\s*=\s*(\S+)\n", raw "\1");
            si.kernel_sem := kernel_sem;
            kernel_shmmni := regex.extract(sysctl.content, regex "\s*[^\#]\s*kernel.shmmni\s*=\s*(\S+)\n", raw "\1");
            si.kernel_shmmni := kernel_shmmni;
            kernel_shmall := regex.extract(sysctl.content, regex "\s*[^\#]\s*kernel.shmall\s*=\s*(\S+)\n", raw "\1");
            si.kernel_shmall := kernel_shmall;
            kernel_shmmax := regex.extract(sysctl.content, regex "\s*[^\#]\s*kernel.shmmax\s*=\s*(\S+)\n", raw "\1");
            si.kernel_shmmax := kernel_shmmax;
            fs_file_max := regex.extract(sysctl.content, regex "\s*[^\#]\s*fs.file-max\s*=\s*(\S+)\n", raw "\1");
            si.fs_file_max := fs_file_max;
            fs_aio_max_nr := regex.extract(sysctl.content, regex "\s*[^\#]\s*fs.aio-max-nr\s*=\s*(\S+)\n", raw "\1");
            si.fs_aio_max_nr := fs_aio_max_nr;
            vm_overcommit_memory := regex.extract(sysctl.content, regex "\s*[^\#]\s*vm.overcommit_memory\s*=\s*(\S+)\n", raw "\1");
            si.vm_overcommit_memory := vm_overcommit_memory;
            vm_overcommit_ratio := regex.extract(sysctl.content, regex "\s*[^\#]\s*vm.overcommit_ratio\s*=\s*(\S+)\n", raw "\1");
            si.vm_overcommit_ratio := vm_overcommit_ratio;
            vm_swappiness := regex.extract(sysctl.content, regex "\s*[^\#]\s*vm.swappiness\s*=\s*(\S+)\n", raw "\1");
            si.vm_swappiness := vm_swappiness;
        end if;

        name     := "%type%";
        key      := text.hash(name);

        bai := model.BusinessApplicationInstance(
                                                    key       := key,
                                                    type      := type,
                                                    name      := name,
                                                    _traversys:= true
                                                  );
        log.info("BAI created: %bai.name%");
        model.addContainment(bai, si);
        //if size(databases) > 0 then
            model.rel.Dependency(Dependant := bai, DependedUpon := databases);
        //end if;

        etc_hosts:= discovery.fileGet(host, "/etc/hosts");
        if etc_hosts and etc_hosts.md5sum then
            bastion:= regex.extract(etc_hosts.content, regex "(\b(\d{1,3}\.?)+\b)\s+bastion\n", raw "\1");
            if bastion <> "" then
                bastion_ip:= search(IPAddress where ip_addr = "%bastion%");
                if size(bastion_ip) > 0 then
                    log.debug("Found bastion IP %bastion%.");
                    bastion_hosts:= search(in bastion_ip traverse IPv4Address:DeviceAddress:DeviceWithAddress:Host);
                    if size(bastion_hosts) > 0 then
                        bastion_host := bastion_hosts[0];
                        log.debug("Bastion Host %bastion_host.name%.");
                        //Associate:Inference:InferredElement:Host
                        //model.rel.Inference(Associate:=bai,Host:=bastion_host);
                        bai.bastion := "%bastion_host.name% %bastion%";
                        model.addDisplayAttribute(bai, [ "bastion" ]);
                    end if;
                end if;
            end if;
        end if;

        // Add Tertiary Analysis
        ta_nodes:= search(SoftwareInstance where type = "Congenica Tertiary Analysis");
        ta_size:= size(ta_nodes);
        log.debug("Found %ta_size% TA nodes.");
        model.addContainment(bai, ta_nodes);

        // Add Control Plane
        k8s_nodes:= search(SoftwareInstance where type = "Congenica Kube Master");
        model.addContainment(bai, k8s_nodes);
        kubes:= search(in k8s_nodes traverse ContainedSoftware:SoftwareContainment:SoftwareContainer:SoftwareInstance);
        clusters:= search(in k8s_nodes traverse ContainedSoftware:SoftwareContainment:SoftwareContainer:SoftwareCluster);
        model.addContainment(bai, clusters);

        // Add Load Balancing
        lb_members  := search(in kubes traverse ServiceProvider:SoftwareService:Service:LoadBalancerMember);
        lb_pools    := search(in lb_members traverse ContainedMember:Containment:Container:LoadBalancerPool where lower(name) = "stream/kube_apiserver");
        lb_services := search(in lb_pools traverse ContainedPool:Containment:Container:LoadBalancerService);
        model.addContainment(bai, lb_services);

        // Add Webserver
        webservers  := search(in lb_services traverse ContainedService:Containment:Container:LoadBalancerInstance
                                                traverse NetworkService:NetworkService:NetworkDevice:SoftwareInstance);
        model.addContainment(bai, webservers);

        // Add NFS
        nfs_servers := search(in bai traverse SoftwareContainer:SoftwareContainment:ContainedSoftware:SoftwareInstance
                                        traverse RunningSoftware:HostedSoftware:Host:Host
                                            traverse Mounter:FileSystemMount:MountedFileSystem:FileSystem where mount = "/data"
                                                traverse Consumer:StorageUse:Provider:FileSystem
                                                    traverse MountedFileSystem:FileSystemMount:Mounter:Host
                                                        traverse Host:HostedSoftware:RunningSoftware:SoftwareInstance where type = "NFS Server");
        model.addContainment(bai, nfs_servers);

    end body;

end pattern;


identify Congenica 1.0
    tags congenica;
    DiscoveredProcess cmd -> set_by, simple_identity;
    unix_cmd 'kubelet' -> 'traversys', 'Congenica Tertiary Analysis Node';
end identify;