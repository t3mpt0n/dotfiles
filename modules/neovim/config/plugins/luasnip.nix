{
  plugins.luasnip = {
    enable = true;
    settings = {
      enable_autosnippets = true;
    };

    fromLua = [
      {
        paths = "/etc/nixos/modules/neovim/config/snippets";
      }
    ];
  };
}
