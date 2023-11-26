pargs@{ config, self', inputs', pkgs, system, ... }:
with pkgs; rec {
  wofi-pass = callPackage ./wofi-pass {};
  emulationstation-de = callPackage ./es-de {};
  simple-term-menu = python3Packages.callPackage ./simple-term-menu {};
  streamrip = python3Packages.callPackage ./streamrip { inherit simple-term-menu; };
  nestopia = callPackage ./nestopia {};
  sway-alternating-layout = callPackage ./sway-alt-layout {};
  crystalline = callPackage ./crystalline {};
  dsda-doom = callPackage ./dsda-doom {};

  /* TMUX PLUGINS */
  tmux-ip-address = callPackage ./tmuxExtras/tmux-ip-addr.nix {};
}
