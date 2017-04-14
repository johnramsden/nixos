{ config, pkgs, ... }:

{
  ## Packages ##
  nixpkgs.config.allowUnfree = true;

  # Packages installed in system profile.
  environment.systemPackages = with pkgs; 
    # System Administration
    [ wget curl git ] ++
    ## USER - 'john' ##
    # Shell and related
    [ oh-my-zsh ] ++
    # Userspace utilities
    [  pavucontrol ] ++
    # General user applications
    [ atom yakuake google-chrome xvkbd ];
    # Programming 
#    [ gitkraken clion ] ++
    # KDE
#    [ kdeApps_stable ];
  programs.zsh.enable = true;
}
