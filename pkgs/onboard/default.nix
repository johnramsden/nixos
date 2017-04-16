with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "onboard-${version}";
  version = "1.4.1";
  src = fetchurl {
    url = "https://launchpad.net/onboard/1.4/${version}/+download/${name}.tar.gz";
    sha256 = "01cae1ac5b1ef1ab985bd2d2d79ded6fc99ee04b1535cc1bb191e43a231a3865";
  };

  buildInputs = [ "gtk3"
                 "python3"
                 "hunspell"
                 "isocodes"
                 "libcanberra_gtk3"
                 "xorg.libxkbfile"
                 "python35Packages.pycairo"
                 "python35Packages.dbus-python"
                 "python35Packages.pygobject3"
                 "python35Packages.systemd"
                 "libudev"
                 "python35Packages.distutils_extra" ];

  buildPhase = ''
    python3 "./setup.py" build
  '';
  installPhase = ''
    python3 "./setup.py" install --prefix=$out
  '';

  meta = with stdenv.lib; {
    homepage = https://launchpad.net/onboard;
    description = "An onscreen keyboard useful for tablet PC users and for mobility impaired users.";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
