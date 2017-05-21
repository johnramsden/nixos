{ config, pkgs, ... }:

let  users = [ "john" ];
usersConfig = map (user: (import "../${user}/environment.nix" user) users);
in {

  environment_user = map (configs:
                            map ({ name, path, config }:
                                    (pkgs.writeTextFile path config) configs) usersConfig);
}
