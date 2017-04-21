{ config, pkgs, ... }:

{

  ## Packages ##
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
         "libplist-1.12"
       ];


  # Packages installed in system profile.
  environment.systemPackages = with pkgs;
    let
    packaged-nylas-mail = with pkgs; stdenv.mkDerivation rec {
       name = "${pkgname}-${version}";
       pkgname = "packaged-nylas-mail";
       version = "2.0.16";
       subVersion = "4d74cdf";

       src = fetchurl {
         url = "https://edgehill.s3-us-west-2.amazonaws.com/${version}-${subVersion}/linux-deb/x64/NylasMail.deb";
         sha256 = "eeaba98898952a8ba3c09ed1fd786dec9e8e977a43b90254e06b13fc24b77cce";
       };

       propagatedBuildInputs = [
         gnome2.gtk
         libgnome_keyring
         gnome2.gnome_keyring
         desktop_file_utils
         python2
         gnome2.GConf
         nodejs
         libnotify
         xorg.libXtst
         alsaLib
         xorg.libXScrnSaver
       ];

       phases = [ "unpackPhase" ];

       unpackPhase = ''
         ${dpkg}/bin/dpkg-deb -x $src unpacked
         cp -r unpacked/* $out/

         # Patch libs
         noderp=$(patchelf --print-rpath $out/usr/share/nylas-mail/libnode.so)
         patchelf --set-rpath $noderp:$out/lib:${lib.makeLibraryPath propagatedBuildInputs } \
             $out/usr/share/nylas-mail/libnode.so

         ffrp=$(patchelf --print-rpath $out/usr/share/nylas-mail/libffmpeg.so)
         patchelf --set-rpath $ffrp:$out/lib:${lib.makeLibraryPath propagatedBuildInputs } \
             $out/usr/share/nylas-mail/libffmpeg.so

         # Patch binaries
         binrp=$(patchelf --print-rpath $out/usr/share/nylas-mail/nylas)
         patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
             --set-rpath $binrp:$out/lib:${lib.makeLibraryPath propagatedBuildInputs } \
             $out/usr/share/nylas-mail/nylas
       '';

       meta = {
         description = "Nylas Mail is an open-source mail client built on the modern web with Electron, React, and Flux. It is designed to be extensible, so it's easy to create new experiences and workflows around email.";
         license = stdenv.lib.licenses.gpl3;
         homepage = https://nylas.com;
       };
   }; in [ packaged-nylas-mail ] ++
    # System Administration
    [ patchelf oh-my-zsh wget curl git unzip yakuake nix-repl binutils dpkg ] ++
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
