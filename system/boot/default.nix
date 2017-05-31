{ config, pkgs, ... }:

{

  imports = [
    # Add Firmware
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ./filesystems
  ];

  hardware.cpu.intel.updateMicrocode = true;

  boot = {
    tmpOnTmpfs = true;
    cleanTmpDir = true;
    loader = { # Bootloader
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      systemd-boot.enable = true;
    };

    initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci"
                                      "usb_storage" "usbhid" "sd_mod" "sr_mod" ];

    # If using intel, blacklist nvidia
    blacklistedKernelModules =
      if builtins.elem "intel" config.services.xserver.videoDrivers
      then [ "nouveau" "nvidia" "nvidiafb" ]
      else [];

    # Do not forcefully importpool or root.
    zfs.forceImportAll = false;
    zfs.forceImportRoot = false;
    initrd.supportedFilesystems = [ "zfs" ];

    # Sysctls
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 204800; # For syncthing inotify
    };
  };
}
