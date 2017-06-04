{ config, pkgs, ... }:

{
  imports =
  [
    ./zfs.nix
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
    [ { device = "/dev/disk/by-uuid/8c1e09f7-b838-4b72-9902-d4176ebfee68"; }
    ];
}
