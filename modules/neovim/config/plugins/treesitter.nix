{
  plugins.treesitter = {
    enable = true;
    settings = {
      ensure_installed = "all";
      ignore_install = [ "latex" ];
      highlight.enable = true;
      indent.enable = true;
    };
  };
}
