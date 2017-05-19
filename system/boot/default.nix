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

    # Add for iommu
    kernelParams = [ "intel_iommu=on" ];
    kernelModules = [ "kvm-intel" "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ];

    initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci"
                                      "usb_storage" "usbhid" "sd_mod" "sr_mod" ];

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
