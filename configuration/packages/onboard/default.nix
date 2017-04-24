{ config
, pkgs ? import <nixpkgs> {}
, fetchurl
, gtk3
, gnome3
, libcanberra_gtk3
, libudev
, hunspell
, isocodes
, pkgconfig
, xorg
, libxkbcommon
, python3
, python35Packages
, stdenv
, bash
, intltool
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
    intltool
    python3
    python35Packages.pycairo
    python35Packages.dbus-python
    python35Packages.pygobject3
    python35Packages.systemd
    python35Packages.distutils_extra
  ];

  preBuild = ''
    rm -r Onboard/pypredict/attic
    patchShebangs .
    # sed -i 's:/bin/bash:${bash}/bin/bash:' ./setup.py
    substituteInPlace  ./setup.py --replace /bin/bash ${bash}/bin/bash
    # find -type f -name "*.py" | xargs --replace "#!/usr/bin/python3"
  '';

  #postInstall = ''
  #  cp data/org.onboard.gschema.xml $out//usr/share/glib-2.0/schemas/
  #  glib-compile-schemas $out/usr/share/glib-2.0/schemas
  #  cp onboard-default-settings.gschema.override.example $out/usr/share/glib-2.0/schemas/10_onboard-default-settings.gschema.override
  #  '';

  meta = {
    homepage = https://launchpad.net/onboard;
    description = "An onscreen keyboard useful for tablet PC users and for mobility impaired users.";
    license = stdenv.lib.licenses.gpl3;
  };
}
