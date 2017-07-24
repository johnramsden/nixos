{ fetchurl, lib, pkgs, stdenv, makeWrapper }:

#

stdenv.mkDerivation rec {
  name = "${pkgname}-${version}";
  pkgname = "claymore";
  version = "9.7";
  src =
    fetchurl {
      url = "https://github.com/nanopool/Claymore-Dual-Miner/releases/download/v${version}/Claymore.s.Dual.Ethereum.Decred_Siacoin_Lbry_Pascal.AMD.NVIDIA.GPU.Miner.v${version}.-.LINUX.tar.gz";
      sha256 = "36bbc8d77cc2ba2d6bf5328fafc513a8a4b83cff5f2880be5253a70e33c62a50";
    };

  phases = [ "unpackPhase" ];

  buildInputs = [ makeWrapper ];

  unpackPhase = ''
    mkdir -p $out/bin
    tar xvf $src > /dev/null

    mv ./* $out/bin

    # Patch binaries
    binrp=$(patchelf --print-rpath $out/bin/ethdcrminer64)
    patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath $binrp:$out/lib:${stdenv.cc.cc.lib} $out/bin/ethdcrminer64

      wrapProgram $out/bin/ethdcrminer64 \
        --set LD_LIBRARY_PATH "${lib.makeLibraryPath [
            stdenv.cc.cc.lib
          ]}"
  '';

meta = with stdenv.lib; {
    description = "Ethereum miner with OpenCL, CUDA and stratum support";
    homepage = https://github.com/nanopool/Claymore-Dual-Miner;
    platforms = [ "x86_64-linux" ];
  };
}
