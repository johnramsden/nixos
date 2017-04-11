{ config, pkgs, ... }:

{
  networking = {
    hostName = "atom";
    hostId = "14ac0214";

    defaultGateway = {
      address = "172.20.20.2;
      interface = "eno1"
    };

  };

  time.timeZone = "Canada/Pacific";
}
