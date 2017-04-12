{ config, pkgs, ... }:

{
  ## Services ##
  services.openssh.enable = true;

  services.xserver = {
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
          ''
      };
    desktopManager.plasma5.enable = true;

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
