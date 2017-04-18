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
    };
  };

  security.sudo.extraConfig = ''
      # Change editor
    Defaults editor=/usr/bin/nano

    # Allow running zfs list and zpool list passwordless
    john ALL=(ALL) NOPASSWD: /usr/bin/zfs list
    john ALL=(ALL) NOPASSWD: /usr/bin/zpool list
    john ALL=(ALL) NOPASSWD: /usr/bin/zpool status

    # Dont log sudo for ZFS commands
    Cmnd_Alias ZFS = /usr/bin/zfs, /usr/bin/zpool
    Defaults!ZFS !syslog

    # Time before retyping password
    Defaults        env_reset,timestamp_timeout=300
  '';
}
