{ config, pkgs, ... }:

{
  virtualisation = {
    lxc = {
      enable = true;
      systemConfig = ''
        lxc.rootfs.backend = zfs
        lxc.lxcpath = /var/lib/lxc
        lxc.bdev.zfs.root = vault/sys/atom/var/lib/lxc
      '';
    };
  };
}
