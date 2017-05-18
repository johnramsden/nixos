{ config, pkgs, ... }:

{

  ## Security ##
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
