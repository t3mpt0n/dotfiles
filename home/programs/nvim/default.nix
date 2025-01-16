{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    # Lua
    extraLuaPackages = ljp:
      with ljp; [
        luarocks
      ];
    extraPackages = with pkgs; [
      lua-language-server
      stylua

      # Nix
      nil
      alejandra

      # Python
      pyright
      python313Packages.flake8
      python313Packages.black

      # C/C++
      gcc
      gnumake
      stdenv
    ];
  };
  home.file."./.config/nvim" = {
    recursive = true;
    source = ./conf;
  };
}
