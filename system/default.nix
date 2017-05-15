{ config, pkgs, ... }:

{
  imports =
  [
    ./services
    ./boot
    ./virtualization
    ./networking
  ];

}
