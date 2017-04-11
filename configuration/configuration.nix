{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./networking.nix
      ./software.nix
      ./services.nix
      ./users.nix
      ./boot.nix
    ];

  system.autoUpgrade.enable = true;

  # Select internationalisation properties.
  i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
  };

}
