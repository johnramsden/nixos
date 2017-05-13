{ config, pkgs, ... }:

{
  ## Main Network Configuration ##
  networking = {
    defaultGateway.interface = "br0";

    bridges.br0.interfaces = [ "eno1" ];
    interfaces.br0 = {
      virtual = true;
      ip4 = [ { address = "172.20.20.2"; prefixLength = 24; } ];
    };

  };
}
