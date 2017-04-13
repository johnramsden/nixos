{ config, pkgs, ... }:

{
  ## Packages ##
  nixpkgs.config.allowUnfree = true;

  # Packages installed in system profile.
  environment.systemPackages = with pkgs; 
    # System Administration
    [ wget curl git ] ++
    # Shell and related
    [ oh-my-zsh ] ++
    # Userspace utilities
    [  pavucontrol ] ++
    # General user applications
    [ atom yakuake google-chrome xvkbd ];

  programs.zsh.enable = true;
}
