{ config, pkgs, ... }:

{
  ## Services ##
  services.openssh.enable = true;

  services.xserver = {
      displayManager.sddm = {
      enable = true;
      autoLogin.user = "john";
    };
    desktopManager.kde5.enable = true;

    videoDrivers = [ "nvidia" ];

    enable = true;
    layout = "us";
   };

}
