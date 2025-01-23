{
  pkgs,
  ...
}:
{
  programs.kitty = {
    enable = true;
    theme = "Gruvbox Dark Soft";
    font = {
      name = "MonaspiceKr Nerd Font";
      size = 16;
      package = pkgs.nerd-fonts.monaspace;
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
