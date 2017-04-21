{ config, pkgs, ... }:

{
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
  };
}
