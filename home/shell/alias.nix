rec {
  lah = "ls -lah";
  ru = "rip url";
  gau = "git add -u";
  nixconf = "cd /etc/nixos";
  naf = "nix flake archive /etc/nixos";
  mntboot = "doas mount /dev/disk/by-uuid/7B4B-9071 /boot";
  umntboot = "doas umount /boot";
  dnrs = "doas nixos-rebuild switch --show-trace";
  nbdef = "nix-build -E 'let pkgs = import <nixpkgs> { }; in pkgs.callPackage ./default.nix {}'";
  idnrs = "NIXPKGS_ALLOW_INSECURE=1 ${dnrs} --impure";
  vpn_start = "doas systemctl start wg-quick-wg0.service";
  vpn_stop = "doas systemctl stop wg-quick-wg0.service";
}
