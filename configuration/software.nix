{ config, pkgs, ... }:

{
  ## Packages ##
  nixpkgs.config.allowUnfree = true;

  # Packages installed in system profile.
  environment.systemPackages = with pkgs; 
    # System Administration
    [ wget curl git ] ++
    # Networking
    [ nfs-utils ] ++
    ## USER - 'john' ##
    # Shell and related
    [ oh-my-zsh ] ++
    # Userspace utilities
    [  pavucontrol ] ++
    # General user applications
    [ atom yakuake google-chrome xvkbd ] ++
    # Programming 
    [ gitkraken idea.clion ] ++
    [
    kdeApplications.akonadi-contacts
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
    kdeApplications.spectacle    
  ];

  programs.zsh.enable = true;


}
