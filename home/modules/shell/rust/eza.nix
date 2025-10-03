{
  lib,
  pkgs,
  config,
  ...
}: {
  programs.eza = {
    enable = lib.mkDefault true;
    icons = "always";
    colors = "always";
    extraOptions = [
      "--group-directories-first"
      "-o"
      "-a"
    ];
  };
}
