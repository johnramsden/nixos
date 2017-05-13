{ config, pkgs, ... }:

{
  ## Main Network Configuration ##
  imports =
  [ # Default network setup, use this OR bridge
    ./network.nix
    # ./bridge.nix

    ./mail.nix
  ];

  ## Common Network Configuration ##
  networking = {
    hostName = "atom";
    hostId = "14ac0214";
    nameservers = [ "172.20.20.1" "8.8.8.8" ];
    domain = "ramsden.network";

    defaultGateway.address = "172.20.20.1";
  };

  time.timeZone = "Canada/Pacific";
}
