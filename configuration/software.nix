{ config, pkgs, ... }:

{

  ## Packages ##
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
         "libplist-1.12"
       ];

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

  /*let packaged-onboard = with pkgs; python35Packages.buildPythonApplication rec {
    name = "onboard-${version}";
    majorVersion = "1.4";
    version = "${majorVersion}.1";
    src = fetchurl {
      url = "https://launchpad.net/onboard/${majorVersion}/${version}/+download/${name}.tar.gz";
      sha256 = "01cae1ac5b1ef1ab985bd2d2d79ded6fc99ee04b1535cc1bb191e43a231a3865";
    };

    doCheck = false;

  propagatedBuildInputs = [ gtk3
                   python3
                   hunspell
                   isocodes
                   libcanberra_gtk3
                   xorg.libxkbfile
                   libxkbcommon
                   python35Packages.pycairo
                   python35Packages.dbus-python
                   python35Packages.pygobject3
                   python35Packages.systemd
                   libudev
                   python35Packages.distutils_extra
                   gnome3.dconf
                   pkgconfig
                   xorg.libXtst
                   bash ];

    preBuild = ''
      rm -r Onboard/pypredict/attic
      sed -i 's:/bin/bash:${bash}/bin/bash:' ./setup.py
    '';

    meta = {
      homepage = https://launchpad.net/onboard;
      description = "An onscreen keyboard useful for tablet PC users and for mobility impaired users.";
      license = stdenv.lib.licenses.gpl3;
    };
  };
  in [ packaged-onboard ];*/
}
