{ config, pkgs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix
    ./services.nix
    ./hardware.nix
    ./boot.nix
    ./virtualisation
    ./networking
  ];

}
