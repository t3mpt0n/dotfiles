{
  lah = "ls -lah";
  gau = "git add -u";
  ga = "git add";
  nixconf = "cd /etc/nixos";
  naf = "nix flake archive /etc/nixos";
  mntboot = "doas mount /dev/disk/by-uuid/7B4B-9071 /boot";
  umntboot = "doas umount /boot";
  dnrs = "doas nixos-rebuild switch --show-trace";
  nbdef = "nix-build -E 'let pkgs = import <nixpkgs> { }; in pkgs.callPackage ./default.nix {}'";
  vpn_start = "doas systemctl start wg-quick-wg0.service";
  vpn_stop = "doas systemctl stop wg-quick-wg0.service";
}
