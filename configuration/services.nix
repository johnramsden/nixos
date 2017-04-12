{ config, pkgs, ... }:

{
  ## Services ##
  services = {
    openssh.enable = true;

    xserver = {
      enable = true;
      layout = "us";

      videoDrivers = [ "nvidia" ];

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

    zfs = {
      autoScrub.enable = true;
      autoScrub.interval = "monthly";
      autoSnapshot.enable = true;
      autoSnapshot.frequent = 30;
      autoSnapshot.hourly = 100;
    };

    autofs = {
      enable = true;
      autoMaster let
        mapConf = pkgs.writeText "auto" ''
          /net      -hosts      --timeout=60
        '';
      in ''
        /auto file:${mapConf}
      ''
    };
  };
}
