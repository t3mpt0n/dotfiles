{
  pkgs,
  ...
}:
{
  programs.kitty = {
    enable = true;
    theme = "Gruvbox Dark Soft";
    font = {
      name = "GeistMono Nerd Font";
      size = 16;
      package = pkgs.nerd-fonts.geist-mono;
    };
    shellIntegration = {
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
    settings = {
      background_opacity = 0.65;
      disable_ligatures = "never";
    };
  };
}
