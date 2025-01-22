{ lib, pkgs, ... }:
{
  plugins.conform-nvim = {
    enable = true;

    settings = {
      format_on_save = {
        timeout_ms = 500;
        lsp_format = "fallback";
      };

      formatters = {
        nixfmt.command = lib.getExe pkgs.nixfmt-rfc-style;
        stylua.command = lib.getExe pkgs.stylua;
        black.command = lib.getExe pkgs.python3Packages.black;
        rustfmt.command = lib.getExe pkgs.rustfmt;
        prettier.command = lib.getExe pkgs.prettierd;
      };

      formatters_by_ft = {
        lua = [ "stylua" ];
        nix = [ "nixfmt" ];
        rust = [ "rustfmt" ];
        python = [ "black" ];
        css = [ "prettier" ];
      };
    };
  };
}
