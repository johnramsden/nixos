{ config, pkgs, ... }:

{

  imports = [ ./lxc ./iommu ];

  virtualisation = {
    libvirtd.enable = true;
    libvirtd.enableKVM = true;
  };

}
