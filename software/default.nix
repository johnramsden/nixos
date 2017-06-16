{ config, pkgs, lib, ... }:

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
  # Package overrides
  let
    # Package groups
    systemAdministration = [
      oh-my-zsh
      wget
      curl
      git
      unzip
      yakuake
      nix-repl
      gnupg gnupg1
      pinentry_qt5
      ark
      gptfdisk
      parted
    ];

    virtualization = [
      virtmanager
      OVMF qemu
      spice_gtk
      virt-viewer
    ];

    networking = [
      tigervnc
      nfs-utils
      libnfsidmap
      sshfs-fuse
      freerdp remmina
      ipmitool
      httpie
    ];

    utilities = [
      conky
      pavucontrol
      xvkbd
      pinentry
      keybase
      # wineStaging cabextract # For wine
    ];

    office = [
      gimp
      libreoffice
      calibre
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
      gnumake
      gdb
      clang lldb
      zfs
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

      # Packages I wrote
      customPackages = [
        (pkgs.callPackage ./packages/onboard {})
        (pkgs.callPackage ./packages/nylas-mail {})
        (pkgs.callPackage ./packages/postman {})
      ];

      # Existing packages I customized
      customizedPackages = [

        /*(pkgs.ipmiview.overrideAttrs (oldAttrs: rec {
          version = "160804";
          src = pkgs.fetchurl {
           url = "ftp://ftp.supermicro.com/utility/IPMIView/Linux/IPMIView_2.12.0_build.${version}_bundleJRE_Linux_x64.tar.gz";
           sha256 = "787a060413451a4a5993c31805f55a221087b7199bbaf20e9fe1254e2a76db42";
        };
        installPhase = ''
          mkdir -p $out/bin- $out/share/java
          cp -R . $out/
          cp $out/iKVM.jar $out/share/java/

          makeWrapper $out/jre/bin/java $out/bin/IPMIView \
            --prefix PATH : "$out/jre/bin" \
            --add-flags "-jar $out/IPMIView20.jar"
        '';
        }))*/

      ];

    # Packages installed in system profile.
    in systemAdministration ++
      virtualization ++
      networking ++
      utilities ++
      office ++
      multimedia ++
      gaming ++
      internet ++
      programming ++ dev ++
      kdeSoftware ++
      customPackages; # ++ customizedPackages;

}
