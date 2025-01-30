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
      flake8.cmd = lib.getExe pkgs.python313Packages.flake8;
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
      python = [ "flake8" ];
    };
  };

  autoGroups = {
    nvim-lint.clear = true;
  };
}
