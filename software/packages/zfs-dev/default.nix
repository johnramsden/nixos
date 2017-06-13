{ pkgs, lib, config, ... }:

# Edit the config file in /etc/zfs/zed.d
let

in
{

stdenv.mkDerivation rec {
  name = "${pkgname}";
  pkgname = "zfs-dev";

  install = ''
    mkdir -p $out

    cp -r ${pkgs.zfs} $out

  '';


}
