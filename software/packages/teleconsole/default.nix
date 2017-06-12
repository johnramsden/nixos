{ fetchurl, lib, pkgs, stdenv, config, makeWrapper }:

stdenv.mkDerivation rec {
  name = "${pkgname}-${version}";
  pkgname = "teleconsole";
  version = "0.3.1";

  src = fetchurl {
        url = "https://github.com/gravitational/teleconsole/releases/download/0.3.1/teleconsole-v0.3.1-linux-amd64.tar.gz";
        sha256 = "bcc08d8ea2c8a7ad01fb7a336c5f9ebd75b7b2624db9b0cc88c5f60b5c3e533b";
      };
buildInputs = [ makeWrapper ];
  setSourceRoot = "sourceRoot=`pwd`";

  installPhase = ''
    mkdir -p $out/bin
    mv ./teleconsole $out/bin/
    makeWrapper $out/bin/teleconsole $out/bin/teleconsole
  '';

  meta = with stdenv.lib; {
    description = "Teleconsole is a free service to share your terminal session with people you trust. Your friends can join via a command line via SSH or via their browser over HTTPS.";
    license = licenses.asl20;
    maintainers = with maintainers; [ johnramsden ];
    homepage = www.teleconsole.com;
    platforms = [ "x86_64-linux" ];
  };
}
