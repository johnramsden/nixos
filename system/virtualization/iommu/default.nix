{ config, pkgs, ... }:

{

  boot = {
    kernelParams = [ "intel_iommu=on" ];
    kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" "irqbypass" "virtio" ]; # Add "tun" for qemu

    # PCI id's of graphics card
    extraModprobeConfig = ''
        options vfio-pci ids=8086:0c01,10de:13c2,10de:0fbb
    '';
  };


  # Used with qemu.
  networking.interfaces.tap0 = {
    virtualOwner = "john";
    virtual = true;
    virtualType = "tap";
    useDHCP = true;
  };
  environment.etc."qemu/bridge.conf".text = "allow br0";
}
