tpl 1.18 module traversys_defs;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Functions', 'Definitions';
end metadata;

definitions traversys 1.0
    """
        Custom Traversys Functions

        Author: Wes Moskal-Fitzpatrick

        Change History:
        2013-02-11 | 1.0 | WMF | Created

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
            key:= text.hash(text.join(list_of_attrs, "/");
        else
            key:= text.join(list_of_attrs, "/");
        end if;
        return key
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

    define cleanse(dirty, q=true, u=true) -> clean
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