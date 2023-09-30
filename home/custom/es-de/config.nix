{
  lib,
  inputs,
  pkgs,
  self,
  ...
}: let
  inherit (pkgs) fetchFromGitHub;
  inherit (self.outputs.packages.x86_64-linux) nestopia emulationstation-de;
  fceux = (pkgs.fceux.overrideAttrs (oldAttrs: rec {
    version = "2.6.6";
    src = fetchFromGitHub {
      owner = "TASEmulators";
      repo = "fceux";
      rev = "v${version}";
      sha256 = "sha256-Wp23oLapMqQtL2DCkm2xX1vodtEr/XNSOErf3nrFRQs=";
    };
  }));

  emulators = with pkgs; {
    nes = [ fceux punes nestopia ];
    n64 = [ mupen64plus ];
    multi = [ ares ];
  };
in rec {
  programs.emulationstation = {
    enable = true;
    package = emulationstation-de;
    systems = let
      rompath = "/mnt/dhp/media/Games/ROMs";
      commonExtensions = [ ".7z" ".7Z" ".zip" ".ZIP" ];
    in {
      "nes" = {
        fullname = "Nintendo Entertainment System";
        systemsortname = "01";
        extension = [ ".nes" ".NES" ] ++ commonExtensions;
        path = "${rompath}/NES";
        command = {
          label = "nestopia";
          text = "nestopia --fullscreen %ROM%";
        };
      };
      "snes" = {
        fullname = "Super Nintendo Entertainment System";
        systemsortname = "02";
        extension = [ ".smc" ".SMC" ".sfc" ".SFC" ] ++ commonExtensions;
        path = "${rompath}/SNES";
        command = {
          label = "BSNES";
          text = "ares --fullscreen --system Super Famicom %ROM%";
        };
      };
      "n64" = {
        fullname = "Nintendo 64";
        systemsortname = "03";
        extension = [ ".n64" ".N64" ".v64" ".V64" ".z64" ".Z64" ] ++ commonExtensions;
        path = "${rompath}/N64";
        command = {
          label = "Simple64";
          text = "flatpak run --filesystem=host:ro io.github.simple64.simple64 --nogui %ROM%";
        };
      };
    };
  };

  home.packages = with emulators;
    nes
      ++n64
      ++multi;
}
