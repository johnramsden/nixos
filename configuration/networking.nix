{ config, pkgs, ... }:

{
  networking = {
    hostName = "zero";
    hostId = "14ac0214";
  };

  time.timeZone = "Canada/Pacific";
}
