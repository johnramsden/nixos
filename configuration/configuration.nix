{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./networking.nix
      ./users.nix
    ];

  system.autoUpgrade.enable = true;

  # Select internationalisation properties.
  i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
  };

  ## Packages ##
  nixpkgs.config.allowUnfree = true;
  # Packages installed in system profile.
  environment.systemPackages = with pkgs; [
      wget
      curl
      xvkbd
      google-chrome
  ];
  programs.zsh.enable = true;

  ## Services ##
  services.openssh.enable = true;

  services.xserver = {
      displayManager.sddm = {
      enable = true;
      autoLogin.user = "john";
    };
    desktopManager.kde5.enable = true;

    videoDrivers = [ "nvidia" ];

    enable = true;
    layout = "us";
   };

  ## Bootloader ##
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
}
