{
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;
    package = pkgs.fish;

    shellAbbrs = import ./alias.nix;
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
