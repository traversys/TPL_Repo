// (C) 2019 Traversys Limited
// Licensed under GPL-3.0-or-later

tpl 1.15 module WSL;

metadata
    __name     :='Windows Subsystem for Linux';
    origin     :='Traversys';
    description:='Windows Subsystem for Linux';
    tree_path  :='Traversys', 'Software', 'WSL';
end metadata;

from TSAKLicense import gpl_license 1.0;

pattern WSL 1.0

    """
    Author: Wes Moskal-Fitzpatrick

    Models the Windows Subsystem for Linux as a RuntimeEnviroment.
    infers additional SoftwareInstance if the Linux Distro is running.

    WSL runs under user/administrator. Commands will not run as system user
    so this is recognition only.

    Change History:
    2019-05-06 1.0 WMF : Created.

    """

    overview
        tags traversys, wsl, windows, subsystem, linux;
    end overview;

    constants
        type    := "Windows Subsystem for Linux";
        ls_type := "Linux Kernel (WSL)";
    end constants;

    triggers
        on p:= DiscoveredProcess where cmd matches windows_cmd "wslhost";
    end triggers;

    body
        if gpl_license.accept_gpl = false then
            stop;
        end if;

        host    := model.host(p);
        instance:= regex.extract(p.args, regex "\{(\S+)\}", raw "\1");

        rte     := model.RuntimeEnvironment(
                                              key       := instance,
                                              type      := type,
                                              name      := "%type% on %host.name%",
                                              instance  := text.lower(instance),
                                              _traversys:= true
                                           );

        childs:= discovery.descendents(p);
        for child in childs do
            inference.associate(rte, child);
        end for;

        parent:= discovery.parent(p);
        inference.associate(rte, parent);
        linuxDistro:= discovery.parent(parent);

        if linuxDistro then

          path        := linuxDistro.cmd;
          rte.path    := linuxDistro.cmd;

          kernel      := none;
          version     := none;
          prVersion   := none;
          distro      := none;

          name        := "%ls_type% on %host.name%";


          kernelBin   := regex.extract(path, regex "\\.+\\(.+)\.exe$", raw "\1");
          if kernelBin then
              log.debug("Kernal Binary: %kernelBin%");
              // This code won't work because WSL won't run as system user
              kernelCmd   := discovery.runCommand(host, '"%path%" -c uname -r');
              if kernelCmd and kernelCmd.result then
                  kernel  := kernelCmd.result;
              end if;
              release     := discovery.runCommand(host, '"%path%" -c cat /etc/*-release');
              if release and release.result then
                  version := regex.extract(release.result, regex 'VERSION="(.*)"', raw '\1');
                  distro  := regex.extract(release.result, regex 'PRETTY_NAME="(.*)"', raw '\1');
                  if distro then
                      name:= "%distro% (WSL) on %host.name%";
                  end if;
              else
                    // Use the binary name as identifier
                    distro  := kernelBin;
                    name:= "%ls_type% (%distro%) on %host.name%";
              end if;
          end if;

          prVersion   := regex.extract(version, regex '^(\d+(?:\.\d+)?)', raw '\1', no_match := version);

          si:= model.SoftwareInstance(
                                      key             := instance,
                                      type            := ls_type,
                                      name            := name,
                                      instance        := text.lower(instance),
                                      kernel          := kernel,
                                      path            := path,
                                      distribution    := distro,
                                      version         := version,
                                      product_version := prVersion,
                                      _traversys      := true
                                     );

        end if;

    end body;

end pattern;
