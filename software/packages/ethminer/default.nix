{ fetchurl, lib, pkgs, stdenv, makeWrapper }:

#, opencl-headers, opencl-info

stdenv.mkDerivation rec {
  name = "${pkgname}-${version}";
  pkgname = "ethminer";
  version = "0.11.0";

  src =
    fetchurl {
      url = "https://github.com/ethereum-mining/ethminer/releases/download/v${version}/${pkgname}-${version}-Linux.tar.gz";
      sha256 = "b4219dd45d602430b062cc830d2bc6fa065ab82bdbbc43f3deb165cc7001143b";
    };

    buildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    mv ethminer $out/bin

    # Patch binaries
    binrp=$(patchelf --print-rpath $out/bin/ethminer)
    patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath $binrp:$out/lib:${stdenv.cc.cc.lib} $out/bin/ethminer

      wrapProgram $out/bin/ethminer \
        --set LD_LIBRARY_PATH "${lib.makeLibraryPath [
            stdenv.cc.cc.lib
          ]}"
  '';

meta = with stdenv.lib; {
    description = "Ethereum miner with OpenCL, CUDA and stratum support";
    homepage = https://github.com/ethereum-mining/ethminer;
    platforms = [ "x86_64-linux" ];
  };
}
