{ config, lib, pkgs, ... }:
let
    mountSkel = false;
    skelMountPoint = "/mnt/skel";

    baseDataset = "vault/sys";
    bootEnvironment = "ROOT/17.03";
    storageDataset = "vault/data";

    datasets = {
      atom = {
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
        ];
      };
      skel = {
        regularDatasets = [
          "/home" "/home/john" "/home/john/VMs"
          "/home/john/VMs/disks"
          "/var/cache" "/var/lib/lxc" "/var/lib/lxc/nix"
          "/var/lib/lxd" "/var/lib/machines"
          "/var/log" "/var/log/journal"
        ];

        bootEnvironmentDatasets = [
          "/opt" "/usr" "/usr/lib" "/usr/local"
          "/usr/share" "/var" "/var/abs" "/var/lib"
          "/var/lib/pacman" "/var/lib/systemd/coredump"
        ];

        differentMountPointDatasets = [
          { mount = "${skelMountPoint}";
            ds = "${baseDataset}/skel/ROOT/default"; }

          { mount = "${skelMountPoint}/home/john/.cache";
            ds = "${baseDataset}/skel/home/john/cache"; }

          { mount = "${skelMountPoint}/home/john/.config";
            ds = "${baseDataset}/skel/home/john/config"; }

          { mount = "${skelMountPoint}/home/john/.local";
            ds = "${baseDataset}/skel/home/john/local"; }

          { mount = "${skelMountPoint}/home/john/.local/share/Steam";
            ds = "${baseDataset}/skel/home/john/local/share/Steam"; }

          { mount = "${skelMountPoint}/home/john/.local/share/libvirt";
            ds = "${baseDataset}/skel/home/john/local/share/libvirt"; }
        ];
      };
    };

    skelDatasets =
      (map (ds: {mountPoint = "${skelMountPoint}${ds}"; device = "${baseDataset}/skel${ds}"; fsType = "zfs";})
                                                                    datasets.skel.regularDatasets) ++
      (map (ds: { mountPoint = "${skelMountPoint}${ds}"; device = "${baseDataset}/skel/ROOT/default${ds}"; fsType = "zfs";})
                                                                    datasets.skel.bootEnvironmentDatasets) ++
      (map ({ mount, ds }: {mountPoint = mount; device = "${ds}"; fsType = "zfs";})
                                                                    datasets.skel.differentMountPointDatasets);
    systemDatasets =
      (map (ds: {mountPoint = ds; device = "${baseDataset}/atom${ds}"; fsType = "zfs";})
                                                                    datasets.atom.regularDatasets) ++
      (map (ds: { mountPoint = ds; device = "${baseDataset}/atom/${bootEnvironment}${ds}"; fsType = "zfs";})
                                                                    datasets.atom.bootEnvironmentDatasets) ++
      (map (ds: {mountPoint = "/home/john${ds}"; device = "${storageDataset}${ds}"; fsType = "zfs";})
                                                                    datasets.atom.storageDatasets) ++
      (map ({ mount, ds }: {mountPoint = mount; device = "${ds}"; fsType = "zfs";})
                                                                    datasets.atom.differentMountPointDatasets);
in
{

  fileSystems =
    if mountSkel then
      systemDatasets ++ skelDatasets
    else
      systemDatasets;
}
