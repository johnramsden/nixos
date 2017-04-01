# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  system.stateVersion = "17.03";

  networking.hostName = "zero";
  networking.hostId = "14ac0214";

  # Select internationalisation properties.
  i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Canada/Pacific";

  nixpkgs.config.allowUnfree = true;

  # Packages installed in system profile.
  environment.systemPackages = with pkgs; [
      wget
      curl
      xvkbd
      google-chrome
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
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

  # Define a user account. Don't forget to set a password with ‘passwd’.

  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];

  users.extraUsers.john = {
        name = "john";
        group = "users";
        extraGroups = [ "wheel" "networkmanager" ];
        uid = 1000;
        home = "/home/john";
        shell = pkgs.zsh;
        openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDkkpuwZ+Pf7tdF1I6HzEnb9QsrFMywmNnosw5dC0uJVAj7+yCWPWNc2xVc+1b4584yYU474VtE3ly6XGLuXLw4FckCR8VHvTIBseP6nK0l/S9M7AAwbTf92lX3aeCOZFIczzyKQDBmx/YUqSBeTZKoc6e7XBtgMbuioEfsIsEwkSgZBl35X7UYqpJYVJcdDBF/FhwJsYHAv6Nkerp9NDH8T0xCFnxgOXC9XcfowLHDmCoqE3EwdiFRvH13kIhfCfP76NWxrfXo+nI3nXMFOM9KcPuG2XmtNHDKWGsfb5K9rTyR8vyxy+g9q6LKcyZzSvrAdiQT6eu8oveIsbfKjtAV john@skel" "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDeAoJGh3IoGZnZ4ZIXwll52bKt9SlsO/t4HwMWcp1zoLKY9VIKJorF3JKuNCjPQROdn9nOKHlsvfmAJwM/2+2ZMETcLnbdg8KFQnhKNZe5vMSuM5u8RkaqvH0UaTTPSC0DFC3DOFd/pCtPLjBOYgYvpn+m2+z3U6wz/5H7rWy9ikK4rwZqa4bhwY1yoGCfifW2pKIpFTnQJMtkNJ7yzgfpRg6mddVYDv8+PxVJrb3ALoTiADtUc8QzaNh4tvm4h2XfjN7qR+hD1ii7FG0oG9bBcSCV/9kHO8U21pETfGRh+VKktK09qxWMiM6pFG7aKHY7mIncvMzKJ/KvHNUgBo1L john@sloth" "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCw/E7zHW9O0o433VJXmHluDQsmscMcLXrIJYUm7Wqc2oU6jHGrrUFcQnlbjuZCtTokCDf9bwPHaYUq77dsWxd82j/wNEuQJKmiSInTMyAZmTG9zZM/sLofRUkQro0RCU+ZnqHDwT59Sq4kKVYUtpzOAY28SDnHXI+zw24RX/sclvV7+Io+TzHYie7mJmsjnEVub7PXhvleSJ81JNPfBphLcGQON+z0SCnbPCqRIl0XkaepKNj91XPH9zPbzTN0JYWrfSvqXwmXxYex2iGankFvYAlJb97mklkYGJ2ahVp3k7YDhH1UKdTzpPzFHBcv3hCV+aztpb86xrYvib7IJ+OF john@switchblade" ];
  };

  security.sudo.enable = true;

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
}
