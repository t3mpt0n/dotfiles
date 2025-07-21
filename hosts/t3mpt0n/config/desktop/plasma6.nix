{pkgs, ...}: {
  services.desktopManager.plasma6 = {
    enable = true;
  };
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr = {
      enable = true;
      settings = {
        screencast = {
          output_name = "DP-3";
          max_fps = 60;
          chooser_type = "simple";
          chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
        };
      };
    };
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    configPackages = [pkgs.kdePackages.plasma-workspace];
  };
}
