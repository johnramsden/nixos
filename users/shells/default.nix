{ config, pkgs, ... }:

{
  imports =
  [
    ./oh-my-zsh
  ];

  environment.shells = [ pkgs.zsh ];
  programs.zsh.enable = true;
}
