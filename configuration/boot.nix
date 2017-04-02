{ config, pkgs, ... }:

{
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
