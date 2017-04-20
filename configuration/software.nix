{ config, pkgs, ... }:

{

  ## Packages ##
  nixpkgs.config.allowUnfree = true;

  # Packages installed in system profile.
  environment.systemPackages = with pkgs;
    # System Administration
    [ wget curl git unzip ] ++
    # Networking
    [ nfs-utils libnfsidmap ] ++
    # Nix Specific
    [ nix-repl ] ++
    ## USER - 'john' ##
    # Shell and related
    [ oh-my-zsh ] ++
    # Userspace utilities
    [  pavucontrol ] ++
    # Conky & conky requirements
    [ conky imlib2 perlPackages.MailIMAPClient ] ++
    # General user applications
    [ atom yakuake google-chrome gimp thunderbird xvkbd hexchat deluge libreoffice blink ] ++
    # Programming
    [ gitkraken idea.clion ] ++
    ## KDE ##
    [ kdeApplications.akonadi-contacts
      kdeApplications.akonadi-mime
      kdeApplications.baloo-widgets
      kdeApplications.dolphin-plugins
      kdeApplications.kcachegrind
      kdeApplications.kdegraphics-mobipocket
      kdeApplications.kdegraphics-thumbnailers
      kdeApplications.kdelibs
      kdeApplications.kdenetwork-filesharing
      kdeApplications.kdenlive
      kdeApplications.kdf
      kdeApplications.kgpg
      kdeApplications.khelpcenter
      kdeApplications.kig
      kdeApplications.kio-extras
      kdeApplications.kmime
      kdeApplications.kmix
      kdeApplications.kompare
      kdeApplications.konsole
      kdeApplications.kwalletmanager
      kdeApplications.libkdcraw
      kdeApplications.libkexiv2
      kdeApplications.libkipi
      kdeApplications.libkomparediff2
      kdeApplications.marble
      kdeApplications.okteta
      kdeApplications.okular
      kdeApplications.print-manager
      kdeApplications.spectacle  ] ++
      # Add polkit action
      [ (pkgs.writeTextFile {
            name = "org.john.zfs.policy";
            destination = "/share/polkit-1/actions/org.john.zfs.policy";
            text = ''
            <?xml version="1.0" encoding="UTF-8"?>
            <!DOCTYPE policyconfig PUBLIC "-//freedesktop//DTD polkit Policy Configuration 1.0//EN"
            "http://www.freedesktop.org/software/polkit/policyconfig-1.dtd">
            <policyconfig>

              <vendor>John Ramsden</vendor>
              <vendor_url>https://ramsdenj.com/</vendor_url>

              <action id="org.john.zfs">
                <description>Run zfs list</description>
                <message>Authentication is required to run zfs list as (user=$(user), user.gecos=$(user.gecos), user.display=$(user.display)$
                <defaults>
                  <allow_any>yes</allow_any>
                  <allow_inactive>yes</allow_inactive>
                  <allow_active>yes</allow_active>
                </defaults>
                <annotate key="org.freedesktop.policykit.exec.path">${pkgs.zfs}/sbin/zfs</annotate>
              </action>

              <action id="org.john.zpool">
                <description>Run zpool status</description>
                <message>Authentication is required to run zpool status as (user=$(user), user.gecos=$(user.gecos), user.display=$(user.disp$
                <defaults>
                  <allow_any>yes</allow_any>
                  <allow_inactive>yes</allow_inactive>
                  <allow_active>yes</allow_active>
                </defaults>
                <annotate key="org.freedesktop.policykit.exec.path">${pkgs.zfs}/sbin/zpool</annotate>
              </action>

            </policyconfig>
            '';   } )
      ];


  programs.zsh.enable = true;


}
