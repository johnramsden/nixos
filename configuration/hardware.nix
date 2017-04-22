{ config, pkgs, ... }:

{  ## Hardware ##

  hardware = {
    # Intel microcode
    cpu.intel.updateMicrocode = true;

    # Sound
    pulseaudio = {
      enable = true;
      support32Bit = true;
  };

    # acceleration for 32-bit programs
    opengl.driSupport32Bit = true;
  };

}
