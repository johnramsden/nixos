{ config, pkgs, ... }:
  # system/services/zfs
{
    imports = [ ./zfs-zed ];

    # ZED Config edit
    systemd.services.zfs-zed.enable = true;

    services.zfs = {
      autoScrub.enable = true;
      autoScrub.interval = "monthly";
      autoSnapshot.enable = true;
    };

}
