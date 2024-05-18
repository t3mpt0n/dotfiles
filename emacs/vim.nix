{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = false;
  };
}
