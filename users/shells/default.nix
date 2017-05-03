{ config, pkgs, ... }:

{
  imports =
  [
    ./oh-my-zsh
  ];

  users.defaultUserShell = pkgs.bashInteractive;

  environment.shells = [ pkgs.zsh ];
  programs.zsh.enable = true;
}
