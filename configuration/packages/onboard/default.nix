{ config, pkgs, ... }:

with pkgs; python35Packages.buildPythonApplication rec {
  name = "onboard-${version}";
  majorVersion = "1.4";
  version = "${majorVersion}.1";
  src = fetchurl {
    url = "https://launchpad.net/onboard/${majorVersion}/${version}/+download/${name}.tar.gz";
    sha256 = "01cae1ac5b1ef1ab985bd2d2d79ded6fc99ee04b1535cc1bb191e43a231a3865";
  };

  doCheck = false;

  propagatedBuildInputs = [
     gtk3
     gnome3.dconf
     libcanberra_gtk3
     libudev
     bash
     hunspell
     isocodes
     pkgconfig
     xorg.libXtst
     xorg.libxkbfile
     libxkbcommon
     python3
  ] ++ with python35Packages [
     pycairo
     dbus-python
     pygobject3
     systemd
     distutils_extra
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
