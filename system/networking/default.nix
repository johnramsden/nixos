{ config, pkgs, lib, ... }:

let
  useBridge = true;
  ip = { address = "172.20.20.2"; prefixLength = 24; };
in

{

  ## Common Network Configuration ##
  imports =
  [ # Default network setup, use this OR bridge
    #./network.nix
    #./bridge.nix
    ./mail.nix
  ];

  networking = lib.recursiveUpdate {
    hostName = "atom";
    hostId = "14ac0214";
    nameservers = [ "172.20.20.1" "8.8.8.8" ];
    domain = "ramsden.network";
    defaultGateway.address = "172.20.20.1";

  } (if useBridge then {
    defaultGateway.interface = "br0";
    bridges.br0.interfaces = [ "eno1" ];
    interfaces.br0 = {
      virtual = true;
      ip4 = [ ip ];
    };
  } else {
    defaultGateway.interface = "eno1";
    interfaces.eno1.ip4 = [ ip ];
  });

  time.timeZone = "Canada/Pacific";
}
