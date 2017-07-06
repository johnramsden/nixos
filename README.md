# NixOS

My NixOS configuration I use as my every day system.

### nixpkgs - git Channel

In nix repo add nixpkgs channel as submodule:

    git submodule add https://github.com/nixos/nixpkgs

Add channels repo as upstream and fetch:

    cd nixpkgs
    git remote add channels https://github.com/nixos/nixpkgs-channels
    git fetch

Go to branch of choice:

    git remote update channels
    git reset  --hard channels/nixos-17.03

Set location to directory in config:

    nix.nixPath = [
        "/etc/nixos"
        "nixpkgs=/etc/nixos/nixpkgs"
        "nixos-config=/etc/nixos/configuration.nix"
    ];
