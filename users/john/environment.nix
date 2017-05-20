{ config, pkgs, ... }:

let
  user = "john";
  configurations = [
        { name = "libvirt";
          path = "/home/${user}/.config/libvirt/qemu.conf";
          uconfig = ''
            nvram = [ "${pkgs.OVMF}/FV/OVMF_CODE.fd:${pkgs.OVMF}/FV/OVMF_VARS.fd" ]
          '';
        }
  ];

in
{
  environment_user = map ({ name, path, uconfig }: pkgs.writeTextFile path uconfig) configurations;
}
