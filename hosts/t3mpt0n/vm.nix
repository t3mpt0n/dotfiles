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
      onBoot = "ignore";
      onShutdown = "shutdown";
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
            "/dev/input/by-id/usb-BY_Tech_Gaming_Keyboard-event-kbd",
            "/dev/input/by-id/usb-Logitech_G502_X_205F33734746-event-mouse",
            "/dev/input/event0",
            "/dev/input/event1",
            "/dev/input/event2",
            "/dev/input/event3",
            "/dev/input/event4",
            "/dev/input/event5",
            "/dev/null", "/dev/full", "/dev/zero",
            "/dev/random", "/dev/urandom",
            "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
            "/dev/rtc","/dev/hpet", "/dev/sev"
          ]
          unix_sock_group = "libvirt"
          unix_sock_ro_perms = "0777"
          unix_sock_rw_perms = "0770"
          unix_sock_admin_perms = "0700"
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
    preStart = let
      in ''
      mkdir -p /var/lib/libvirt/hooks/qemu.d/win11/prepare/begin
      mkdir -p /var/lib/libvirt/hooks/qemu.d/win11/release/end
      cp /etc/nixos/hosts/t3mpt0n/win11-kvm/start.sh /var/lib/libvirt/hooks/qemu.d/win11/prepare/begin/start.sh
      chmod +x /var/lib/libvirt/hooks/qemu.d/win11/prepare/begin/start.sh
      cp /etc/nixos/hosts/t3mpt0n/win11-kvm/stop.sh /var/lib/libvirt/hooks/qemu.d/win11/release/end/stop.sh
      chmod +x /var/lib/libvirt/hooks/qemu.d/win11/release/end/stop.sh
      cp /etc/nixos/hosts/t3mpt0n/win11-kvm/kvm.conf /var/lib/libvirt/hooks/kvm.conf
      chmod +x /var/lib/libvirt/hooks/kvm.conf
      mkdir -p /var/lib/libvirt/vgabios
      cp /etc/nixos/hosts/t3mpt0n/gpu.rom /var/lib/libvirt/vgabios/patched.rom
    '';
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
    virtiofsd
  ];
}
