{ config, lib, pkgs, ... }:
let
    baseDataset = "vault/sys/atom";
    bootEnvironment = "ROOT/17.03";
    storageDataset = "vault/data";

    datasets = {
      regularDatasets = [
        "/var/log" "/var/cache" "/home" "/var/lib/lxc"
        "/var/log/journal" "/home/john"
      ];

      bootEnvironmentDatasets = [
        "/nix" "/nix/store" "/var" "/var/lib" "/nix/var"
        "/var/lib/nixos" "/nix/var/nix" "/var/lib/systemd" "/nix/var/log"
        "/var/lib/systemd/coredump" "/var/lib/containers"

      ];

      storageDatasets = [ # Mounted under $HOME
        "/Computer"
        "/Workspace"
        "/University"
        "/Pictures"
        "/Reference"
        "/Books"
        "/Personal"
      ];

      differentMountPointDatasets = [
        { mount = "/";
          ds = "${baseDataset}/${bootEnvironment}"; }

        { mount = "/nix/.ro-store";
          ds = "${baseDataset}/${bootEnvironment}/nix/ro-store"; }

        { mount = "/nix/.rw-store";
          ds = "${baseDataset}/${bootEnvironment}/nix/rw-store"; }

        { mount = "/home/john/.cache";
          ds = "${baseDataset}/home/john/cache"; }

        { mount = "/home/john/.config";
          ds = "${baseDataset}/home/john/config"; }

        { mount = "/home/john/.local";
          ds = "${baseDataset}/home/john/local"; }

        { mount = "/home/john/.local/share/lxc";
          ds = "${baseDataset}/home/john/local/share/lxc"; }

        { mount = "/home/john/.local/share/Steam";
          ds = "${baseDataset}/home/john/local/share/Steam"; }
      ];

    };

in
{
  fileSystems =
    (map (ds: {mountPoint = ds; device = "${baseDataset}${ds}"; fsType = "zfs";})
                                                                  datasets.regularDatasets) ++
    (map (ds: { mountPoint = ds; device = "${baseDataset}/${bootEnvironment}${ds}"; fsType = "zfs";})
                                                                  datasets.bootEnvironmentDatasets) ++
    (map (ds: {mountPoint = "/home/john${ds}"; device = "${storageDataset}${ds}"; fsType = "zfs";})
                                                                  datasets.storageDatasets) ++
    (map ({ mount, ds }: {mountPoint = mount; device = "${ds}"; fsType = "zfs";})
                                                                  datasets.differentMountPointDatasets);
}
