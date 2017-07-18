{ config
, fetchurl
, atspiSupport ? true, at_spi2_core ? null
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
, stdenv
, bash
, intltool
, glib
, gobjectIntrospection
, gsettings_desktop_schemas
, wrapGAppsHook
, makeWrapper
, yelp
}:

python3.pkgs.buildPythonApplication rec {
  name = "onboard-${version}";
  majorVersion = "1.4";
  version = "${majorVersion}.1";
  src = fetchurl {
    url = "https://launchpad.net/onboard/${majorVersion}/${version}/+download/${name}.tar.gz";
    sha256 = "01cae1ac5b1ef1ab985bd2d2d79ded6fc99ee04b1535cc1bb191e43a231a3865";
  };

  #doCheck = false;

  buildInputs = [
    glib gobjectIntrospection gsettings_desktop_schemas gnome3.dconf wrapGAppsHook makeWrapper
    python3.pkgs.distutils_extra
    gtk3
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
    python3.pkgs.pycairo
    python3.pkgs.dbus-python
    python3.pkgs.pygobject3
    python3.pkgs.systemd
    python3.pkgs.distutils_extra
    python3.pkgs.pyatspi
    glib
  ] ++ stdenv.lib.optional atspiSupport at_spi2_core;

  preBuild = ''
    rm -r Onboard/pypredict/attic

    substituteInPlace  ./scripts/sokSettings.py \
    --replace "#!/usr/bin/python3" "" \
    --replace "PYTHON_EXECUTABLE," "\"$out/bin/onboard-settings\"" \
    --replace '"-cfrom Onboard.settings import Settings\ns = Settings(False)"' ""

    chmod -x ./scripts/sokSettings.py

    for dir in ". ./Onboard/ ./scripts/ ./Onboard/test/ ./Onboard/pypredict/
    ./Onboard/pypredict/lm/ ./Onboard/pypredict/test/ ./Onboard/pypredict/tools/";
    do patchShebangs $dir; done

    substituteInPlace  ./Onboard/LanguageSupport.py \
    --replace "/usr/share/xml/iso-codes" "${isocodes}/share/xml/iso-codes" \
    --replace "/usr/bin/yelp" "${yelp}/bin/yelp"

    substituteInPlace  ./Onboard/Indicator.py \
    --replace   "/usr/bin/yelp" "${yelp}/bin/yelp"

    substituteInPlace  ./gnome/Onboard_Indicator@onboard.org/extension.js \
    --replace "/usr/bin/yelp" "${yelp}/bin/yelp"

    substituteInPlace  ./Onboard/SpellChecker.py \
    --replace "/usr/share/hunspell" ${hunspell}/bin/hunspell \
    --replace "/usr/lib" "$out/lib"

    substituteInPlace  ./data/org.onboard.Onboard.service  \
    --replace "/usr/bin" "$out/bin"

    substituteInPlace  ./Onboard/utils.py \
    --replace "/usr/share" "$out/share"
    substituteInPlace  ./onboard-defaults.conf.example \
    --replace "/usr/share" "$out/share"
    substituteInPlace  ./Onboard/Config.py \
    --replace "/usr/share/onboard" "$out/share/onboard"

    substituteInPlace  ./Onboard/WordSuggestions.py \
    --replace "/usr/bin" "$out/bin"

    substituteInPlace  ./setup.py \
    --replace "/bin/bash" ${stdenv.shell}
    substituteInPlace  ./Onboard/TextDomain.py \
    --replace "/bin/bash" "${stdenv.shell}"
  '';

  postInstall = ''
    mkdir -p $out/share/glib-2.0/schemas/ $out/lib/girepository-1.0
    cp onboard-default-settings.gschema.override.example $out/share/glib-2.0/schemas/10_onboard-default-settings.gschema.override

    ${glib.dev}/bin/glib-compile-schemas $out/share/glib-2.0/schemas/

    addToSearchPath GI_TYPELIB_PATH $out/lib/girepository-1.0
    addToSearchPath XDG_DATA_DIRS $out/share

    wrapProgram $out/bin/onboard \
        --prefix "LD_LIBRARY_PATH" : "${stdenv.lib.makeLibraryPath [
                                                        gtk3
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
                                                        python3.pkgs.pycairo
                                                        python3.pkgs.dbus-python
                                                        python3.pkgs.pygobject3
                                                        python3.pkgs.systemd
                                                        python3.pkgs.distutils_extra
                                                        python3.pkgs.pyatspi
                                                        glib ]}"
  '';

  meta = {
    homepage = https://launchpad.net/onboard;
    description = "An onscreen keyboard useful for tablet PC users and for mobility impaired users.";
    longDescription = ''
      An onscreen keyboard useful for tablet PC users and for mobility impaired users.
      In order to save settings, add pkgs.gnome3.dconf to environment.systemPackages.
      Additional settings can be changed with dconf.
      For example, to turn on key labels:
      dconf write /org/onboard/keyboard/show-secondary-labels true
      For word prediction enable atspiSupport
      To get rid of org.a11y.Bus warning enable "services.gnome3.at-spi2-core.enable = true"
    '';
    maintainers = with stdenv.lib.maintainers; [ johnramsden ];
    license = stdenv.lib.licenses.gpl3;
  };
}
