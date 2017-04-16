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
    [  pavucontrol conky ] ++
    # General user applications
    [ atom yakuake google-chrome xvkbd jitsi hexchat deluge ] ++
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
      [ (import ./pkgs/onboard/default.nix ) ];

  programs.zsh.enable = true;

}
