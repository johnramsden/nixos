{ config, pkgs, ... }:

{

services.xserver = {
  enable = true;
  layout = "us";

  # Tearing fix when using nvidia
  #screenSection = ''Option  "metamodes" "nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"'';

  videoDrivers = [ "intel" ]; # Tried in order:

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
