{ config, pkgs, lib, ... }:

{
  ##  ZSH Configuration  ##
  #environment.interactiveShellInit = '''';

  programs.zsh.promptInit = "";

  # Force shellinit text to end
  programs.zsh.interactiveShellInit = lib.mkForce ''
    COMPUTER="atom"
    ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/
    HISTFILE=$HOME/Computer/System/atom/oh-my-zsh/zsh_history
    ZSH_CUSTOM=$HOME/Computer/System/atom/oh-my-zsh/custom
    ZSH_THEME="af-magic"
    DISABLE_AUTO_UPDATE=true

    plugins=(git systemd ruby gem history sudo node zsh-autosuggestions )

    source $ZSH/oh-my-zsh.sh

    ## ------------------- Languages ------------------- ##

    # Dont install software system-wide
    export GEM_HOME=$(ruby -e 'print Gem.user_dir')
    PATH="$HOME/.node_modules/bin:$PATH"
    export npm_config_prefix=~/.node_modules

    ## --------------------- MISC ---------------------- ##

    export XDG_CONFIG_HOME=$HOME/.config
    export ELECTRON_TRASH=kioclient5
    export EDITOR="nano"
    export XENVIRONMENT=$HOME/.Xdefaults
    '';
}
