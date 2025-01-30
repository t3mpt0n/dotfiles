{
  plugins.cmp = {
    enable = true;
    settings = {
      snippet.expand.__raw = "function(args) require'luasnip'.lsp_expand(args.body) end";
      window = {
        completion.__raw = "require'cmp'.config.window.bordered()";
      };
      mapping = {
        "<C-b>".__raw = "require'cmp'.mapping.scroll_docs(-4)";
        "<C-f>".__raw = "require'cmp'.mapping.scroll_docs(4)";
        "<C-Space>".__raw = "require'cmp'.mapping.complete()";
        "<C-e>".__raw = "require'cmp'.mapping.abort()";
        "<CR>".__raw = "require'cmp'.mapping.confirm({ select = true })";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      };
      sources = [
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "buffer"; }
      ];
    };
  };
}
