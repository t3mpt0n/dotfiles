{
  pkgs,
  lib,
  ...
}: {
  programs.helix = {
    enable = true;
    themes = {
      catppuccin_mocha = builtins.readFile ./themes/catppuccin_mocha.toml;
    };
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
      };
    };
  };
}
