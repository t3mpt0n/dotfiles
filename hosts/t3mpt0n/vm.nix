{
  config,
  lib,
  pkgs,
  ...
}: {
  virtualisation = {
    libvirtd = {
      enable = true;
      package = pkgs.libvirt;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
        verbatimConfig = ''
          namespaces = []
          user = "jd"
          group = "kvm"
          cgroup_device_acl = [
            "/dev/input/by-id/usb-Logitech_G502_X_205F33734746-event-mouse",
            "/dev/input/by-id/usb-BY_Tech_Gaming_Keyboard-event-kbd",
            "/dev/null", "/dev/full", "/dev/zero",
            "/dev/random", "/dev/urandom",
            "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
            "/dev/rtc","/dev/hpet", "/dev/sev"
          ]
        '';
      };
    };
  };

  systemd.services.libvirtd = {
    path = let
      env = pkgs.buildEnv {
        name = "qemu-hook-env";
        paths = with pkgs; [
          bash
          libvirt
          kmod
          systemd
          ripgrep
          sd
        ];
      };
      in [ env ];
  };

  users.users.jd.extraGroups = [ "libvirtd" "kvm" ];
  boot = {
    kernelParams = [
      "amd_iommu=on"
      "iommu=pt"
    ];
    kernelModules = [ "kvm-amd" ];
  };
 
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    libguestfs
    win-virtio
  ];
}
