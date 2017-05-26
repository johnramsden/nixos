{ config, pkgs, ... }:

{
    imports = [ ./security.nix ./graphics.nix ./zfs ];

  ## Services ##
  services = {
    openssh.enable = true;
    rpcbind.enable = true;
    znapzend.enable = true;
    samba.enable = true;
    
    smartd = {
      enable = true;
      notifications.mail.enable = true;
    };
  };

}
