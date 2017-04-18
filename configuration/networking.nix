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
    znapzend.enable = true;
  };

  ## Network Mounts ##

}
