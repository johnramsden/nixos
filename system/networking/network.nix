{ config, pkgs, ... }:

{
  ## Main Network Configuration ##
  networking = {
    defaultGateway.interface = "eno1";

    interfaces.eno1.ip4 = [
      { address = "172.20.20.2";  prefixLength = 24; }
    ];
  };
}
