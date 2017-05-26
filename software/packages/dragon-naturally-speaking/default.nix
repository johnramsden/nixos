{ stdenv, fetchurl, innoextract, wine, writeScript }:
# Sources:
# https://github.com/openlab-aux/vuizvui/blob/97e440e996e9c418e46af3dbcdba58595b5c11ea/pkgs/aszlig/santander/default.nix
# https://github.com/jraygauthier/nixpkgs/blob/ae2b897345969ed498c09a3e8290f24ac76f12bc/pkgs/applications/office/ynab/default.nix#L14
# https://github.com/NixOS/nixpkgs/issues/10165
let
  version = "15";
  applicationName = "dragon-naturally-speaking";
  wrapped = stdenv.mkDerivation {
    name = "${applicationName}-wrapper-${version}";

    src = fetchurl {
      url = "https://github.com/johnramsden/NixOS/tree/master/software/packages/${applicationName}/source/${applicationName}-15.exe";
      sha256 = "1cd3e877993200ef6321b9be3a6d877c97e9f6b8f97ac9574f6726d30f32320a";
    };


    installPhase = ''
        mkdir -p $out/share/${applicationName}
        cp -r ./* $out/share/${applicationName}
    '';
  };

  # Assume a default wine bottle location. If `WINEPREFIX`
  # environment variable is set, this will define the
  # location of our bottle.
  # Make sure the wine bottle gets initialized before we lauch the program so
  # that we have the oppotunity to perform our fix.
  wineCheck = ''
    WINE_BOTTLE=$HOME/.wine
    [ -z ${WINEPREFIX+x} ] || WINE_BOTTLE=$WINEPREFIX

    [ -d $WINE_BOTTLE ] || (command -v wineboot > /dev/null && wineboot -i) || \
      { echo "ERROR! Wine bottle does not exists and *wineboot* command is unavailable."; exit 1; }
  '';

  /*
    Provide wine environement to the application without polluting
    the whole profile with all wine's files and executables.
    Adapt the expected file argument so that it points to the file
    through the `Z:\` drive using windows style paths.
    TODO: Opening a file with relative path does not work. Is
    that expected? Could be that wine does not adapt the current
    working directory so that it passes through `Z:\` or that
    this does not even work on windows.
  */
  /*dnsWrapper = writeScript "dns_wrapper.sh" ''
    export LD_LIBRARY_PATH=${wine}}/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
    export PATH=${wine}/bin''${PATH:+:$PATH}
    ${wineCheck}
    env WINEPREFIX=$WINE_BOTTLE/${applicationName} ${wrapped}/share/${applicationName}/${applicationName}-15.exe
  '';*/

in

stdenv.mkDerivation {
  name = "${applicationName}-${version}";

  src = ./.;

  buildInputs = [ wine wrapped ];

  installPhase = ''
    env WINEPREFIX=$WINE_BOTTLE/${applicationName} ${wrapped}/share/${applicationName}/${applicationName}-15.exe
  '';

  meta = {
    description = "Proprietary dictation software";
    homepage = http://nuance.com;
    platforms = stdenv.lib.platforms.linux;
    license = stdenv.lib.licenses.unfree;
  };

}
