{ config, pkgs, ... }:

{
  imports =
  [
    ./services
    ./boot
    ./virtualization
    ./networking
  ];

  powerManagement.cpuFreqGovernor = "powersave";
}
