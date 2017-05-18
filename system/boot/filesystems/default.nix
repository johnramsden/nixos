{ config, pkgs, ... }:

{
  imports =
  [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    #./zfs.nix
    ./nfs.nix
  ];

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/F2F4-47DC";
      fsType = "vfat";
    };

  fileSystems."/tmp" =
    { device = "tmpfs";
      fsType = "tmpfs";
    };

  fileSystems."/home/john/.cache/google-chrome" =
    { device = "tmpfs";
      fsType = "tmpfs";
      options = [ "uid=1000" "gid=100"];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/de6bf709-e584-453f-a385-861af726c5bd"; }
    ];

      fileSystems."/" =
        { device = "vault/sys/atom/ROOT/17.03";
          fsType = "zfs";
        };

      fileSystems."/nix" =
        { device = "vault/sys/atom/ROOT/17.03/nix";
          fsType = "zfs";
          neededForBoot = true;
        };

      fileSystems."/nix/store" =
        { device = "vault/sys/atom/ROOT/17.03/nix/store";
          fsType = "zfs";
          neededForBoot = true;
        };

      fileSystems."/var" =
        { device = "vault/sys/atom/ROOT/17.03/var";
          fsType = "zfs";
        };

      fileSystems."/var/lib" =
        { device = "vault/sys/atom/ROOT/17.03/var/lib";
          fsType = "zfs";
        };

      fileSystems."/var/log" =
        { device = "vault/sys/atom/var/log";
          fsType = "zfs";
        };

      fileSystems."/nix/.ro-store" =
        { device = "vault/sys/atom/ROOT/17.03/nix/ro-store";
          fsType = "zfs";
        };

      fileSystems."/var/log/journal" =
        { device = "vault/sys/atom/var/log/journal";
          fsType = "zfs";
        };

      fileSystems."/var/cache" =
        { device = "vault/sys/atom/var/cache";
          fsType = "zfs";
        };

      fileSystems."/var/lib/systemd" =
        { device = "vault/sys/atom/ROOT/17.03/var/lib/systemd";
          fsType = "zfs";
        };

      fileSystems."/nix/var" =
        { device = "vault/sys/atom/ROOT/17.03/nix/var";
          fsType = "zfs";
        };

      fileSystems."/var/lib/nixos" =
        { device = "vault/sys/atom/ROOT/17.03/var/lib/nixos";
          fsType = "zfs";
        };

      fileSystems."/home" =
        { device = "vault/sys/atom/home";
          fsType = "zfs";
        };

      fileSystems."/var/lib/lxc" =
        { device = "vault/sys/atom/var/lib/lxc";
          fsType = "zfs";
        };

      fileSystems."/nix/.rw-store" =
        { device = "vault/sys/atom/ROOT/17.03/nix/rw-store";
          fsType = "zfs";
        };

      fileSystems."/home/john" =
        { device = "vault/sys/atom/home/john";
          fsType = "zfs";
        };

      fileSystems."/var/lib/systemd/coredump" =
        { device = "vault/sys/atom/ROOT/17.03/var/lib/systemd/coredump";
          fsType = "zfs";
        };

      fileSystems."/nix/var/log" =
        { device = "vault/sys/atom/ROOT/17.03/nix/var/log";
          fsType = "zfs";
        };

      fileSystems."/nix/var/nix" =
        { device = "vault/sys/atom/ROOT/17.03/nix/var/nix";
          fsType = "zfs";
        };

      fileSystems."/home/john/.cache" =
        { device = "vault/sys/atom/home/john/cache";
          fsType = "zfs";
        };

      fileSystems."/home/john/.local" =
        { device = "vault/sys/atom/home/john/local";
          fsType = "zfs";
        };

      fileSystems."/home/john/.local/share/Steam" =
        { device = "vault/sys/atom/home/john/local/share/Steam";
          fsType = "zfs";
        };

      /*fileSystems."/var/lib/containers" =
        { device = "vault/sys/atom/ROOT/17.03/var/lib/containers";
          fsType = "zfs";
        };*/

        /*fileSystems."/home/john/.local/share/lxc" =
          { device = "vault/sys/atom/home/john/local/share/lxc";
            fsType = "zfs";
          };*/

      fileSystems."/home/john/.config" =
        { device = "vault/sys/atom/home/john/config";
          fsType = "zfs";
        };

      fileSystems."/home/john/University" =
        { device = "vault/data/University";
          fsType = "zfs";
        };

      fileSystems."/home/john/Books" =
        { device = "vault/data/Books";
          fsType = "zfs";
        };

      fileSystems."/home/john/Computer" =
        { device = "vault/data/Computer";
          fsType = "zfs";
        };

      fileSystems."/home/john/Personal" =
        { device = "vault/data/Personal";
          fsType = "zfs";
        };

      fileSystems."/home/john/Pictures" =
        { device = "vault/data/Pictures";
          fsType = "zfs";
        };

      fileSystems."/home/john/Reference" =
        { device = "vault/data/Reference";
          fsType = "zfs";
        };

      fileSystems."/home/john/Workspace" =
        { device = "vault/data/Workspace";
          fsType = "zfs";
        };

}
