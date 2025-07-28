{
  lib,
  inputs,
  pkgs,
  pkgsStable,
  ...
}: let
  inherit (pkgs) fetchurl fetchzip fetchFromGitHub fetchFromGitLab appimageTools;
  
  gamescopecmd = "gamescope -W 2560 -H 1440 -w 2560 -h 1440 -r 60 -O DP-3 --xwayland-count 1 --adaptive-sync --fullscreen";
  es-de = pkgsStable.emulationstation-de.overrideAttrs (finalAttrs: previousAttrs: {
    pname = "es-de";
    version = "3.3.0";
    src = fetchzip {
      url = "https://gitlab.com/es-de/emulationstation-de/-/archive/v${finalAttrs.version}/emulationstation-de-v${finalAttrs.version}.tar.gz";
      hash = "sha256-CHoOpvDEbGo3UcJb4S5HlIRsoCAN1qU+hovvU4pCRMo=";
    };

    buildInputs = with pkgsStable; [
      bluez
      bluez-tools
    ] ++ previousAttrs.buildInputs;
  });
in rec {
  programs.emulationstation = {
    enable = false;
    package = es-de;
    emulators = [
      pkgs.ares
      pkgs.retroarch
      pkgs.mednafen
      pkgs.mednaffe
      pkgs.pcsx2
    ];
    systems = let
      rompath = "/mnt/dhp/media/Games/ROMs";
      commonExtensions = [ ".7z" ".7Z" ".zip" ".ZIP" ".m3u" ".M3U"];
      genericArcadeBuild = {
        emulators = with pkgs; [libretro.fbneo];
        extension = commonExtensions;
        platform = "arcade";
        command = {
          "MAME" = { cmd = "mame %BASENAME%"; };
          "Final Burn Neo" = { cmd = "retroarch-fbneo %ROM%"; };
        };
      };
    in rec {
      # SONY
      "psx" = {
        emulators = with pkgs; [libretro.beetle-psx-hw];
        fullname = "Sony PlayStation";
        path = "${rompath}/PSX";
        extension = [ ".chd" ".CHD" ".iso" ".ISO" ];
        command = {
          "RetroArch (Beetle PSX)" = { cmd = "retroarch-mednafen-psx-hw %ROM%"; };
        };
      };
      
      # NINTENDO
      
      "famicom" = {
        emulators = with pkgs; [ mesen libretro.mesen ];
        fullname = "Nintendo Family Computer";
        path = "${rompath}/FC";
        extension = [ ".nes" ".NES" ];
        command = {
          "Mesen" = {cmd = "env SDL_VIDEODRIVER=x11 Mesen %ROM%"; };
          "RetroArch (MESEN)" = { cmd = "retroarch-mesen %ROM%"; };
        };
        platform = "nes";
        theme = "famicom";
      };

      "fds" = {
        inherit (famicom) emulators command;
        fullname = "Nintendo Famicom Disk System";
        path = "${rompath}/FDS";
        extension = [ ".fds" ".FDS" ];
        platform = "fds";
        theme = "fds";
      };

      "nes" = {
        inherit (famicom) emulators extension command;
        fullname = "Nintendo Entertainment System";
        path = "${rompath}/NES";
        platform = "nes";
        theme = "nes";
      };

      "gb" = {
        emulators = with pkgs; [ sameboy ];
        fullname = "Nintendo Game Boy";
        path = "${rompath}/GB";
        extension = [ ".gb" ".GB"];
        command = {
          "Sameboy" = { cmd = "sameboy %ROM%"; };
        };
      };

      "sfc" = {
        emulators = with pkgs; [ libretro.bsnes ];
        fullname = "Nintendo SFC (Super Famicom)";
        path = "${rompath}/SFC";
        extension = [ ".sfc" ".SFC" ];
        command = {
          "Ares" = { cmd = "ares --fullscreen --system \"Super Famicom\" %ROM%";};
          "RetroArch (BSNES)" = { cmd = "retroarch-bsnes %ROM%"; };
        };
        platform = "snes";
      };

      "snesna" = {
        inherit (sfc) extension command platform;
        fullname = "Nintendo SNES (Super Nintendo)";
        path = "${rompath}/SNES";
      };

      "n64" = {
        emulators = with pkgs; [ libretro.parallel-n64 ];
        fullname = "Nintendo 64";
        path = "${rompath}/N64";
        extension = [ ".v64" ".z64" ".n64" ".V64" ".Z64" ".N64"];
        command = {
          "Ares" = { cmd = "ares --fullscreen --system \"Nintendo 64\" %ROM%"; };
          "RetroArch (ParaLLEl64)" = {cmd = "retroarch-parallel-n64 %ROM%"; };
        };
      };

      "gc" = {
        emulators = with pkgs; [ dolphin-emu];
        fullname = "Nintendo GameCube";
        path = "${rompath}/GCN";
        extension = [ ".rvz" ".iso" ".RVZ" ".ISO" ];
        command = {
          "Dolphin" = { cmd = "dolphin-emu -b -e %ROM"; };
        };
      };
      
      # SEGA
      "genesis" = {
        emulators = with pkgs; [ libretro.genesis-plus-gx blastem ];
        fullname = "Sega Genesis";
        path = "${rompath}/Genesis";
        extension = [ ".md" ".bin" ".MD" ".BIN" ];
        command = {
          "RetroArch (Genesis Plus GX)" = { cmd = "retroarch-genesis-plus-gx %ROM%"; };
          "BlastEm" = { cmd = "blastem %ROM%"; };
        };
      };

      "segacd" = {
        inherit (genesis) emulators command;
        fullname = "Sega CD";
        path = "${rompath}/Sega CD";
        extension = [ ".chd" ".CHD" ];
      };

      "saturn" = {
        emulators = with pkgs; [ libretro.beetle-saturn ];
        fullname = "Sega Saturn";
        path = "${rompath}/Saturn";
        extension = [ ".chd" ".CHD" ".cue" ".CUE" ];
        command = {
          "RetroArch (Beetle Saturn)" = { cmd = "retroarch-mednafen-saturn %ROM%"; };
        };
      };

      "dreamcast" = {
        emulators = with pkgs; [ flycast];
        fullname = "Sega Dreamcast";
        path = "${rompath}/DC";
        extension = [ ".chd" ".CHD" ".cue" ".CUE" ".gdi" ".GDI" ];
        command = {
          "Flycast" = { cmd = "flycast %ROM%"; };
        };
      };

      # Arcade
      "cps1" = {
        fullname = "Capcom Play System 1";
        path = "${rompath}/CPS1";
        theme = "cps1";
      } // genericArcadeBuild;

      "cps2" = {
        fullname = "Capcom Play System 2";
        path = "${rompath}/CPS2";
        theme = "cps2";
      } // genericArcadeBuild;
      
      "neogeo" = {
        fullname = "SNK NEO-GEO";
        path = "${rompath}/NEOGEO";
        theme = "neogeo";
      } // genericArcadeBuild;

      "atomiswave" = {
        inherit (dreamcast) emulators command;
        fullname = "Sammy Atomiswave";
        path = "${rompath}/ATOMISWAVE";
        platform = "arcade";
        theme = "atomiswave";
        extension = [ ".zip" ".7z" ".ZIP" ".7Z" ];
      };
    };
  };
}

