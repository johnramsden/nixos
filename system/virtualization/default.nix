{ config, pkgs, ... }:

{
  imports =
  [
    ./lxc
    #./iommu
  ];

  # General virtualization

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

  boot.kernelModules = [ "kvm-intel" ]; # Add "tun" for qemu

    services.udev.extraRules = let
      zfsUser = if config.boot.zfs.enableUnstable then pkgs.zfsUnstable else pkgs.zfs;
    in ''
    KERNEL=="zd*" SUBSYSTEM=="block" ACTION=="add|change" PROGRAM="${zfsUser}/lib/udev/zvol_id /dev/%k" RESULT=="vault/zvols/libvirt/kit" OWNER="john" GROUP="disk" MODE="0750"
    '';
}
