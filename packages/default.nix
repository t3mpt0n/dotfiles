pargs@{ config, self', inputs', pkgs, system, ... }:
with pkgs; rec {
  wofi-pass = callPackage ./wofi-pass {};
  emulationstation-de = callPackage ./es-de {};
##  simple-term-menu = python312Packages.callPackage ./simple-term-menu {};
##  streamrip = python312Packages.callPackage ./streamrip { inherit simple-term-menu; };
  nestopia = callPackage ./nestopia {};
  sway-alternating-layout = callPackage ./sway-alt-layout {};
  crystalline = callPackage ./crystalline {};
  dsda-doom = callPackage ./dsda-doom {};
  attractplus = callPackage ./attractplus {};

  /* TMUX PLUGINS */
  tmux-ip-address = callPackage ./tmuxExtras/tmux-ip-addr.nix {};
}
