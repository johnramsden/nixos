{ config, pkgs, ... }:

{
  ## Services ##
  services = {

    gnome3.gnome-keyring.enable = true;

    openssh.enable = true;

    xserver = {
      enable = true;
      layout = "us";

      # Tearing fix
      screenSection = ''
        Option  "metamodes" "nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
      '';

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

    /*pam.services = [
      { name = "gnome_keyring";
        text = ''
          auth     optional    ${pkgs.gnome3.gnome_keyring}/lib/security/pam_gnome_keyring.so
          session  optional    ${pkgs.gnome3.gnome_keyring}/lib/security/pam_gnome_keyring.so auto_start

          password	optional	${pkgs.gnome3.gnome_keyring}/lib/security/pam_gnome_keyring.so
        '';
      }
    ];*/
  };
}
