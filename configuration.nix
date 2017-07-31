{ config, pkgs, ... }:

# Repair tree: nix-store --verify --check-contents --repair
# Check dependencies: nix-store -q --tree $(nix-instantiate '<nixos/nixos>' -A system)

{
  imports = [
      ./software
      ./system
      ./users
    ] ++ [ # Cherrypicked imports
#      ./nixpkgs/nixos/modules/programs/nylas-mail.nix
#      ./nixpkgs/nixos/modules/services/backup/znapzend.nix
    ];

#  system.autoUpgrade.enable = true;

  nix = {
    nixPath = [
        "/etc/nixos"
        "nixpkgs=/etc/nixos/nixpkgs"
        "nixos-config=/etc/nixos/configuration.nix"
    ];

    gc = { # Run Garbage Collecter nightly
      automatic = true;
      dates = "20:15";
    };
    # Build inside chroot
    useSandbox = true;
  };

  # Select internationalisation properties.
  i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
  };

}
