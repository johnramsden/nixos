{ config, pkgs, ... }:

{
  ## Services ##
  services.openssh.enable = true;

  services.xserver = {
      displayManager.sddm = {
      enable = true;
      autoLogin.user = "john";
    };
    desktopManager.plasma5 = true;

    videoDrivers = [ "nvidia" ];

    enable = true;
    layout = "us";
   };

   # ZFS
   services.zfs = {
#     autoScrub.enable = true;
#     autoScrub.interval = "monthly";
     autoSnapshot.enable = true;
     autoSnapshot.frequent = 30;
     autoSnapshot.hourly = 100;
   };

}
