{ lib, ... }:
{
  services.mako = {
    enable = false;
    actions = true;
    anchor = "bottom-center";
    icons = true;
    font = "MonaspiceKr Nerd Font 16";
    defaultTimeout = 2000;
    layer = "overlay";
    backgroundColor = "#606060A8";
    textColor = "#FFFFFFFF";
  };
}
