{ config, pkgs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix
    ./networking.nix
    ./services.nix
    ./hardware.nix
    ./boot.nix
    ./virtualisation
  ];

}
