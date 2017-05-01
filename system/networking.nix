{ config, pkgs, ... }:

{
  ## Main Network Configuration ##
  networking = {
    hostName = "atom";
    hostId = "14ac0214";
    defaultGateway = { address = "172.20.20.1"; interface = "eno1"; };
    interfaces.eno1.ip4 = [ { address = "172.20.20.2"; prefixLength = 24; } ];
    nameservers = [ "172.20.20.1" "8.8.8.8" ];
    domain = "ramsden.network";

    # SSMTP Configuration
    defaultMailServer = {
      directDelivery = true;
      root = "system@atom.ramsden.network";
      domain = "fastmail.com";
      authUser = "ramsdenj@fastmail.com";
      authPass = builtins.readFile /etc/nixos/secrets/ssmtp/password;
      hostName = "mail.messagingengine.com:465";
      useTLS = true;
      useSTARTTLS = false;
      setSendmail = true;
    };
  };

  time.timeZone = "Canada/Pacific";
}
