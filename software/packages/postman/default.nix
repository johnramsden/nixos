{ fetchurl, lib, pkgs, stdenv, config
, cairo
, cups
, expat
, atk
, pango
, fontconfig
, freetype
, gobjectIntrospection
, dbus
, gnome2
, glib
, nss
, nspr
, libstdcxx5
, xorg
, makeWrapper
, gdk_pixbuf
, atomEnv
, alsaLib
}:

stdenv.mkDerivation rec {
  name = "${pkgname}-${version}";
  pkgname = "postman";
  version = "5.0.0";

  src =
    fetchurl {
      url = "https://dl.pstmn.io/download/version/${version}/linux64";
      sha256 = "5af0ef2924e4e0902ca6be33b83acc840ebc0fa6525221bab38c5aa386dd0352";
    };

  phases = [ "unpackPhase" ];

  propagatedBuildInputs = [
    cairo
    cups
    expat
    atk
    pango
    fontconfig
    freetype
    gobjectIntrospection
    dbus
    gnome2.GConf
    glib
    nss
    nspr
    libstdcxx5
    gdk_pixbuf
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libxkbfile
  ];

  # Runtime dependencies
  buildInputs = [ makeWrapper ];

  unpackPhase = ''
    mkdir -p $out
    tar xvf $src > /dev/null
    mv Postman/* $out

    # Patch binaries
    binrp=$(patchelf --print-rpath $out/Postman)
    patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath $binrp:$out/lib:${stdenv.cc.cc.lib}:${lib.makeLibraryPath propagatedBuildInputs } $out/Postman

    wrapProgram $out/Postman \
      --set LD_LIBRARY_PATH "${lib.makeLibraryPath [
          stdenv.cc.cc.lib alsaLib.out atomEnv.libPath
        ]}"
  '';

  meta = with stdenv.lib; {
    description = "Build, test, and document your APIs faster";
    license = licenses.mit;
    maintainers = with maintainers; [ johnramsden ];
    homepage = https://www.getpostman.com;
    platforms = [ "x86_64-linux" ];
  };
}
