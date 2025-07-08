// Developed by Wes Moskal-Fitzpatrick (Fusion)

tpl 1.15 module CMDB_EOL_Simple_Sync;

metadata
    origin := "Traversys";
    tree_path := "Traversys", "CMDB Sync", "Custom Extensions", "EOL (Simple)";
end metadata;

from CMDB.Host_ComputerSystem import Host_ComputerSystem 2.0;
from CMDB.SoftwareInstance_SoftwareServer import SoftwareInstance_SoftwareServer 4.0;

syncmapping EOL_Host 1.0

    """
        Author: Wes Moskal-Fitzpatrick

        Simple extension for EOL data.

        Assumes the CIs are setup with the following custom attributes:
        end_of_support
        end_of_extended_support
        end_of_life
        decom_date (customer eol)

        Change History
        --------------
        2022-07-05 : 1.0 : WMF : Created.

    """
    overview
        tags CMDB, Extension;
    end overview;

    mapping from Host_ComputerSystem.host as host

        traverse ElementWithDetail:SupportDetail::SupportDetail as hosting_supportdetail
            // No need to add a new CI type.
        end traverse;

    end mapping;

    body

        computersystem := Host_ComputerSystem.computersystem;
        
        for each hosting_supportdetail do
            if hosting_supportdetail.retirement_date then
                computersystem.end_of_life := hosting_supportdetail.retirement_date; // EOL
            end if;
            if hosting_supportdetail.end_support_date then
                computersystem.end_of_support := hosting_supportdetail.end_support_date; // EOS
            end if;
            if hosting_supportdetail.end_ext_support_date then
                computersystem.end_of_extended_support := hosting_supportdetail.end_ext_support_date; // EOES
            end if;
            if hosting_supportdetail.customer_retirement_date then
                computersystem.decomm_date := hosting_supportdetail.customer_retirement_date; // Customer EOL
            end if;
        end for;

    end body;

end syncmapping;


syncmapping EOL_SI 1.0

    """
        Author: Wes Moskal-Fitzpatrick

        Simple extension for EOL data.
        Seperate SI code required because some hosts won't have software and vice versa.

        Assumes the CIs are setup with the following custom attributes:
        end_of_support
        end_of_extended_support
        end_of_life
        decom_date (customer eol)

        Change History
        --------------
        2022-07-05 : 1.0 : WMF : Created.

    """
    overview
        tags CMDB, Extension;
    end overview;

    mapping from SoftwareInstance_SoftwareServer.softwareinstance as softwareinstance

        traverse ElementWithDetail:SupportDetail::SupportDetail as supportdetail
            // No need to add a new CI type.
        end traverse;

    end mapping;

    body

        softwareserver := SoftwareInstance_SoftwareServer.softwareserver;
        
        for each supportdetail do
            if supportdetail.retirement_date then
                softwareserver.end_of_life := supportdetail.retirement_date; // EOL
            end if;
            if supportdetail.end_support_date then
                softwareserver.end_of_support := supportdetail.end_support_date; // EOS
            end if;
            if supportdetail.end_ext_support_date then
                softwareserver.end_of_extended_support := supportdetail.end_ext_support_date; // EOES
            end if;
            if supportdetail.customer_retirement_date then
                softwareserver.decomm_date := supportdetail.customer_retirement_date; // Customer EOL
            end if;
        end for;

    end body;
end syncmapping;
