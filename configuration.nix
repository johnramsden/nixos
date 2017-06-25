{ config, pkgs, ... }:

# Repair tree: nix-store --verify --check-contents --repair
# Check dependencies: nix-store -q --tree $(nix-instantiate '<nixos/nixos>' -A system)

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
  # Build inside chroot
  nix.useSandbox = true;

  # Select internationalisation properties.
  i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
  };

}
