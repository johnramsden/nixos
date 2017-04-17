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
      ./configuration/oh-my-zsh

      ./users
    ];

  system.autoUpgrade.enable = true;

  nix.gc = { # Run Garbage Collecter nightly
    automatic = true;
    dates = "20:15";
  };

  # Select internationalisation properties.
  i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
  };

}
