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
    "Additional Credentials" credentials := [];

end configuration;

definitions vaultUtils 1.0
    """Utility functions for obscuring credentials"""

    define obscure(secret) -> out
        if not secret then
            out := secret;
            return out;
        end if;
        chars := regex.extractAll(secret, regex ".");
        rev := "";
        len := size(chars);
        for i in number.range(len) do
            rev := rev + chars[len - 1 - i];
        end for;
        out := "REV:" + rev;
        return out;
    end define;

    define reveal(obscured) -> out
        if not obscured then
            out := obscured;
            return out;
        end if;
        if obscured matches regex '^REV:' then
            rev := regex.extract(obscured, regex '^REV:(.*)$', raw '\1');
            chars := regex.extractAll(rev, regex ".");
            plain := "";
            len := size(chars);
            for i in number.range(len) do
                plain := plain + chars[len - 1 - i];
            end for;
            out := plain;
        else
            out := obscured;
        end if;
        return out;
    end define;

    define credential_password(config, user:=none) -> out
        """Return the stored password for a user"""
        out := none;
        if user and config._cred_store then
            enc := config._cred_store[user];
            if enc then
                out := reveal(enc);
            end if;
        elif not user then
            out := reveal(config._p);
        end if;
        return out;
    end define;

end definitions;

pattern updatePsuedoVault 1.0

    """
    Author: Wes Moskal-Fitzpatrick

    The configuration block acts as a psuedo-vault for one password.

    Setting the username and/or password value will trigger the logic below to:
    1) Evaluate current and default password state - if they are the same(default), do nothing
    2) If the current password is set - set the "_p" variable
    3) If the _p variable is set, the current password can be wiped
    4) If the username has been reset to default, then set current password to default

    Features:
    - Stored passwords are obscured using a reversible method.
    - Multiple credentials can be supplied as a list of "user:password" entries.

    Change History:
    2022-03-19 1.0 WMF : Created.

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
    password_default,
    _p as 'Stored Password'

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

        log.debug("psuedoVault Password = %psuedoVault.password%");
        log.debug("PatternConfig Current Password = %config.password_current%");
        log.debug("PatternConfig Password = %config.password%");

        if config.password_current = config.password_default then
            // Password is set to default
            // Reset password variable and do nothing.
            config._p := config.password_default;
            stop;
        end if;

        if config.password_current then
            // Password set
            enc := vaultUtils.obscure(config.password_current);
            if config._p = enc then
                // The current password is visible - remove from UI
                config.password_current := none;
                stop;
            else // Stored password differs
                config._p := enc;
            end if;

            // Final check
            if config._p then // config.password has been set
                config.password_current := none;
            end if;
        elif config.username_current = config.username_default then
            // Login has been reset
            config._p := config.password_default;
        end if;

        if config.credentials_current then
            store := table();
            for cred in config.credentials_current do
                if cred matches regex '^([^:]+):(.*)$' then
                    user := regex.extract(cred, regex '^([^:]+):', raw '\1');
                    pass := regex.extract(cred, regex '^[^:]+:(.*)$', raw '\1');
                    store[user] := vaultUtils.obscure(pass);
                end if;
            end for;
            config._cred_store := store;
            config.credentials_current := none;
        end if;

    end body;

end pattern;
