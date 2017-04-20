{ config, pkgs, ... }:

{

  ## Packages ##
  nixpkgs.config.allowUnfree = true;

  # Required for thunderbird branding
  nixpkgs.config.permittedInsecurePackages = [ "libplist-1.12" ];

  # Packages installed in system profile.
  environment.systemPackages = with pkgs;
    # System Administration
    [ wget curl git unzip yakuake ] ++
    # Networking
    [ nfs-utils libnfsidmap ] ++
    # Nix Specific
    [ nix-repl ] ++
    ## USER - 'john' ##
    # Shell and related
    [ oh-my-zsh ] ++
    # Userspace utilities
    [ conky pavucontrol ] ++
    # General user applications
    [ gimp xvkbd deluge libreoffice clementine ] ++
    # Internet
    [ blink hexchat google-chrome thunderbird ] ++
    # Programming
    [ gitkraken idea.clion atom ] ++
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
      kdeApplications.spectacle  ];


  programs.zsh.enable = true;


}
