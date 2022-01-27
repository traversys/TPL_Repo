// (C) 2021 Traversys Limited
// Licensed under GPL-3.0-or-later

tpl 1.15 module excludeAger;

metadata
    __name     :='Exclude List Ager';
    origin     :='Traversys';
    description:='Scrape exclude list and remove devices, if not aged out.';
    tree_path  :='Traversys', 'Extensions', 'Exclude List Ager';
end metadata;

from TSAKLicense import gpl_license 1.0;
from subnetMapper import cidrTable 1.0, subnetFunctions 1.0;

configuration excludes 1.0
    """Ignore rules"""

    "Age to remove (days)" days := 7;

end configuration;

// search in '_System' ExcludeRange show name as 'Label', scope as 'Scope', range_strings as 'Range', recurrenceDescription(schedule) as 'Date Rules', description as 'Description', fullFoundationName(created_by) as 'User'

pattern excludeAger 1.0
    """
        This pattern will trigger on dropped endpoints. If the device exists,
        then it will remove the device according to preset aging rule.

        Change History:
        2021-06-01 1.0 WMF : Created.

    """

    overview
        tags Aging, Custom;
    end overview;

    triggers
        on dropped := DroppedEndpoints where __reason = "Excluded";
    end triggers;

    body

        // Loop and find devices
        endpoints := dropped.endpoints;

        for endpoint in endpoints do
            log.debug("Analysing %endpoint%...");
            devices := search(DiscoveryAccess where _last_marker and endpoint = "%endpoint%"
                                traverse Associate:Inference:InferredElement:);
            for device in devices do
                // Get last successful scan (if exists)
                log.debug("Device: %device.name%");
                last_success := device.last_update_success;
                log.debug("Last Sucessful scan: %last_success%");
                if last_success then
                    now := time.current();
                    log.debug("Time now: %now%");
                    old_age := time.delta(days := excludes.days);
                    log.debug("Old Age: %old_age%");
                    aging := now - last_success;
                    log.debug("Age Now: %aging%");
                    if aging > old_age then
                        log.debug("Destroying %device.name%...");
                        model.destroy(device);
                    end if;
                else // DQ deteriation, straight to removal
                    model.destroy(device);
                    log.debug("Destroying %device.name%...");
                end if;
            end for;
        end for;

    end body;

end pattern;
