{ config, pkgs, ... }:

{
  # SSMTP Configuration
  networking.defaultMailServer = {
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
}
