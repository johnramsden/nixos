{ config, pkgs, ... }:

{
    imports = [
      ./security.nix
      ./graphics.nix
      ./zfs
    ];

  ## Services ##
  services = {
    nylas-mail.enable = true;
    openssh.enable = true;
    rpcbind.enable = true;
    znapzend.enable = true;
    samba.enable = true;
    gnome3.at-spi2-core.enable = true;

    rsyslogd = {
      enable = true;
      extraConfig = ''
      '';
    };

    smartd = {
      enable = true;
      notifications.mail.enable = true;
    };

    /*zabbixAgent = {
      enable = false;
      server = "zabbix.ramsden.network";
    };*/

    journald.extraConfig = ''
      ForwardToSyslog=yes
      Storage=volatile
    '';

    logrotate = {
      enable = true;
      config = ''
        /var/log/messages {
          rotate 5
          weekly
          postrotate
              /run/current-system/sw/bin/systemctl restart rsyslogd
          endscript
        }
      '';
    };
  };



}
