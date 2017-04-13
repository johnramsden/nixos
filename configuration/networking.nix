{ config, pkgs, ... }:

{
  ## Main Network Configuration ##
  networking = {
    hostName = "atom";
    hostId = "14ac0214";

    defaultGateway = {
      address = "172.20.20.1";
      interface = "eno1";
    };

    domain = "ramsden.network";

    interfaces.eno1.ip4 = [ { address = "172.20.20.2"; prefixLength = 24; } ];

    nameservers = [ "172.20.20.1" "8.8.8.8" ];
  };

  time.timeZone = "Canada/Pacific";

  ## Network Services ##
  services = {
    rpcbind.enable = true;

    autofs = {
      enable = true;
      debug = true;
      autoMaster = ''
      #
# Sample auto.master file
# This is a 'master' automounter map and it has the following format:
# mount-point [map-type[,format]:]map [options]
# For details of the format look at auto.master(5).
#
#/misc  /etc/autofs/auto.misc
/net      -hosts      --timeout=60
#
# NOTE: mounts done from a hosts map will be mounted with the
#       "nosuid" and "nodev" options unless the "suid" and "dev"
#       options are explicitly given.
#
/net    -hosts
#
# Include /etc/autofs/auto.master.d/*.autofs
# The included files must conform to the format of this file.
#
+dir:/etc/autofs/auto.master.d
#
# Include central master map if it can be found using
# nsswitch sources.
#
# Note that if there are entries for /net or /misc (as
# above) in the included master map any keys that are the
# same will not be seen as the first read key seen takes
# precedence.
#
+auto.master
      '';
    };
  };

  ## Systemd Network Mounts ##
#  systemd.automounts = [ ];

}
