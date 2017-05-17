{ config, pkgs, ... }:

{
  ## Configuration ##

  nixpkgs.config.allowUnfree = true;
  nix.maxJobs = lib.mkDefault 8;
  
  # Required for current thunderbird
  nixpkgs.config.permittedInsecurePackages = [
         "libplist-1.12"
       ];

  ## Packages ##

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
        gnupg gnupg1
      ];

      networking = [
        tigervnc
        nfs-utils
        libnfsidmap
        sshfs-fuse
      ];

      utilities = [
        conky
        pavucontrol
        xvkbd
        pinentry
        keybase
      ];

      office = [
        gimp
        libreoffice
      ];

      multimedia = [
        clementine
        vlc
        ffmpeg
        shotwell
      ];

      gaming = [
        steam
      ];

      internet = [
        blink
        hexchat
        google-chrome
        thunderbird
        deluge
        firefox

      ];

      programming = [
        gitkraken
        idea.clion
        atom
      ];

      # Required libraries and such for development.
      dev = [
        ruby
        bundler
        nodejs
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

        customPackages = [
          #(pkgs.callPackage ./packages/onboard {})
          (pkgs.callPackage ./packages/nylas-mail {})
        ];

    # Packages installed in system profile.
    in systemAdministration ++
      networking ++
      utilities ++
      office ++
      multimedia ++
      gaming ++
      internet ++
      programming ++ dev ++
      kdeSoftware ++
      customPackages;

}
