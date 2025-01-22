{pkgs, ...}: {
  programs.neovim = {
    enable = false;
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
      python313Packages.debugpy

      # Rust
      rust-analyzer
      graphviz
      cargo
      rustfmt

      # C/C++
      gcc
      gnumake
      stdenv
      lldb

      # misc.
      unixtools.xxd
    ];
  };
  home.file."./.config/nvim" = {
    recursive = true;
    source = ./conf;
  };
}
