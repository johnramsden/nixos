{ config, pkgs, ... }:

{
  ## Bootloader ##
  boot = {
    tmpOnTmpfs = true;
    cleanTmpDir = true;
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      systemd-boot.enable = true;
    };

    # Added for iommu
    kernelParams = [ "intel_iommu=on" ];

    # Do not forcefully importpool or root.
    zfs.forceImportAll = false;
    zfs.forceImportRoot = false;
    initrd.supportedFilesystems = [ "zfs" ];
    supportedFilesystems = [ "zfs" ];
  };

  fileSystems."/nix".neededForBoot = true;
  fileSystems."/nix/store".neededForBoot = true;
}
