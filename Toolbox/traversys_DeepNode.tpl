// (C) 2021 Traversys Limited
// Licensed under GPL-3.0-or-later

tpl 1.15 module deepNode;

metadata
    __name     :='deepNode for BMC Discovery';
    origin     :='Traversys';
    description:='Get DDD Data for Inferred Nodes';
    tree_path  :='Traversys', 'Software', 'deepNode';
end metadata;

from TSAKLicense import gpl_license 1.0;

pattern deepNode 1.0

    """
    Author: Wes Moskal-Fitzpatrick

    A pattern for diving deep into useful DDD and appending these attributes to
    higher level inferred nodes in order to flatten the data curve.

    Change History:
    2021-01-31 1.0 WMF : Created.

    """

    overview
        tags traversys, deepNode;
    end overview;

    triggers
        on si:= SoftwareInstance;
    end triggers;

    body
        if gpl_license.accept_gpl = false then
            stop;
        end if;

        primaries:= search(in si traverse InferredElement:Inference:Primary:DiscoveredProcess);

        if size(primaries) = 1 then

            // Setup Primary Processes

            primary:= primaries[0];
            if 'args' in primary then
                si._primary_process:= "%primary.cmd% %primary.args%";
            else
                si._primary_process:= primary.cmd;
            end if;
            si._primary_pid:= primary.pid;
            si._primay_ppid:= primary.ppid;
            si._primary_user:= primary.username;

            //log.debug("Single Process found: %primary.pid%:%primary.username%:%primary.cmd%");

            // Get Process to Port Info

            comms:= search(in primary processwith communicationForProcesses(1));
            listening:= search(in primary processwith communicationForProcesses(2));

            listener_tokens := [];
            listening_ports := [];

            if size(listening) > 0 then
                log.debug("Listeners found...");
                for listener in listening do
                    token:= "%listener.pid%=%listener.local_ip_addr%:%listener.local_port%";
                    log.debug("Listener Token: %token%");
                    list.append(listener_tokens, token);
                    list.append(listening_ports, listener.local_port);
                end for;
                if size(listener_tokens) > 0 then
                    si._listeners:= listener_tokens;
                    si._listening_ports:= listening_ports;
                end if;
            end if;

        elif size(primaries) > 1 then

            processes:= [];
            pids:= [];
            ppids:= [];
            users:= [];

            count:= 0;

            for primary in primaries do

                //log.debug("Mulitple primary processes...");

                c:= count;

                if 'args' in primary then
                    list.append(processes, "%c%:%primary.cmd% %primary.args%");
                else
                    list.append(processes, "%c%:%primary.cmd%");
                end if;
                list.append(pids,"%c%:%primary.pid%");
                list.append(ppids,"%c%:%primary.ppid%");
                list.append(users,"%c%:%primary.username%");
                //log.debug("Process %c%: %primary.pid%:%primary.username%:%primary.cmd%");

                comms:= search(in primary processwith communicationForProcesses(1));
                listening:= search(in primary processwith communicationForProcesses(2));

                listener_tokens := [];
                listening_ports := [];

                if size(listening) > 0 then
                    log.debug("Listeners found...");
                    for listener in listening do
                        token:= "%listener.pid%=%listener.local_ip_addr%:%listener.local_port%";
                        log.debug("Listener Token: %token%");
                        list.append(listener_tokens, token);
                        list.append(listening_ports, listener.local_port);
                    end for;
                    if size(listener_tokens) > 0 then
                        si._listeners:= listener_tokens;
                        si._listening_ports:= listening_ports;
                    end if;
                end if;

                count:= c + 1;

            end for;

            si._primary_process:= processes;
            si._primary_pid:= pids;
            si._primay_ppid:= ppids;
            si._primary_user:= users;

        end if;

    end body;

end pattern;
