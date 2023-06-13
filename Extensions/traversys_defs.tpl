tpl 1.20 module traversys_defs;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Functions', 'Definitions';
end metadata;

definitions print 1.1
    """
        Enhanced logging functions.

        Author: Wes Moskal-Fitzpatrick (Traversys)

        Change History:
        2022-04-27 | 1.0 | WMF | Created
        2023-06-13 | 1.1 | WMF | Commented out datatype function.
                                 Merged and removed duplicate print func.

    """

    define info(active, message)
        """Enhanced info."""
        if active then
            log.info("INFO: %message%");
        end if;
    end define;
    
    define debug(active, message)
        """Enhanced debug."""
        if active then
            log.debug("DEBUG: %message%");
        end if;
    end define;

    define critical(active, message)
        """Enhanced critical."""
        if active then
            log.critical("CRITICAL: %message%");
        end if;
    end define;

    define warn(active, message)
        """Enhanced warn."""
        if active then
            log.warn("WARNING: %message%");
        end if;
    end define;

    define error(active, message)
        """Enhanced error."""
        if active then
            log.error("ERROR: %message%");
        end if;
    end define;

    define attribute(active, message, string)
        """Log an attribute in debug."""
        if active then
            log.debug("DEBUG: %message% = %string%");
        end if;
    end define;

    define data_type(active, message, attr)
        """Log an attribute in debug."""
        if active then
            dt:= datatype(attr);
            log.debug("DEBUG: %message% = %dt%");
        end if;
    end define;

    define list_size(active, message, _list_)
        """Get size of a list."""
        if active then
            sz:= size(_list_);
            log.debug("DEBUG: %message% = %sz%");
        end if;
    end define;

end definitions;

definitions traversys 1.1
    """
        Custom Traversys Functions

        Author: Wes Moskal-Fitzpatrick

        Change History:
        2013-02-11 | 1.0 | WMF | Created
        2023-06-13 | 1.1 | WMF | Fixed missing param on build_key().
                                 Fixed some missing semi-colons and relationship
                                 keyword on quick relationships func.

    """
    
    define environment(var, begin) -> env
        """
            Parse variable to get environment, default to number of characters.
        """
        if var matches regex "^prd" then
            env:= "PROD";
        elif var matches regex "^prod" then
            env:= "PROD";
        else
            // Extract the first 'begin' characters and use that
            e:= regex.extract(var, regex "^(\w{%begin%})", raw "\1");
            env:= text.upper(e);
        end if;
        if not env then
            env:= "Unknown";
        end if;
        return env;
    end define;
    
    define getUID(s) -> user
        """
            Find out the user from the user ID if possible.
            This is useful in cases where the username is populated by User ID number.
        """
        user:= s.username;
        suid:= "%s.uid%"; // Converts to text
        // If the username is a UID, instead of text string
        if s.username = suid then
            // Get current discovery access
            da:= discovery.access(s);
            das:= size(da);
            // Run command on the host (discovery access)
            pwd:= discovery.fileGet(da, "/etc/passwd");
            if pwd and pwd.content then
                // Looking for the UID to match to the username
                rx:= raw "(\w+):x:" + suid + ":";
                uid:= regex.extract(pwd.content, rx, raw "\1", no_match:= s.username);
                user:= uid;
            end if;
        end if;
        return user;
    end define;

    define highest_package(host, rx) -> version, pkg_name
        """
            Get highest version package.
        """
        
        // Get Package details
        packages := model.findPackages(host, rx);
        
        version:= "";
        pkg_name:= "";
        
        if packages then
            for p in packages do
                if "version" in p then
                    if p.version > version then
                        version:= p.version;
                        pkg_name:= p.name;
                    end if;
                end if;
            end for;
        end if;
    
        return version, pkg_name;
        
    end define;

    define getPackages(host, match_list) -> version, product_version, revision, build, description, display
        """
            Get the best package and other details.
        """

        version         := void;
        product_version := void;
        revision        := void;
        build           := void;
        description     := void;
        display         := [];

        packages := model.findPackages(host, match_list);
        for pkg in packages do
            if "version" in pkg then
                if pkg.version > version then
                    version := pkg.version;
                    product_version:= regex.extract(version, regex "(\d+(?:\.\d+)?)", raw "\1", no_match:= version);
                    list.append(display, "version");
                    list.append(display, "product_version");
                    if "revision" in pkg then
                        revision := pkg.revision;
                        list.append(display, "revision");
                    end if;
                    if "description" in pkg then
                        description:= pkg.description;
                        list.append(display, "description");
                    end if;
                    if "build" in pkg then
                        build := pkg.build;
                        list.append(display, "build");
                    end if;
                end if;
            end if;
        end for;

        return version, product_version, revision, build, description, display;

    end define;
    
    define communicatingServices(si) -> commSIs, dds, dbs
        """
            Like processes, but for services
        """
        commSIs:= [];
        dds:= [];
        dbs:= [];
        sv:= search(in si traverse InferredElement:Inference:Primary:DiscoveredService);
        if size(sv) > 0 then
            procs:= discovery.allProcesses(sv);
            commSIs:= search(in procs where pid = %sv.pid%
                             processwith communicationForProcesses, localToRemote, processesForCommunication
                             traverse Primary:Inference:InferredElement:SoftwareInstance);
             if size(commSIs) > 0 then
                // Get DB Servers
                dds:= search(in commSIs traverse Client:Communication:Server:SoftwareInstance
                             traverse ElementWithDetail:Detail:Detail:DatabaseDetail);
                dbs:= search(in dds traverse Detail:Detail:ElementWithDetail:SoftwareInstance);
            end if;
        end if;
        return commSIs, dds, dbs;
    end define;

    define getCommunicatingSIsDBs(si) -> comms, dds, dbs
        """
            Get communicating SIs and Databases
        """
        dds:= [];
        dbs:= [];
        comms := search(in si processwith communicatingSIs);
        if size(comms) > 0 then
            // Get DB Servers
            dds:= search(in comms traverse Client:Communication:Server:SoftwareInstance
                                  traverse ElementWithDetail:Detail:Detail:DatabaseDetail);
            dbs:= search(in dds traverse Detail:Detail:ElementWithDetail:SoftwareInstance);
        end if;
        return comms, dds, dbs;
    end define;

    define add_dbs(instances, type, bai) -> found_dbs, db_sis, new_dbrels
        """
            Add Databases
        """
        new_dbrels:= "";
        found_dbs:= [];
        db_sis:= [];
        for i in instances do
            rx:= raw "^(?i)" + i;
            found_dbs:= search(Database where type = '%type%' and instance matches regex "%rx%");
            for db in found_dbs do
                new_dbrels:= model.rel.Dependency(DependedUpon:= db, Dependant:= bai);
                db_sis:= search(in db traverse Detail:Detail:ElementWithDetail:SoftwareInstance);
                model.addContainment(bai, db_sis);
            end for;
        end for;
        return found_dbs, db_sis, new_dbrels;
    end define;
    
    define getProcesses(si) -> process, all_processes
        """
            Return primary process and all processes
        """
        process:= "";
        all_processes:= [];
        procs:= search(in si traverse InferredElement:Inference:Primary:DiscoveredProcess);
        if size(procs) > 1 then
            process:= procs[0];
            all_processes:= discovery.allProcesses(process);
        end if;
        return process, all_processes;
    end define;

    define existingNodes(key, ip_address, port) -> existing_ssl_nodes, ips, ports
        """
            Hosts can have multiple SSL certificates assigned to multiple IPs and Ports.
            The purpose of this function is to define query to look for an existing
            SSL certificate based on the composite key. If one is found, then the node
            will be updated and if the IP or port is new, this will be added.
            By default, this query looks for an existing certificate with a matching key.
        """
        existing_ssl_nodes:=search(Detail where key = "%key%");
        ips     := [ ip_address ];
        ports   := [ port ];

        if existing_ssl_nodes then
            ips     :=existing_ssl_nodes[0].all_ip_addresses;
            ports   :=existing_ssl_nodes[0].ports;
            if ip_address not in ips then
                list.append(ips, ip_address);
            end if;
            if port not in ports then
                list.append(ports, port);
            end if;
        end if;
        return existing_ssl_nodes, ips, ports;
    end define;

    define xtract_single(d,p) -> v
        """
            Supports XML 'single item' list extraction
        """
        v:="";
        l:=xpath.evaluate(d, p);
        if size(l) > 0 then
            v:=l[0];
        end if;
        return v;
    end define;

    define xpathEvaluate(xmldoc, path) -> single_value, list_value, success
        """
            Return both list and singular results.
        """
    
        list_value   := xpath.evaluate(xmldoc, path);
        single_value := none;
        success      := false;
        if size(list_value) > 0 then
            single_value:= list_value[0];
            success:= true;
        end if;

        return single_value, list_value, success;

    end define;

    define regex_shuffle(rx, var, rw) -> val
        """
            Parse multiple regex to get a value
        """
        val:="";
        for r in rx do
            val:= regex.extract(var, r, rw);
            if val then
                break;
            end if;
        end for;
        return val;
    end define;

    define add_it(n, attr, res, reg, rw)
        """
            Clean way to add exracted values to a custom node attribute,
            and void them if not matched.
        """
        x:= regex.extract(res, reg, rw);
        if x then
            n[attr]:= x;
        else
            n[attr]:= void;
        end if;
    end define;

    define build_key(list_of_attrs, hash:=false) -> key
        """
            List of values in order, with hash option
        """
        if hash then
            key:= text.hash(text.join(list_of_attrs, "/"));
        else
            key:= text.join(list_of_attrs, "/");
        end if;
        return key;
    end define;

    define display_attrs(n,l)
        """
            Add list of display attributes
        """
        if n.port then
            list.append(l, "port");
        end if;
        if n.serial_number then
            list.append(l, "serial_number");
        end if;
        model.addDisplayAttribute(n,l);
    end define;

    define cleanse(dirty, q:=true, u:=true) -> clean
        "Cleanup attributes"
        // Strip Whitespace
        dirty:= text.strip(dirty);
        // Remove linebreaks
        dirty:= text.replace(dirty, "\n", "");
        dirty:= text.replace(dirty, "\r", "");
        // Remove all Quotes
        if q then
            dirty:= text.replace(dirty, '"', '');
            dirty:= text.replace(dirty, "'", "");
        end if;
        // Remove Sequential Underscores
        if u then
            dirty:= text.replace(dirty, regex.extract(dirty, regex "(__+\s?)", raw "\1"), "");
        end if;
        clean:= dirty;
        return clean;
    end define;

    define valid_dates(nb, na) -> vf, vt
        """
            Convert valid time formats
        """
        vf:= "No Data Available";
        vt:= "No Data Available";
        if nb matches "Can't parse" then
            log.warn("Valid From date parse error: %nb%");
        else
            nf:= time.parseUTC(nb);
            vf:= time.formatUTC(nf, "%%Y-%%m-%%d");
        end if;
        if na matches "Can't parse" then
            log.warn("Valid To date parse error: %na%");
        else
            nt:= time.parseUTC(na);
            vt:= time.formatUTC(nt, "%%Y-%%m-%%d");
        end if;
        return vf, vt;
    end define;

    // Quick Relationships
    define model_rel(rel,first,second)
        """
            Quick relationship inference.
            First - the first ordinal node in the heirachy: i.e. the container or server
            Second - the node to be subject: i.e. the contained, dependent or client
        """
        if rel = "Containment" then
            //model.rel.Containment(Container := node, Contained := node);
            model.rel.Containment(Container:=first, Contained:=second);
        elif rel = "Dependency" then
            //model.rel.Dependency(DependedUpon:=node,Dependant:=node);
            model.rel.Dependency(DependedUpon:=first, Dependant:=second);
        elif rel = "Detail" then
            //model.rel.Detail(ElementWithDetail:=node, Detail:=node);
            model.rel.Detail(ElementWithDetail:=first, Detail:=second);
        elif rel = "Communication" then
            //model.rel.Communication(Server:=node, Client:=node);
            model.rel.Communication(Server:=first, Client:=second);
        else
            log.warn("Relationship %rel% not recognised!");
        end if;
    end define;

    // Quick Searches
    define hostedSoftware(node,type) -> results
        """
            Get software running on a particular host node.
        """
        results:=search(in node
                        traverse :HostedSoftware::SoftwareInstance 
                            where type = "%type%");
        return results;
    end define;

    define peerSoftware(node) -> results
        """
            Get peer communicating software.
        """
        results:=search(in node
                        traverse Peer:Communication:Peer:SoftwareInstance);
        return results;
    end define;

    define allSoftware(node) -> results
        """
            Get software running on the same host.
        """
        hostnode:=related.host(node);
        results:=search(in hostnode traverse Host:HostedSoftware:RunningSoftware:SoftwareInstance);
        return results;
    end define;

    define artificialAging(existing_nodes, new_nodes, age)
        """
            Arbitrarily age-out (remove) nodes based on key creation.
        """
        now := time.current();
        threshold := time.delta(days:=age);
        existing_keys := [];
        new_keys := [];
        for n in existing_nodes do
            list.append(existing_keys , n.key);
        end for;
        for n in new_nodes do
            list.append(new_keys , n.key);
        end for;
        key_removal := [];
        for key in existing_keys do
            if key not in new_keys then
                list.append(key_removal,  key);
            end if;
        end for;
        if size(key_removal) > 0 then
            for n in existing_nodes do
                if n.key in key_removal then
                    if now - n.last_seen > threshold then
                        log.warn("%n.name% older than %age%, removing...");
                        model.destroy(n);
                    end if;
                end if;
            end for;
        end if;
    end define;

    define delHostDuplicates(hostnode)
        """
            Remove duplicate hosts (identity change from upgrade/migration or UUID duplication).
        """
        host_age:= hostnode.age_count;
        other_hosts:= search(Host where name = "%hostnode.name%");
        if size(other_hosts) > 1 then
            for node in other_hosts do
                if node.age_count < host_age then
                    log.debug("Host %node.name%, age count < %hostnode.age_count%");
                    log.warn("Removing host %node.name% type %node.type% key %node.key%...");
                    model.destroy(hostnode);
                end if;
            end for;
        end if;
    end define;

    define getFileContent(host, config_file) -> file, content, success
        """
            Get and validate the config file.
        """
    
        file    := discovery.fileGet(host, config_file);
        content := none;
        success := false;
        if file and file.content then
            log.debug("Found config file: %file.path%");
            success:= true;
            content:= file.content;
        end if;

        return file, content, success;

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

    define displayAttribute(node, attr, value)
        """
            Add a list of attributes or void them.
        """
        adt:= datatype(value);
        if adt = "void" then
            node[attr]:= void;
            log.debug("Attribute %attr% is void.");
        elif adt = "none" then
            node[attr]:= void;
            log.debug("Attribute %attr% is none.");
        elif adt = "list" then
            if size(adt) > 0 then
                node[attr]:= value;
                model.addDisplayAttribute(node, attr);
            else
                node[attr]:= void;
                log.debug("Attribute list %attr% is empty.");
            end if;
        elif adt = "node" then
            log.warn("Attribute %attr% is a node.");
            node[attr]:= void;
        elif adt = "relationship" then
            log.warn("Attribute %attr% is a relationship.");
            node[attr]:= void;
        elif adt = "nodeset" then
            log.warn("Attribute %attr% is a nodeset.");
            node[attr]:= void;
        elif adt = "unknown" then
            log.warn("Setting attribute %attr% (unknown data type).");
            node[attr]:= value;
            model.addDisplayAttribute(node, attr);
        else
            node[attr]:= value;
            model.addDisplayAttribute(node, attr);
        end if;

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

  definitions specials 1.0
    """ 
        Special Functions.

        Author: Wes Moskal-Fitzpatrick

        Change History:
        2014-11-12 | 1.0 | WMF | Created
    """

    define slashes(host) -> slash
        """
            Set direction of slashes for filepaths.
        """
        slash := "/"; // Linux
        if host.os_type = "Windows" then
            slash := "\\";
        end if;
    
        return slash;

    end define;

end definitions;

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