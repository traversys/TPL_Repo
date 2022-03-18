// (C) 2022 Traversys Limited
// Licensed under GPL-3.0-or-later

tpl 1.20 module PsuedoVault;

metadata
    __name     :='PsuedoVault';
    origin     :='Traversys';
    description:='Takes a username/password combination from Configuration Block and obscures it.';
    tree_path  :='Traversys', 'Extensions', 'PsuedoVault';
end metadata;

from TSAKLicense import gpl_license 1.0;

configuration psuedoVault 1.0
    """Credentials to be used in TPL"""

    "Username" username := "";
    "Password" password := "";

end configuration;

pattern updatePsuedoVault 1.0

    """
    Author: Wes Moskal-Fitzpatrick

    Set a value in the configuration block and it will be removed on save.

    Change History:
    2019-06-18 1.0 WMF : Created.

    Query:
    search PatternConfiguration where name = "PsuedoVault.psuedoVault" and __active = 1
    show
    name,
    version,
    description,
    __active,
    __config_values,
    __changed_values,
    username_current,
    username_default,
    password_current,
    password_default

    """

    overview
        tags traversys, psuedovault, vault, credentials;
    end overview;

    triggers
        on config:= PatternConfiguration modified where name = "PsuedoVault.psuedoVault" and __active = 1;
    end triggers;

    body

        if gpl_license.accept_gpl = false then
            stop;
        end if;

        log.debug("psuedoVault Username = %psuedoVault.username%");
        log.debug("psuedoVault Password = %psuedoVault.password%");
        log.debug("PatternConfig Username = %config.username_current%");
        log.debug("PatternConfig Password = %config.password_current%");

        // Remove Config Values
        config.password_current:= none;

        log.debug("psuedoVault Username = %psuedoVault.username%");
        log.debug("psuedoVault Password = %psuedoVault.password%");
        log.debug("PatternConfig Username = %config.username_current%");
        log.debug("PatternConfig Password = %config.password_current%");

    end body;

end pattern;
