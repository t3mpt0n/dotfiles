{
  lib,
  inputs,
  pkgs,
  self,
  ...
}: let
  inherit (pkgs) fetchFromGitHub;
  inherit (self.outputs.packages.x86_64-linux) nestopia emulationstation-de dsda-doom;
  fceux = (pkgs.fceux.overrideAttrs (oldAttrs: rec {
    version = "2.6.6";
    src = fetchFromGitHub {
      owner = "TASEmulators";
      repo = "fceux";
      rev = "v${version}";
      sha256 = "sha256-Wp23oLapMqQtL2DCkm2xX1vodtEr/XNSOErf3nrFRQs=";
    };
  }));
in rec {
  programs.emulationstation = {
    enable = true;
    package = emulationstation-de;
    emulators = [
      pkgs.ares
      pkgs.retroarchFull
      dsda-doom
    ];
    systems = let
      rompath = "/mnt/dhp/media/Games/ROMs";
      commonExtensions = [ ".7z" ".7Z" ".zip" ".ZIP" ".m3u" ".M3U"];
    in rec {
      "nes" = {
        emulators = with pkgs; [ fceux punes nestopia ];
        fullname = "Nintendo Entertainment System";
        systemsortname = "01";
        extension = [ ".nes" ".NES" ] ++ commonExtensions;
        path = "${rompath}/NES";
        command = {
          "NESTopia (Standalone)" = {cmd = "nestopia --fullscreen %ROM%";};
          "FCEUX (Standalone)" = {cmd = "env QT_QPA_PLATFORM=xcb fceux %ROM% --fullscreen 1";};
        };
      };
      "gb" = {
        emulators = with pkgs; [ sameboy ];
        fullname = "Nintendo GameBoy";
        systemsortname = "01a";
        extension = [ ".gb" ".GB" ] ++ commonExtensions;
        path = "${rompath}/GB";
        command = {
          "sameboy" = {cmd = "sameboy -f %ROM%";};
        };
      };
      "gbc" = {
        inherit (gb) emulators;
        fullname = "Nintendo GameBoy Color";
        systemsortname = "03a";
        extension = [ ".gbc" ".GBC" ] ++ commonExtensions;
        path = "${rompath}/GBC";
        command = {
          "sameboy" = {cmd = "sameboy -f %ROM%";};
        };
      };
      "snesna" = {
        emulators = with pkgs; [ bsnes-hd ];
        fullname = "Super Nintendo Entertainment System";
        systemsortname = "02";
        extension = [ ".smc" ".SMC" ".sfc" ".SFC" ] ++ commonExtensions;
        path = "${rompath}/SNES";
        command = {
          "ares" = {cmd = "ares --fullscreen --system Super Famicom %ROM%";};
        };
      };
      "n64" = {
        emulators = [ pkgs.mupen64plus ];
        fullname = "Nintendo 64";
        systemsortname = "03";
        extension = [ ".n64" ".N64" ".v64" ".V64" ".z64" ".Z64" ] ++ commonExtensions;
        path = "${rompath}/N64";
        command = {
          "Simple64 (Flatpak)" = {cmd = "flatpak run --filesystem=host:ro io.github.simple64.simple64 --nogui %ROM%";};
          "RMG (Flatpak)" = {cmd = "flatpak run --filesystem=host com.github.Rosalie241.RMG -f -n %ROM%";};
        };
      };
      "gc" = {
        emulators = with pkgs; [ dolphin-emu ];
        fullname = "Nintendo GameCube";
        systemsortname = "04";
        extension = [ ".iso" ".ISO" ".wbfs" ".WBFS" ".ciso" ".CISO" ".rvz" ".RVZ" ] ++ commonExtensions;
        path = "${rompath}/GCN";
        command = {
          "Dolphin" = {cmd = "dolphin-emu-nogui -e %ROM%";};
        };
      };
      "wii" = {
        inherit (gc) emulators;
        fullname = "Nintendo Wii";
        systemsortname = "05";
        extension = [ ".iso" ".ISO" ".wbfs" ".WBFS" ".ciso" ".CISO" ".rvz" ".RVZ" ] ++ commonExtensions;
        path = "${rompath}/Wii";
        command = {
          "Dolphin" = {cmd = "dolphin-emu-nogui -e %ROM%";};
        };
      };
      "wiiu" = {
        emulators = with pkgs; [ cemu ];
        fullname = "Nintendo Wii U";
        systemsortname = "06";
        extension = [ ".wua" ".WUA" ] ++ commonExtensions;
        path = "${rompath}/Wii U";
        command = {
          "CEMU" = {};
        };
      };
      "switch" = {
        emulators = with pkgs; [yuzu-early-access ryujinx];
        fullname = "Nintendo Switch";
        systemsortname = "07";
        extension = [ ".xci" ".XCI" ".nsp" ".NSP" ] ++ commonExtensions;
        path = "${rompath}/Switch";
        command = {
          "Ryujinx" = {cmd = "ryujinx %ROM%";};
          "Yuzu" = {cmd = "yuzu %ROM%";};
        };
      };
      "psx" = {
        emulators = with pkgs; [ duckstation ];
        fullname = "Sony PlayStation";
        systemsortname = "08";
        extension = [".bin" ".BIN" ".chd" ".CHD" ".m3u" ".M3U" ] ++ commonExtensions;
        path = "${rompath}/PSX";
        command = {
          "Duckstation (Standalone)" = {};
        };
      };
      "ps2" = {
        emulators = with pkgs; [ pcsx2 ];
        fullname = "Sony PlayStation 2";
        systemsortname = "09";
        inherit (psx) extension;
        path = "${rompath}/PS2";
        command = {
          "PCSX2 (Standalone)" = {};
        };
      };
      "ps3" = {
        emulators = with pkgs; [ rpcs3 ];
        fullname = "Sony PlayStation 3";
        systemsortname = "10";
        extension = [ ".ps3" ".PS3" ] ++ commonExtensions;
        path = "${rompath}/PS3";
        command = {
          "RPCS3 (Standalone)" = {};
        };
      };
      "lutris" = rec {
        fullname = "Lutris";
        systemsortname = fullname;
        extension = [ ".desktop" ".DESKTOP" ".sh" ".SH" ] ++ commonExtensions;
        path = "/home/jd/Games/ESDE/";
        command = {
          "Run Script" = {cmd = "bash %ROM%";};
        };
      };
    };
  };
}
