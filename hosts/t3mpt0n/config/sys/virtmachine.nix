{
  config,
  lib,
  pkgs,
  ...
}: {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
      };

      allowedBridges = [
        "virbr0"
        "br0"
      ];
    }; 
  };

  environment.systemPackages = with pkgs; [
    virtio-win
    win-spice
  ];

  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = [ "jd" ];

  boot.kernelParams = [
    "amd_iommu=on"
    "iommu=pt"
  ];
}
