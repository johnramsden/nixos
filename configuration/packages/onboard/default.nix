{ config
, pkgs ? import <nixpkgs> {}
, fetchurl
, python35Packages
, stdenv, ...
}:

python35Packages.buildPythonApplication rec {
  name = "onboard-${version}";
  majorVersion = "1.4";
  version = "${majorVersion}.1";
  src = fetchurl {
    url = "https://launchpad.net/onboard/${majorVersion}/${version}/+download/${name}.tar.gz";
    sha256 = "01cae1ac5b1ef1ab985bd2d2d79ded6fc99ee04b1535cc1bb191e43a231a3865";
  };

  doCheck = false;

  propagatedBuildInputs = [
    pkgs.gtk3
    pkgs.gnome3.dconf
    pkgs.libcanberra_gtk3
    pkgs.libudev
    pkgs.bash
    pkgs.hunspell
    pkgs.isocodes
    pkgs.pkgconfig
    pkgs.xorg.libXtst
    pkgs.xorg.libxkbfile
    pkgs.libxkbcommon
    pkgs.python3
    pkgs.python35Packages.pycairo
    pkgs.python35Packages.dbus-python
    pkgs.python35Packages.pygobject3
    pkgs.python35Packages.systemd
    pkgs.python35Packages.distutils_extra
  ];

  preBuild = ''
    rm -r Onboard/pypredict/attic
    sed -i 's:/bin/bash:${bash}/bin/bash:' ./setup.py
  '';

  meta = {
    homepage = https://launchpad.net/onboard;
    description = "An onscreen keyboard useful for tablet PC users and for mobility impaired users.";
    license = stdenv.lib.licenses.gpl3;
  };
}
