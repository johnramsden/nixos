{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  system.stateVersion = "16.09";

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "zero";
  networking.hostId = "9abd29be";

  # Select internationalisation properties.
  i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Canada/Pacific";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
      wget
      curl
      google-chrome
  ];

  # List services that you want to enable:
  services.openssh.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    videoDrivers = [ "nvidia" ];

    displayManager.sddm = {
      enable = true;
      autoLogin.enable = true;
      autoLogin.user = "john";
    };
    desktopManager.kde5.enable = true;
  };

  programs.zsh.enable = true;;
  environment.shells = pkgs.zsh;

   users = {
      defaultUserShell = pkgs.sh;

      users.john = {
         name = "john";
         group = "users";
         extraGroups = ["wheel" "networkmanager"];
         uid = 1000;
         home = "/home/john";
         shell = pkgs.zsh;
      };

   };

  security = {
    sudo.enable = true;
  };

  boot.

  # Bootloader settings
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      systemd-boot.enable = true;
    };

    zfs.forceImportAll = false;
    zfs.forceImportRoot = false;
    initrd.supportedFilesystems = [ "zfs" ];
    supportedFilesystems = [ "zfs" ];
  };
};
