{
  pkgs,
  lib,
  ...
}: {
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [ fcitx5-anthy ];
    };
  };
}
