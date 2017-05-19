{ config, lib, pkgs, ... }:

let
  baseMountPoint = "/mnt/lilan";
  serverMountPoint = "lilan.ramsden.network:/mnt/tank";

  devices = {
    mediaDevices = [ # Devices suffixes from baseMountPoint, serverMountPoint
      "media/Series/Series" "media/Series/Anime"
      "media/Series/Documentary" "media/Series/Lectures"
      "media/Series/Animated" "media/Series/Podcasts/Video"
      "media/Series/Podcasts/Audio" "media/Movies" "media/Music"
    ];

    differentMountPointDevices = [
      { mount = "Data";
        dev = "data/Atreides"; }

      { mount = "media/Downloading/Torrents";
        dev = "media/Torrents"; }
      { mount = "media/Downloading/Downloads/Complete";
        dev = "media/Downloads/Complete"; }
      { mount = "Downloading/Downloads/Incomplete";
        dev = "media/Downloads/Incomplete"; }
    ];
  };
in
{
    fileSystems =
      # Map mediaDevices over nfs configuration
      (map (dev:
        { mountPoint = "${baseMountPoint}/${dev}";
          device = "${serverMountPoint}/${dev}";
          fsType = "nfs";
          options = [ "noauto" "x-systemd.automount"
                      "x-systemd.device-timeout=175"
                      "timeo=15" "x-systemd.idle-timeout=1min" "user"
                    ];
        }) devices.mediaDevices) ++
      (map ({ mount, dev }:
        { mountPoint = "${baseMountPoint}/${mount}";
          device = "${serverMountPoint}/${dev}";
          fsType = "nfs";
          options = [ "noauto" "x-systemd.automount"
                      "x-systemd.device-timeout=175"
                      "timeo=15" "x-systemd.idle-timeout=1min" "user"
                    ];
        })  devices.differentMountPointDevices);
}
