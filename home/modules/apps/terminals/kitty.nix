{
  pkgs,
  ...
}:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "Cascadia Code Nerd Font";
      size = 16;
      package = pkgs.nerd-fonts.caskaydia-cove;
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
