{ config, pkgs, ... }:

{

  ## Packages ##
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
         "libplist-1.12"
       ];


  # Packages installed in system profile.
  environment.systemPackages = with pkgs;
  # Package groups
  let systemAdministration = [
        oh-my-zsh
        wget
        curl
        git
        unzip
        yakuake
        nix-repl
      ];

      networking = [
        nfs-utils
        libnfsidmap
      ];

      utilities = [
        conky
        pavucontrol
        xvkbd
      ];

      office = [
        gimp
        libreoffice
      ];

      multimedia = [
        clementine
      ];

      internet = [
        blink
        hexchat
        google-chrome
        thunderbird
        deluge
      ];

      programming = [
        gitkraken
        idea.clion
        atom
      ];

      kdeSoftware = with kdeApplications; [
        akonadi-contacts
        akonadi-mime
        baloo-widgets
        dolphin-plugins
        kcachegrind
        kdegraphics-mobipocket
        kdegraphics-thumbnailers
        kdelibs
        kdenetwork-filesharing
        kdenlive
        kdf
        kgpg
        khelpcenter
        kig
        kio-extras
        kmime
        kmix
        kompare
        konsole
        kwalletmanager
        libkdcraw
        libkexiv2
        libkipi
        libkomparediff2
        marble
        okteta
        okular
        print-manager
        spectacle
        ];

    # Packages installed in system profile.
    in systemAdministration ++
      networking ++
      utilities ++
      office ++
      multimedia ++
      internet ++
      programming ++
      kdeSoftware;

  programs.zsh.enable = true;

}
