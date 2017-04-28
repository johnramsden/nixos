{ config, pkgs, ... }:

{
  imports =
  [
    ./shells/oh-my-zsh
    ./john
  ];

  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];
  security.sudo.enable = true;
}
