{ config, pkgs, ... }:

{

  virtualisation = {
    libvirtd.enable = true; # KVM enabled by default.
    libvirtd.qemuVerbatimConfig = ''
      nvram = [ "${pkgs.OVMF}/FV/OVMF_CODE.fd:${pkgs.OVMF}/FV/OVMF_VARS.fd" ]
      user = "john"
    '';
  };

  users.groups = {
    disks.members = [ "root" "john" ]; # For zvol ownership
    libvirtd.members = [ "root" "john" ];
    kvm.members = [ "john" ];
  };

  boot = {
    kernelParams = [ "intel_iommu=on" ];
    kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" "irqbypass" "kvm-intel"
                      "virtio" ]; # Add "tun" for qemu

    # PCI id's of graphics card
    extraModprobeConfig = ''
        options vfio-pci ids=8086:0c01,10de:13c2,10de:0fbb
    '';
  };

  services.udev.extraRules = let
    zfsUser = if config.boot.zfs.enableUnstable then pkgs.zfsUnstable else pkgs.zfs;
  in ''
  KERNEL=="zd*" SUBSYSTEM=="block" ACTION=="add|change" PROGRAM="${zfsUser}/lib/udev/zvol_id /dev/%k" RESULT=="vault/zvols/libvirt/kit" OWNER="john" GROUP="disk" MODE="0750"
  '';

  # Used with qemu.
  /*networking.interfaces.tap0 = {
    virtualOwner = "john";
    virtual = true;
    virtualType = "tap";
    useDHCP = true;
  };*/
  /*environment.etc."qemu/bridge.conf".text = "allow br0";*/
}
