{
  config,
  lib,
  pkgs,
  ...
}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
    };
  };

  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = [ "jd" ];

  boot.kernelParams = [
    "amd_iommu=on"
    "iommu=pt"
  ];
}
