{ config, pkgs, ... }:

{
  services.cgmanager.enable = true;

  virtualisation = {
    lxc = {
      enable = true;
      systemConfig = ''
        lxc.rootfs.backend = zfs
        lxc.lxcpath = /var/lib/lxc
        lxc.bdev.zfs.root = vault/sys/atom/var/lib/lxc
      '';
      # Allow john to make up to 10 veth type devices
      # to be created and added to the bridge called lxcbr0
      usernetConfig = ''
        john veth lxcbr0 10
      '';
    };
  };
}
