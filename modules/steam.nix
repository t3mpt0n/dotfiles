{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    steam = {
      enable = true;
      package = pkgs.steam.override {};
      extraPackages = with pkgs; [
        mono
        wine
      ];
    };
  };

  environment.systemPackages = let
    steam-run =
      (pkgs.steam.override {
        extraLibraries = pkgs:
          with pkgs; [
            fuse
          ];
      }).run;
  in [
    steam-run
    pkgs.steam-rom-manager
    pkgs.steamtinkerlaunch
  ];
}
