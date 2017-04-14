{ config, pkgs, ... }:

{
  ## Main Network Configuration ##
  networking = {
    hostName = "atom";
    hostId = "14ac0214";
    defaultGateway = { address = "172.20.20.1"; interface = "eno1"; };
    interfaces.eno1.ip4 = [ { address = "172.20.20.2"; prefixLength = 24; } ];
    nameservers = [ "172.20.20.1" "8.8.8.8" ];
    domain = "ramsden.network";
  };

  time.timeZone = "Canada/Pacific";

  ## Network Services ##
  services = {
    rpcbind.enable = true;

  };

  ## Systemd Network Mounts ##
  systemd.mounts = [
    { documentation = [ "https://www.freedesktop.org/software/systemd/man/systemd.mount.html" ];
      description = "NFS mount unit for Series/Series on lilan";
      what = "lilan.ramsden.network:/mnt/tank/media/Series/Series";
      where = "/mnt/lilan/media/Series/Series";
      type = "nfs";
      mountConfig = {
        TimeoutSec = "175";
        Options = "timeo=15,user,noauto";
      };
    }
  ];

  systemd.automounts = [
    { documentation = [ "https://www.freedesktop.org/software/systemd/man/systemd.automount.html" ];
      description = "NFS automount for Series/Series on lilan";
      where = "/mnt/lilan/media/Series/Series";
      automountConfig = { TimeoutIdleSec = "175"; };
    }
  ];

}
