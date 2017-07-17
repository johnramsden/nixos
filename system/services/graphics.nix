{ config, pkgs, ... }:

{

services.xserver = rec {
  enable = true;
  layout = "us";

  videoDrivers = [ "nvidia" ]; # Tried in order:
  # Tearing fix when using nvidia
  screenSection =
    if builtins.elem "nvidia" config.services.xserver.videoDrivers
    then  ''Option  "metamodes" "nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"''
    else '''';

  desktopManager.plasma5.enable = true;

  displayManager.sddm = {
    enable = true;
    autoLogin = {
      user = "john";
      enable = true;
    };
    extraConfig =
      ''
      [X11]
      # Arguments passed to the X server invocation
      ServerArguments=-nolisten tcp -dpi 192
      '';
  };
};

}
