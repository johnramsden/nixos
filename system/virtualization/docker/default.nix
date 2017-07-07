{ config, pkgs, ... }:

{

  virtualisation.docker = {
      enable = true;
      storageDriver = "zfs";
  };

  services.dockerRegistry = {
    enable = true;
    storagePath = "/var/lib/docker-registry"; # Mounted with zfs fileSystems
  };
  # Containers to mount at boot:
}
