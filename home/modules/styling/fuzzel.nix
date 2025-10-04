{
  pkgs,
  lib,
  ...
}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${lib.getExe pkgs.kitty}";
      };
    };
  };
}
