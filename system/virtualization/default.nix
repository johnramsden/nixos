{ config, pkgs, ... }:

{
  imports = [ ./lxc ./iommu ];
}
