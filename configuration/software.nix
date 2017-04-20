{ config, pkgs, ... }:

{

  ## Packages ##
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
         "libplist-1.12"
       ];

  # Packages installed in system profile.
  environment.systemPackages = with pkgs;
    # System Administration
    [ oh-my-zsh wget curl git unzip yakuake nix-repl ] ++
    # Networking
    [ nfs-utils libnfsidmap ] ++
    # utilities
    [ conky pavucontrol xvkbd ] ++
    #Office
    [ gimp libreoffice ] ++
    # Multimedia
    [ clementine ] ++
    # Internet
    [ blink hexchat google-chrome thunderbird deluge ] ++
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
      sed -i 's:/bin/bash:${bash}/bin/bash:' ./setup.py
      for file in Onboard/pypredict/attic/*; do
        echo "Copying $file to $file.py"
        cp $file $file.py;
      done
    '';

    meta = {
      homepage = https://launchpad.net/onboard;
      description = "An onscreen keyboard useful for tablet PC users and for mobility impaired users.";
      license = stdenv.lib.licenses.gpl3;
    };
  };
  in [ packaged-onboard ];*/
}
