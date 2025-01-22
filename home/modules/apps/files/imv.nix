{ lib, ... }:
{
  programs = {
    imv = {
      enable = true;
      settings = {
        options = {
          overlay = true;
          overlay_font = "MonaspiceKr Nerd Font:16";
          overlay_position_bottom = true;
        };
      };
    };
  };
}
