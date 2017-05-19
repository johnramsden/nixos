{ config, pkgs, ... }:

{

  imports = [ ./lxc ];

  virtualisation = {
    libvirtd.enable = true;
    libvirtd.enableKVM = true;
  };

}
