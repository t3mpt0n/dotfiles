pargs@{ config, self', inputs', pkgs, system, ... }:
with pkgs; rec {
  wofi-pass = callPackage ./wofi-pass {};
  simple-term-menu = python311Packages.callPackage ./simple-term-menu {};
  streamrip = python311Packages.callPackage ./streamrip { inherit simple-term-menu; };
  nestopia = callPackage ./nestopia {};
  sway-alternating-layout = callPackage ./sway-alt-layout {};
  crystalline = callPackage ./crystalline {};
  dsda-doom = callPackage ./dsda-doom {};
  attractplus = callPackage ./attractplus {};
  redream = callPackage ./redream {};
  blastem = callPackage ./blastem {};
  extract-xiso = callPackage ./extract-xiso {};

  /* TMUX PLUGINS */
  tmux-ip-address = callPackage ./tmuxExtras/tmux-ip-addr.nix {};
}
