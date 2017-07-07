{ config, lib, pkgs, ... }:
let
    baseDataset = "vault/sys";
    bootEnvironment = "ROOT/17.03";
    storageDataset = "vault/data";

    datasets = {
      atom = {
        regularDatasets = [
          "/home"
          "/home/john"
          "/var/log"
          "/var/cache"
          "/var/log/journal"
          "/var/lib/lxc"
          "/var/lib/docker"
          "/var/lib/docker-registry"
        ];

        bootEnvironmentDatasets = [
          "/nix"
          "/nix/var"
          "/nix/var/log"
          "/nix/var/nix"
          "/nix/store"
          "/var"
          "/var/lib"
          "/var/lib/nixos"
          "/var/lib/containers"
          "/var/lib/systemd"
          "/var/lib/systemd/coredump"
        ];

        storageDatasets = [ # Mounted under $HOME
          "/Books"
          "/Personal"
          "/Pictures"
          "/Computer"
          "/Reference"
          "/Workspace"
          "/University"
        ];

        differentMountPointDatasets = [
          { mount = "/";
            ds = "${baseDataset}/atom/${bootEnvironment}"; }

          { mount = "/nix/.ro-store";
            ds = "${baseDataset}/atom/${bootEnvironment}/nix/ro-store"; }

          { mount = "/nix/.rw-store";
            ds = "${baseDataset}/atom/${bootEnvironment}/nix/rw-store"; }

          { mount = "/home/john/.cache";
            ds = "${baseDataset}/atom/home/john/cache"; }

          { mount = "/home/john/.config";
            ds = "${baseDataset}/atom/home/john/config"; }

          { mount = "/home/john/.local";
            ds = "${baseDataset}/atom/home/john/local"; }

          { mount = "/home/john/.local/share/lxc";
            ds = "${baseDataset}/atom/home/john/local/share/lxc"; }

          { mount = "/home/john/.local/share/Steam";
            ds = "${baseDataset}/atom/home/john/local/share/Steam"; }

          { mount = "/home/john/VMs";
            ds = "${baseDataset}/atom/home/john/vms"; }
        ];
      };
    };

    systemDatasets =
      (map (ds:
        { mountPoint = ds;
          device = "${baseDataset}/atom${ds}";
          fsType = "zfs"; }) datasets.atom.regularDatasets)
        ++
      (map (ds:
        { mountPoint = ds;
          device = "${baseDataset}/atom/${bootEnvironment}${ds}";
          fsType = "zfs"; }) datasets.atom.bootEnvironmentDatasets)
        ++
      (map (ds:
        { mountPoint = "/home/john${ds}";
          device = "${storageDataset}${ds}";
          fsType = "zfs"; }) datasets.atom.storageDatasets)
        ++
      (map ({ mount, ds }:
        { mountPoint = mount;
          device = "${ds}";
          fsType = "zfs";}) datasets.atom.differentMountPointDatasets);
in
{
  fileSystems = systemDatasets;
}
