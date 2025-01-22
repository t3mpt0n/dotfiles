{ lib, pkgs, ... }:
{
  plugins.lint = {
    enable = true;
    lazyLoad = {
      settings = {
        event = [
          "BufNewFile"
          "BufReadPost"
          "BufWritePost"
        ];
      };
    };

    autoCmd = {
      desc = "Lint on read, write, and insert leave";
      event = [
        "BufNewFile"
        "BufReadPost"
        "BufWritePost"
      ];
      group = "nvim-lint";
    };

    linters = {
      deadnix.cmd = lib.getExe pkgs.deadnix;
      statix.cmd = lib.getExe pkgs.statix;
      luac.cmd = lib.getExe' pkgs.lua "luac";
      hlint.cmd = lib.getExe pkgs.haskellPackages.hlint;
      stylelint.cmd = lib.getExe pkgs.stylelint;
    };

    lintersByFt = {
      nix = [
        "deadnix"
        "statix"
      ];
      lua = [
        "luac"
      ];
      haskell = [ "hlint" ];
      css = [ "stylelint" ];
    };
  };

  autoGroups = {
    nvim-lint.clear = true;
  };
}
