{
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;
    package = pkgs.fish;

    shellAbbrs = rec {
      ru = "rip url";
      gau = "git add -u";
      nixconf = "cd /etc/nixos";
      naf = "nix flake archive /etc/nixos";
      mntboot = "doas mount /dev/disk/by-uuid/7B4B-9071 /boot";
      umntboot = "doas umount /boot";
      dnrs = "doas nixos-rebuild switch --show-trace";
      nbdef = "nix-build -E 'let pkgs = import <nixpkgs> { }; in pkgs.callPackage ./default.nix {}'";
      idnrs = "NIXPKGS_ALLOW_INSECURE=1 ${dnrs} --impure";
    };
    functions = {
      clear = {
        body = "vterm_printf 51;Evterm-clear-scrollback;\ntput clear;";
        onEvent = "$INSIDE_EMACS == 'vterm'";
      };
      nix = {
        body = "${pkgs.nix-your-shell}/bin/nix-your-shell fish nix -- $argv";
      };
      nix-shell = {
        body = "${pkgs.nix-your-shell}/bin/nix-your-shell fish nix-shell -- $argv";
      };
    };
  };
}
