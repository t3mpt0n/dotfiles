{ pkgs, ... }:
{
  programs.wofi = {
    enable = true;
    package = pkgs.wofi;
    settings = {
      location = "center";
      width = "50%";
      height = "50%";
    };
    style = builtins.readFile ./wofi.css;
  };
}
