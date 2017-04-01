{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

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

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.xserver = {
    displayManager.sddm.enable = true;
    displayManager.sddm.autoLogin.user = "john";

    desktopManager.kde5.enable = true;

    videoDrivers = [ "nvidia" ];

    enable = true;
    layout = "us";
   };

  programs.zsh.enable = true;;
  environment.shells = pkgs zsh;

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

  boot.loader = {
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
    systemd-boot.enable = true;
  };

  # Bootloader settings
  boot.zfs.forceImportAll = false;
  boot.zfs.forceImportRoot = false;
  boot.initrd.supportedFilesystems = [ "zfs" ];
  boot.supportedFilesystems = [ "zfs" ];

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";

}
