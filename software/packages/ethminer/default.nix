{ fetchurl, lib, pkgs, stdenv
, fetchFromGitHub
, cryptopp
, cmake
, jsoncpp
, libjson_rpc_cpp
, curl
, boost
, leveldb
, libcpuid
, opencl-headers
, ocl-icd
, miniupnpc
, libmicrohttpd
, gmp
, mesa
, makeWrapper
, extraCmakeFlags ? []
}:

stdenv.mkDerivation rec {
  name = "${pkgname}-${version}";
  pkgname = "ethminer";
  version = "0.11.0";
  src =
    fetchFromGitHub {
      owner = "ethereum-mining";
    repo = "ethminer";
    rev = "ea1e122faa09d749ec0efe4b933408b43e516663";
    sha256 = "08z35pwlbrvd637i42kwy85krgs1gb3vba7i4vf9h17r783cw2sg";
  };


    cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release" extraCmakeFlags ];

    configurePhase = ''
      export BOOST_INCLUDEDIR=${boost.dev}/include
      export BOOST_LIBRARYDIR=${boost.out}/lib
      mkdir -p build/install

      pushd build

      cmake .. -DCMAKE_INSTALL_PREFIX=$(pwd)/install $cmakeFlags
    '';

    enableParallelBuilding = true;

    runPath = with stdenv.lib; makeLibraryPath ([ stdenv.cc.cc ] ++ buildInputs);

    installPhase = ''
      make install
      mkdir -p $out
      for f in install/lib/*.so* $(find install/bin -executable -type f); do
        patchelf --set-rpath $runPath:$out/lib $f
      done
      cp -r install/* $out
    '';

    buildInputs = [
      cmake
      jsoncpp
      libjson_rpc_cpp
      curl
      boost
      leveldb
      cryptopp
      libcpuid
      opencl-headers
      ocl-icd
      miniupnpc
      libmicrohttpd
      gmp
      mesa
    ];

    dontStrip = true;

meta = with stdenv.lib; {
    description = "Ethereum miner with OpenCL, CUDA and stratum support";
    homepage = https://github.com/ethereum-mining/ethminer;
    platforms = [ "x86_64-linux" ];
  };
}
