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
      [ { device = "/dev/disk/by-uuid/de6bf709-e584-453f-a385-861af726c5bd"; }
      ];

}
