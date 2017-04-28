{ config, pkgs, ... }:

{  ## Hardware ##

  hardware = {
    # Intel microcode
    cpu.intel.updateMicrocode = true;

    # Sound
    pulseaudio = {
      enable = true;
      # 32bit ALSA apps integration, needed for steam
      support32Bit = true;
  };

    # Acceleration, audio for 32-bit programs, needed for steam
    opengl.driSupport32Bit = true;
  };

}
