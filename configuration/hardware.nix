{ config, pkgs, ... }:

{  ## Hardware ##

  hardware = {
    cpu.intel.updateMicrocode = true;
    pulseaudio.enable = true;
  };

}
