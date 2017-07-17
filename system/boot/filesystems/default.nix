{ config, pkgs, ... }:

{
  imports =
  [
    ./zfs.nix
    ./nfs.nix
  ];

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/703c5f11-7616-45a5-a35d-93b229a02fc0";
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
    [ { device = "/dev/disk/by-uuid/57d3581a-508b-429c-8005-c5b589f3d9f9"; }
    ];
}
