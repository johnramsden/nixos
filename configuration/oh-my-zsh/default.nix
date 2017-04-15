{ config, pkgs, ... }:

{
  ##  ZSH Configuration  ##
  programs.zsh.interactiveShellInit = ''
    COMPUTER="atom";
    # Path to your oh-my-zsh installation.
    ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/
    # History file
    HISTFILE=$HOME/Computer/Linux/Profiles/oh-my-zsh/$COMPUTER/zsh_history
    # Change custom directory
    ZSH_CUSTOM=$HOME/Computer/Linux/Profiles/oh-my-zsh/$COMPUTER/custom
    # Theme
    ZSH_THEME="af-magic"
    # Dont auto update
    DISABLE_AUTO_UPDATE=true
    # Load plugins
    plugins=(git systemd ruby gem history sudo node npm nvm zsh-autosuggestions )

    source $ZSH/oh-my-zsh.sh

    ## -------- XDG -------- ##

    # XDG config location
    export XDG_CONFIG_HOME=$HOME/.config
    # Set XDG dirs with xdg-user-dirs-update, e.g:
    # xdg-user-dirs-update --set DOCUMENTS  $HOME/University/Documents

    ## -------- MISC -------- ##

    export ELECTRON_TRASH=kioclient5
    # Default editor
    export EDITOR="nano"
  '';

  programs.zsh.promptInit = "";
}
