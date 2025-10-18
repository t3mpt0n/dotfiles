{
  lib,
  config,
  pkgs,
  ...
}: {
  qt = {
    enable = true;
    style.name = lib.mkIf config.catppuccin.enable "kvantum";
  };

  home.packages = with pkgs; [
    libsForQt5.qt5.qtwayland
    kdePackages.qtwayland
  ];
}
