{ config, pkgs, ... }:

{
  networking = {
    hostName = "atom";
    hostId = "14ac0214";

    defaultGateway = {
      address = "172.20.20.1";
      interface = "eno1";
    };
    
    domain = "ramsden.network";

    interfaces = {
      eno1 = {
        ip4 = [ { address = "172.20.20.2"; prefixLength = 24; } ];
      };
    };

  };

  time.timeZone = "Canada/Pacific";
}
