{ config, pkgs, lib, ... }:

{
  ## Configuration ##

  # Search packages:
  # grep -r gdb ./pkgs/top-level/all-packages.nix

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

    system = [ gnome3.dconf gnome3.dconf-editor ];

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
      go-ethereum
      mr
    ] ++ [
      # Cherrypicked
      onboard
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
      #steam
    ];

    internet = [
      blink
      hexchat
      google-chrome
      thunderbird
      deluge
      firefox
    ] ++ [
      # Cherrypicked
      #nylas-mail-bin # Enabled with service
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
      #(pkgs.callPackage ./packages/claymore {})
    ];

    # Existing packages I customized.
    customizedPackages = [

    (pkgs.vcsh.overrideAttrs (oldAttrs: rec {
      configurePhase = ''
        substituteInPlace ./Makefile --replace "all=test manpages" "all=manpages";
      '';
      #dontBuild = true;
      installPhase = ''
        make install PREFIX=$out
      '';
    }))

      (pkgs.steam.override { newStdcpp = true; })
      #(pkgs.virtualbox.override { enableExtensionPack = true; }) # Never worked properly
    ];

    # Packages installed in system profile.
    in systemAdministration ++
      system ++
      virtualization ++
      networking ++
      utilities ++
      office ++
      multimedia ++
      gaming ++
      internet ++
      programming ++ dev ++
      kdeSoftware ++
      customPackages ++ customizedPackages;

}
