{
  pkgs,
  lib,
  ...
}: {
  catppuccin = {
    enable = lib.mkDefault false;
    flavor = "mocha";
    accent = "lavender";
  };
}
