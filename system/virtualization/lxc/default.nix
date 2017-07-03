{ config, pkgs, ... }:

{

  virtualisation.lxc = {
      enable = true;
      defaultConfig = ''
        lxc.include = ${pkgs.lxcfs}/share/lxc/config/common.conf.d/00-lxcfs.conf
        lxc.network.type = veth
        lxc.network.link = br0
      '';
      systemConfig = ''
        lxc.rootfs.backend = zfs
        lxc.lxcpath = /var/lib/lxc
        lxc.bdev.zfs.root = vault/sys/atom/var/lib/lxc
      '';

      # The following required for Unprivlidged guests:
      # Allow john to make up to 10 veth type devices on br0
      usernetConfig = "john veth br0 10";
      lxcfs.enable = true;
  };

  services.cgmanager.enable = true;
  security.apparmor.enable = true;

  # Containers to mount at boot:
  fileSystems."/var/lib/lxc/pop/rootfs" =
    { device = "vault/sys/atom/var/lib/lxc/pop";
      fsType = "zfs";
    };
  fileSystems."/var/lib/lxc/centos-builder/rootfs" =
    { device = "vault/sys/atom/var/lib/lxc/centos-builder";
      fsType = "zfs";
    };

    fileSystems."/var/lib/lxc/bez/rootfs" =
      { device = "vault/sys/atom/var/lib/lxc/bez";
        fsType = "zfs";
      };
}
