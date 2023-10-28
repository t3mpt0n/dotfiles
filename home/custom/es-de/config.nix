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
    gb = [ sameboy ];
    n64 = [ mupen64plus ];
    wiiu = [ cemu ];
    nx = [ yuzu-early-access ryujinx ];
    multi = [ ares dolphin-emu ];
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
      "gb" = {
        fullname = "Nintendo GameBoy";
        systemsortname = "01a";
        extension = [ ".gb" ".GB" ] ++ commonExtensions;
        path = "${rompath}/GB";
        command = {
          label = "sameboy";
          text = "sameboy -f %ROM%";
        };
      };
      "gbc" = {
        fullname = "Nintendo GameBoy Color";
        systemsortname = "01b";
        extension = [ ".gbc" ".GBC" ] ++ commonExtensions;
        path = "${rompath}/GBC";
        command = {
          label = "sameboy";
          text = "sameboy -f %ROM%";
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
      "gc" = {
        fullname = "Nintendo GameCube";
        systemsortname = "04";
        extension = [ ".iso" ".ISO" ".wbfs" ".WBFS" ".ciso" ".CISO" ".rvz" ".RVZ" ] ++ commonExtensions;
        path = "${rompath}/GCN";
        command = {
          label = "Dolphin";
          text = "env AMD_VULKAN_ICD=RADV dolphin-emu-nogui -e %ROM%";
        };
      };
      "wii" = {
        fullname = "Nintendo Wii";
        systemsortname = "05";
        extension = [ ".iso" ".ISO" ".wbfs" ".WBFS" ".ciso" ".CISO" ".rvz" ".RVZ" ] ++ commonExtensions;
        path = "${rompath}/Wii";
        command = {
          label = "Dolphin";
          text = "env AMD_VULKAN_ICD=RADV dolphin-emu-nogui -e %ROM%";
        };
      };
      "wiiu" = {
        fullname = "Nintendo Wii U";
        systemsortname = "06";
        extension = [ ".wua" ".WUA" ] ++ commonExtensions;
        path = "${rompath}/Wii U";
        command = {
          label = "CEMU";
        };
      };
      "switch" = {
        fullname = "Nintendo Switch";
        systemsortname = "07";
        extension = [ ".xci" ".XCI" ".nsp" ".NSP" ] ++ commonExtensions;
        path = "${rompath}/Switch";
        command = {
          label = "Ryujinx";
          text = "ryujinx %ROM%";
        };
      };
    };
  };

  home.packages = with emulators;
    nes
      ++gb
      ++n64
      ++wiiu
      ++nx
      ++multi;
}
