{ pkgs, lib, config, ... }:

# Edit the config file in /etc/zfs/zed.d
let
  zfsUser = if config.boot.zfs.enableUnstable then pkgs.zfsUnstable else pkgs.zfs;
  newcfg = pkgs.runCommand "newcfg" {} ''
    cp -vir ${zfsUser}/etc/zfs/zed.d/ $out
    chmod +w $out/zed.rc
    cat >> $out/zed.rc <<EOF
    ZED_EMAIL_ADDR="system@atom.ramsden.network"
    ZED_EMAIL_PROG="/run/wrappers/bin/sendmail"
    ZED_NOTIFY_VERBOSE=1
    EOF
  '';
in {
  environment.etc."zfs/zed.d".source = lib.mkForce newcfg;
  environment.pathsToLink = [ "/include/libzfs" ];
}
