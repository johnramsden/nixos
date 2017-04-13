{ config, pkgs, ... }:

{  ## Hardware ##

  hardware = {
    cpu.intel.updateMicrocode = true;
    pulseaudio.enable = true;
    
    # acceleration for 32-bit programs
    opengl.driSupport32Bit = true;
  };

}
