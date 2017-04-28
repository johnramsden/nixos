{ config, pkgs, ... }:

{
  imports =
    [
      ./software
      ./system
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
