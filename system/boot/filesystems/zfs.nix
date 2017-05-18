{ config, lib, pkgs, ... }:
let

  baseDataset = "vault/sys/atom";
  bootEnvironmentName = "ROOT/17.03";

  complicatedDatasets = [
    { mount = "/home/john/.local/share/lxc";
      dataset = "vault/sys/atom/home/john/local/share/lxc"; }
  ];

  makeZfsDataset  = { mount, dataset }:
    { mountPoint = "${mount}";
      device = "${dataset}";
      fsType = "zfs";
    };

  makeZfsDatasetFromBootEnv = bed:
    makeZfsDataset ({ mount = bed; dataset = "${baseDataset}/${bootEnvironmentName}/${bed}"; });

    /*fileSystems."/var/lib/containers" =
      { device = "vault/sys/atom/ROOT/17.03/var/lib/containers";
        fsType = "zfs";
      };*/
in
{
    fileSystems = (map makeZfsDataset complicatedDatasets);
                  #++ {map makeZfsDatasetFromBootEnv};

}
