{ config, pkgs, ... }:

{
  networking = {
    hostName = "atom";
    hostId = "14ac0214";
  };

  time.timeZone = "Canada/Pacific";
}
