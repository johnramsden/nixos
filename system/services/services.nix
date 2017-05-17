{ config, pkgs, ... }:

{

  ## Services ##
  services = {
    openssh.enable = true;
    rpcbind.enable = true;
    znapzend.enable = true;

    xserver = {
      enable = true;
      layout = "us";

      # Tearing fix
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

    smartd = {
      enable = true;
      notifications.mail.enable = true;
    };
  };

  security = {

    sudo = {
      enable = true;
      extraConfig = ''
          # Change editor
        Defaults editor=${pkgs.nano}/bin/nano

        # Dont log sudo for ZFS commands
        Cmnd_Alias ZFS = ${pkgs.zfs}/sbin/zfs, ${pkgs.zfs}/sbin/zpool
        Defaults!ZFS !syslog

        # Time before retyping password
        Defaults        env_reset,timestamp_timeout=1500

        # Allow running zfs list and zpool list passwordless
        john ALL=NOPASSWD: ${pkgs.zfs}/sbin/zfs list*, ${pkgs.zfs}/sbin/zpool list*, ${pkgs.zfs}/sbin/zpool status*
      '';
    };
  };
}