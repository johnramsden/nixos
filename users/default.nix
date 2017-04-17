{ config, pkgs, ... }:

{
  imports =
  [ ./john
    ./shells/oh-my-zsh
  ];

  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];
  security.sudo.enable = true;
}
