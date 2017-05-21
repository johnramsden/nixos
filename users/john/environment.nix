{ config, pkgs, ... }:

let
  user = "john";
  configurations = {
        libvirt = {
          paths = {
            file = "/home/${user}/.config/libvirt/qemu.conf";
            dir = "/home/${user}/.config/libvirt/";
          };
          user_config = ''nvram = [ "${pkgs.OVMF}/FV/OVMF_CODE.fd:${pkgs.OVMF}/FV/OVMF_VARS.fd" ]'';
        };
  };

in
{
  environment.extraInit = ''
    if [ $USER==${user} ]; then
      mkdir -p "${configurations.libvirt.paths.dir}" && echo '${configurations.libvirt.user_config}' > "${configurations.libvirt.paths.file}"
    fi
  '';

}
