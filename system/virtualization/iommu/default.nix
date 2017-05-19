{ config, pkgs, ... }:

{
  boot = {

    kernelParams = [ "intel_iommu=on" ];
    kernelModules = [ "kvm-intel" "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ];

    # PCI id's of graphics card
    extraModprobeConfig = ''
        options vfio-pci ids=10de:13c2,10de:0fbb
    '';
  };
}
