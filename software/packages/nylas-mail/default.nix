{ config
, stdenv
, pkgs
, fetchurl
, dpkg
, lib
, gnome2
, libgnome_keyring
, desktop_file_utils
, python2
, nodejs
, libnotify
, alsaLib
, atk
, glib
, pango
, gdk_pixbuf
, cairo
, freetype
, fontconfig
, dbus
, nss
, nspr
, cups
, expat
, wget
, udev
, xorg
, libgcrypt
# , libsecret Will be needed at some point when libgnome_keyring is deprecated
, makeWrapper
}:

stdenv.mkDerivation rec {
   name = "${pkgname}-${version}";
   pkgname = "packaged-nylas-mail";
   version = "2.0.31";
   subVersion = "e675deb";

   src = fetchurl {
     url = "https://edgehill.s3-us-west-2.amazonaws.com/${version}-${subVersion}/linux-deb/x64/NylasMail.deb";
     sha256 = "b036956174f998bd4a2662a1f59cb4a302465b3ed06c487de88ff2721e372f6e";
   };

   # Build dependencies
   propagatedBuildInputs = [
     gnome2.gtk
     gnome2.GConf
     libgnome_keyring
     desktop_file_utils
     python2
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
     nss
     nspr
     cups
     expat
     wget
     udev
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
   ];

   # Runtime dependencies
   buildInputs = [ makeWrapper gnome2.gnome_keyring ];

   phases = [ "unpackPhase" ];

   unpackPhase = ''
    mkdir -p $out
       ${dpkg}/bin/dpkg-deb -x $src unpacked
       cp -r unpacked/* $out/

      # Fix path in desktop file
    substituteInPlace $out/usr/share/applications/nylas-mail.desktop \
        --replace /usr/bin/nylas-mail $out/bin/nylas-mail

    mv $out/usr/* $out/

     # Patch librariess
     noderp=$(patchelf --print-rpath $out/share/nylas-mail/libnode.so)
     patchelf --set-rpath $noderp:$out/lib:${stdenv.cc.cc.lib}/lib:${xorg.libxkbfile.out}/lib:${lib.makeLibraryPath propagatedBuildInputs } \
         $out/share/nylas-mail/libnode.so

     ffrp=$(patchelf --print-rpath $out/share/nylas-mail/libffmpeg.so)
     patchelf --set-rpath $ffrp:$out/lib:${stdenv.cc.cc.lib}/lib:${lib.makeLibraryPath propagatedBuildInputs } \
         $out/share/nylas-mail/libffmpeg.so

     # Patch binaries
     binrp=$(patchelf --print-rpath $out/share/nylas-mail/nylas)
     patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
         --set-rpath $binrp:$out/lib:${stdenv.cc.cc.lib}/lib:${lib.makeLibraryPath propagatedBuildInputs } \
         $out/share/nylas-mail/nylas

    wrapProgram $out/share/nylas-mail/nylas --set LD_LIBRARY_PATH "${xorg.libxkbfile}/lib:${libgnome_keyring}/lib";

    rm -r $out/usr/
   '';

   meta = {
     description = "Nylas Mail is an open-source mail client built on the modern web with Electron, React, and Flux. It is designed to be extensible, so it's easy to create new experiences and workflows around email.";
     license = stdenv.lib.licenses.gpl3;
     homepage = https://nylas.com;
   };
}
