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
         alsaLib
         atk
         glib
         pango
         gdk_pixbuf
         cairo
         freetype
         fontconfig
         dbus
         xorg.libXScrnSaver
         xorg.libXi
         xorg.libXtst
         xorg.libXcursor
         xorg.libXdamage
         xorg.libXrandr
         xorg.libXcomposite
         xorg.libXext
         xorg.libXfixes
         xorg.libXrender
         xorg.libX11
         xorg.libxkbfile
         nss
         nspr
         cups
         expat
         wget
         udev
       ];

       phases = [ "unpackPhase" ];

       unpackPhase = ''
       mkdir -p $out/lib
         ${dpkg}/bin/dpkg-deb -x $src unpacked
         cp -r unpacked/* $out/

         # Patch libs
         noderp=$(patchelf --print-rpath $out/usr/share/nylas-mail/libnode.so)
         patchelf --set-rpath $noderp:$out/lib:${stdenv.cc.cc.lib}/lib:${lib.makeLibraryPath propagatedBuildInputs } \
             $out/usr/share/nylas-mail/libnode.so

         ffrp=$(patchelf --print-rpath $out/usr/share/nylas-mail/libffmpeg.so)
         patchelf --set-rpath $ffrp:$out/lib:${stdenv.cc.cc.lib}/lib:${lib.makeLibraryPath propagatedBuildInputs } \
             $out/usr/share/nylas-mail/libffmpeg.so

         # Patch binaries
         binrp=$(patchelf --print-rpath $out/usr/share/nylas-mail/nylas)
         patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
             --set-rpath $binrp:$out/lib:${stdenv.cc.cc.lib}/lib:${lib.makeLibraryPath propagatedBuildInputs } \
             $out/usr/share/nylas-mail/nylas
       '';

       meta = {
         description = "Nylas Mail is an open-source mail client built on the modern web with Electron, React, and Flux. It is designed to be extensible, so it's easy to create new experiences and workflows around email.";
         license = stdenv.lib.licenses.gpl3;
         homepage = https://nylas.com;
       };

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
