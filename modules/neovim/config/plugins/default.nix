{
  imports = [
    ./wk.nix
    ./dashboard.nix
    ./telescope.nix
    ./none-ls.nix
    ./luasnip.nix
    ./lsp.nix
    ./cmp.nix
    ./treesitter.nix
    ./lint.nix
    ./conform.nix
    ./oil.nix
    ./tex.nix
  ];
  plugins = {
    web-devicons.enable = true; # Needed for most UI plugins
    undotree.enable = true;
    lualine.enable = true;
    autoclose.enable = true;

    # CMP
    cmp-nvim-lsp.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp-cmdline.enable = true;
    cmp_luasnip.enable = true;

    rustaceanvim.enable = true;
    direnv.enable = true;
    lz-n.enable = true;
  };
}
