{ config, pkgs, ... }:

{
  imports =
    [
      ./configuration/hardware-configuration.nix
      ./configuration/hardware.nix
      ./configuration/networking.nix
      ./configuration/software.nix
      ./configuration/services.nix
      ./configuration/users.nix
      ./configuration/boot.nix
    ];

  system.autoUpgrade.enable = true;

  # Select internationalisation properties.
  i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
  };

}
