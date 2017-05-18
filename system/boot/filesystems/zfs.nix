{ config, lib, pkgs, ... }:
let

  baseDataset = "vault/sys/atom";
  bootEnvironmentName = "ROOT/17.03";

  bootEnvDatasets = [
    "/var/lib/containers"
  ];
  regularDatasets = [

  ];
  complicatedDatasets = [
    { mount = "/home/john/.local/share/lxc";
      dataset = "vault/sys/atom/home/john/local/share/lxc"; }
  ];

  makeZfsDataset  = { mount, dataset ? "${baseDataset}/${bootEnvironmentName}${mount}" }:
    {
      mountPoint = "${mount}";
      device = "${dataset}";
      fsType = "zfs";
    };

  makeZfsDatasetFromBootEnv = bed:
    {
      makeZfsDataset { "${bed}" };
    };

in
{
    fileSystems =
    (map makeZfsDataset complicatedDatasets) ++
    (map makeZfsDatasetFromBootEnv bootEnvDatasets);

    /*(map ({ mount, dataset ? "${baseDataset}/${bootEnvironmentName}${mount}" }:
        { mountPoint = "${mount}"; device = "${dataset-}"; fsType = "zfs"; }) datasets);*/
}
