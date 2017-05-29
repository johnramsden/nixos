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
, glib
, gobjectIntrospection
, gsettings_desktop_schemas
, wrapGAppsHook
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
    python35Packages.pyatspi
    python35Packages.pygobject3
    glib
    gobjectIntrospection
    gsettings_desktop_schemas
    wrapGAppsHook
  ];

  preBuild = ''
    rm -r Onboard/pypredict/attic

    patchShebangs .
    patchShebangs ./Onboard/
    patchShebangs ./scripts/
    patchShebangs ./Onboard/test/
    patchShebangs ./Onboard/pypredict/
    patchShebangs ./Onboard/pypredict/lm/
    patchShebangs ./Onboard/pypredict/test/
    patchShebangs ./Onboard/pypredict/tools/

    substituteInPlace  ./Onboard/LanguageSupport.py --replace "/usr/share/xml/iso-codes" ${isocodes}/share/xml/iso-codes

    substituteInPlace  ./Onboard/LanguageSupport.py --replace /usr/bin/yelp ${pkgs.yelp}/bin/yelp
    substituteInPlace  ./Onboard/Indicator.py --replace   /usr/bin/yelp ${pkgs.yelp}/bin/yelp
    substituteInPlace  ./gnome/Onboard_Indicator@onboard.org/extension.js --replace /usr/bin/yelp ${pkgs.yelp}/bin/yelp
    substituteInPlace  ./Onboard/SpellChecker.py --replace "/usr/share/hunspell" ${pkgs.hunspell}/bin/hunspell

    substituteInPlace  ./data/org.onboard.Onboard.service  --replace "/usr/bin" "out/bin"
    substituteInPlace  ./Onboard/utils.py --replace "/usr/share" "out/share"
    substituteInPlace  ./onboard-defaults.conf.example --replace "/usr/share" "out/share"
    substituteInPlace  ./Onboard/Config.py --replace "/usr/share/onboard" "$out/share/onboard"

    substituteInPlace  ./Onboard/WordSuggestions.py --replace "/usr/bin" "out/bin"

    substituteInPlace  ./setup.py --replace /bin/bash ${stdenv.shell}
    substituteInPlace  ./Onboard/TextDomain.py --replace /bin/bash ${stdenv.shell}
  '';

  postInstall = ''
    cp onboard-default-settings.gschema.override.example $out/share/glib-2.0/schemas/10_onboard-default-settings.gschema.override
    ${glib.dev}/bin/glib-compile-schemas $out/share/glib-2.0/schemas/

    addToSearchPath GI_TYPELIB_PATH $out/lib/girepository-1.0
    addToSearchPath XDG_DATA_DIRS $out/share
    '';

  meta = {
    homepage = https://launchpad.net/onboard;
    description = "An onscreen keyboard useful for tablet PC users and for mobility impaired users.";
    license = stdenv.lib.licenses.gpl3;
  };
}
