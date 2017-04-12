{ config, pkgs, ... }:

{
  ## Packages ##
  nixpkgs.config.allowUnfree = true;

  # Packages installed in system profile.
  environment.systemPackages = with pkgs; [
      wget curl oh-my-zsh
      google-chrome xvkbd
      git pavucontrol
      atom yakuake
  ];
  programs.zsh.enable = true;
}
