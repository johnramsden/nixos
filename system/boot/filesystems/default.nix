{ config, pkgs, ... }:

{
  imports =
  [
    ./zfs.nix
    ./nfs.nix
  ];

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/76FB-29B1";
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
    [ { device = "/dev/disk/by-uuid/0085a164-b47f-4b29-8750-c04fa197e9f9"; }
    ];
}
