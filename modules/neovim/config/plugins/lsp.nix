{
  inputs,
  pkgs,
  lib,
  system,
  ...
}:
{
  plugins.lsp = {
    enable = true;
    inlayHints = true;
    lazyLoad.settings = {
      event = [
        "BufNewFile"
        "BufReadPost"
        "BufWritePost"
      ];
    };

    servers = {
      lua_ls = {
        enable = true;
      };

      nixd = {
        enable = true;
        settings =
          let
            confFlake = ''(builtins.getFlake "${inputs.self}")'';
          in
          {
            nixpkgs.expr = "import ${confFlake}.inputs.nixpkgs { }";
            formatting = {
              command = [ "nixfmt" ];
            };
            options = {
              nixvim.expr = "${confFlake}.packages.${system}.default.options";
            };
          };
      };

      cssls = {
        enable = true;
      };
    };
  };
}
