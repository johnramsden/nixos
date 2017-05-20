{ config, pkgs, ... }:

{
  boot = {
    kernelParams = [ "intel_iommu=on" ];
    kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" "irqbypass" "kvm-intel" ];

    # PCI id's of graphics card
    extraModprobeConfig = ''
        options vfio-pci ids=10de:13c2,10de:0fbb
    '';
  };
}
