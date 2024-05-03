{
  lib,
  inputs,
  pkgs,
  self,
  ...
}: let
  inherit (pkgs) fetchurl fetchzip fetchFromGitHub fetchFromGitLab appimageTools;
  inherit (self.outputs.packages.x86_64-linux) nestopia dsda-doom;
  inherit (inputs.gaming.packages.x86_64-linux) es-de;
  gamescopecmd = "gamescope -W 2560 -H 1440 -w 2560 -h 1440 -r 60 -O DP-3 --xwayland-count 1 --adaptive-sync --fullscreen";
  rpcs3 = appimageTools.wrapType2 {
    name = "rpcs3";
    src = fetchurl {
      url = "https://github.com/RPCS3/rpcs3-binaries-linux/releases/download/build-e32ed90d21f3f2fd7227653f59c6843e2f30e1fd/rpcs3-v0.0.31-16209-e32ed90d_linux64.AppImage";
      hash = "sha256-T5CLQD1+n17f+dZDZ6TcOI+WJHpTlafiIuIifaPhJjY=";
    };
    extraPkgs = p: with p; [ kdePackages.qtbase kdePackages.qtmultimedia openal glew vulkan-headers vulkan-loader libpng ffmpeg libevdev zlib libusb1 curl wolfssl python3 pugixml SDL2 flatbuffers llvm_16 xorg.libSM];
  };

in rec {
  programs.emulationstation = {
    enable = true;
    package = es-de;
    emulators = [
      pkgs.ares
      pkgs.retroarch
      pkgs.emulationstation
      dsda-doom
      pkgs.mednafen
      pkgs.mednaffe
    ];
    systems = let
      rompath = "/mnt/dhp/media/Games/ROMs";
      commonExtensions = [ ".7z" ".7Z" ".zip" ".ZIP" ".m3u" ".M3U"];
    in rec {
      "nes" = {
        emulators = with pkgs; [ fceux punes nestopia ];
        fullname = "Nintendo Entertainment System";
        systemsortname = "nint1985";
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
        systemsortname = "nint1989";
        extension = [ ".gb" ".GB" ] ++ commonExtensions;
        path = "${rompath}/GB";
        command = {
          "sameboy" = {cmd = "sameboy -f %ROM%";};
        };
      };
      "gbc" = {
        inherit (gb) emulators;
        fullname = "Nintendo GameBoy Color";
        systemsortname = "nint1998";
        extension = [ ".gbc" ".GBC" ] ++ commonExtensions;
        path = "${rompath}/GBC";
        command = {
          "sameboy" = {cmd = "sameboy -f %ROM%";};
        };
      };
      "snesna" = {
        emulators = with pkgs; [ bsnes-hd ];
        fullname = "Super Nintendo Entertainment System";
        systemsortname = "nint1991";
        extension = [ ".smc" ".SMC" ".sfc" ".SFC" ] ++ commonExtensions;
        path = "${rompath}/SNES";
        command = {
          "ares" = {cmd = "${gamescopecmd} -- ares --fullscreen --system Super Famicom %ROM%";};
        };
      };
      "n64" = {
        emulators = [ pkgs.mupen64plus ];
        fullname = "Nintendo 64";
        systemsortname = "nint1996";
        extension = [ ".n64" ".N64" ".v64" ".V64" ".z64" ".Z64" ] ++ commonExtensions;
        path = "${rompath}/N64";
        command = {
          "Simple64 (Flatpak)" = {cmd = "flatpak run --filesystem=host:ro io.github.simple64.simple64 --nogui %ROM%";};
          "RMG (Flatpak)" = {cmd = "flatpak run --filesystem=host com.github.Rosalie241.RMG -f -n %ROM%";};
          "Mupen64Plus-Next (RetroArch)" = {cmd = "retroarch -L parallel_n64_libretro.so %ROM%";};
        };
      };
      "gc" = {
        emulators = with pkgs; [ dolphin-emu ];
        fullname = "Nintendo GameCube";
        systemsortname = "nint2001";
        extension = [ ".iso" ".ISO" ".wbfs" ".WBFS" ".ciso" ".CISO" ".rvz" ".RVZ" ] ++ commonExtensions;
        path = "${rompath}/GCN";
        command = {
          "Dolphin" = {cmd = "dolphin-emu-nogui -e %ROM%";};
        };
      };
      "wii" = {
        inherit (gc) emulators;
        fullname = "Nintendo Wii";
        systemsortname = "nint2006";
        extension = [ ".iso" ".ISO" ".wbfs" ".WBFS" ".ciso" ".CISO" ".rvz" ".RVZ" ] ++ commonExtensions;
        path = "${rompath}/Wii";
        command = {
          "Dolphin" = {cmd = "dolphin-emu-nogui -e %ROM%";};
        };
      };
      "wiiu" = {
        emulators = with pkgs; [ cemu ];
        fullname = "Nintendo Wii U";
        systemsortname = "nint2012";
        extension = [ ".wua" ".WUA" ] ++ commonExtensions;
        path = "${rompath}/Wii U";
        command = {
          "CEMU" = {};
        };
      };
      "switch" = {
        emulators = with pkgs; [ ryujinx ];
        fullname = "Nintendo Switch";
        systemsortname = "nint2017";
        extension = [ ".xci" ".XCI" ".nsp" ".NSP" ] ++ commonExtensions;
        path = "${rompath}/Switch";
        command = {
          "Ryujinx" = {cmd = "ryujinx %ROM%";};
          "Yuzu" = {cmd = "yuzu %ROM%";};
        };
      };
      "genesis" = {
        emulators = with pkgs; [];
        fullname = "Sega Genesis";
        systemsortname = "sega1989";
        extension = [ ".bin" ".BIN" ".md" ".MD" ".gen" ".GEN" ] ++ commonExtensions;
        path = "${rompath}/MD";
        command = {
          "RetroArch (Blastem)" = { cmd = "retroarch -L blastem_libretro.so %ROM%"; };
          "RetroArch (Genesis Plus GX)" = { cmd = "retroarch -L genesis_plus_gx_libretro.so %ROM%"; };
        };
      };
      "model1" = {
        emulators = with pkgs; [];
        fullname = "Sega Model 1";
        systemsortname = "sega1992";
        extension = commonExtensions;
        path = "${rompath}/MODEL1";
        command = {
          "MAME (Standalone)" = {
            cmd = "mame %BASENAME%";
          };
        };
      };
      "model3" = {
        emulators = with pkgs; [];
        fullname = "Sega Model 3";
        systemsortname = "sega1996";
        extension = commonExtensions;
        path = "${rompath}/MODEL3";
        command = {
          "MAME (Standalone)" = {
            cmd = "mame %BASENAME%";
          };
        };
      };
      "segacd" = {
        emulators = with pkgs; [];
        fullname = "Sega CD";
        systemsortname = "sega1991";
        extension = [ ".bin" ".BIN" ".chd" ".CHD" ".cue" ".CUE" ] ++ commonExtensions;
        path = "${rompath}/Sega CD";
        command = {
          "RetroArch (Blastem)" = { cmd = "retroarch -L blastem_libretro.so %ROM%"; };
          "RetroArch (Genesis Plus GX)" = { cmd = "retroarch -L genesis_plus_gx_libretro.so %ROM%"; };
        };
      };
      "sega32xna" = {
        emulators = with pkgs; [];
        fullname = "Sega 32X";
        systemsortname = "sega1994";
        extension = [ ".32x" ] ++ commonExtensions;
        path = "${rompath}/32X";
        command = {
          "RetroArch (PicoDrive)" = { cmd = "retroarch -L picodrive_libretro.so %ROM%"; };
        };
      };
      "saturn" = {
        emulators = with pkgs; [];
        fullname = "Sega Saturn";
        systemsortname = "sega1994";
        extension = [ ".bin" ".BIN" ".cue" ".CUE" ".chd" ".CHD" ] ++ commonExtensions;
        path = "${rompath}/Saturn";
        command = {
          "RetroArch (Beetle Saturn)" = { cmd = "retroarch -L mednafen_saturn_libretro.so %ROM%"; };
        };
      };
      "naomi" = {
        emulators = with pkgs; [ flycast ];
        fullname = "Sega NAOMI";
        systemsortname = "sega1998a";
        extension = commonExtensions;
        path = "${rompath}/NAOMI";
        command = {
          "FlyCast"  = { cmd = "flycast %ROM%"; };
        };
      };
      "naomigd" = {
        emulators = with pkgs; [ flycast ];
        fullname = "Sega NAOMI GD-ROM System";
        systemsortname = "sega1998a";
        extension = commonExtensions;
        path = "${rompath}/NAOMI GD-ROM";
        command = {
          "FlyCast"  = { cmd = "flycast %ROM%"; };
        };
      };
      "dreamcast" = {
        inherit (naomi) emulators;
        fullname = "Sega Dreamcast";
        systemsortname = "sega1998b";
        extension = [ ".chd" ".CHD" ".m3u" ".M3U" ] ++ commonExtensions;
        path = "${rompath}/DC";
        command = {
          "FlyCast"  = { cmd = "flycast %ROM%"; };
        };
      };
      "psx" = {
        emulators = with pkgs; [ duckstation ];
        fullname = "Sony PlayStation";
        systemsortname = "sony1994";
        extension = [".bin" ".BIN" ".chd" ".CHD" ".m3u" ".M3U" ".iso" ".ISO" ] ++ commonExtensions;
        path = "${rompath}/PSX";
        command = {
          "Duckstation (Standalone)" = {cmd = "duckstation-qt -bigpicture -batch -nogui -fullscreen %ROM%";};
        };
      };
      "ps2" = {
        emulators = with pkgs; [ pcsx2 ];
        fullname = "Sony PlayStation 2";
        systemsortname = "sony2000";
        inherit (psx) extension;
        path = "${rompath}/PS2";
        command = {
          "PCSX2 (Standalone)" = {cmd = "pcsx2-qt -slowboot -bigpicture -fullscreen -nogui -batch %ROM%";};
        };
      };
      "psp" = {
        emulators = with pkgs; [ ppsspp ];
        fullname = "Sony PlayStation Portable";
        systemsortname = "sony2004";
        inherit (psx) extension;
        path = "${rompath}/PSP";
        command = {
          "PPSSPP (Standalone)" = { cmd = "ppsspp %ROM%"; };
        };
      };
      "ps3" = {
        emulators = [ rpcs3 ];
        fullname = "Sony PlayStation 3";
        systemsortname = "sony2006";
        extension = [ ".ps3" ".PS3" ] ++ commonExtensions;
        path = "${rompath}/PS3";
        command = {
          "RPCS3 (Standalone)" = {};
        };
      };
      "neogeo" = {
        emulators = with pkgs; [ ];
        fullname = "SNK NeoGeo";
        systemsortname = "snk1990";
        extension = commonExtensions;
        path = "${rompath}/NEOGEO";
        command = {
          "MAME (Standalone)" = {cmd = "mame neogeo %BASENAME%";};
        };
      };
      "neogeocd" = {
        emulators = with pkgs; [ ];
        fullname = "SNK NeoGeo CD";
        systemsortname = "snk1994";
        extension = [ ".ncdz" ".NCDZ" ] ++ commonExtensions;
        path = "${rompath}/NEOCD";
        command = {
          "MAME (Standalone) (US)" = {cmd = "mame neocdz %BASENAME%";};
        };
      };
      "cps1" = {
        emulators = with pkgs; [ ];
        fullname = "Capcom Play System";
        systemsortname = "capcompl1";
        extension = commonExtensions;
        path = "${rompath}/CPS1";
        command = {
          "MAME (Standalone)" = {cmd = "mame %BASENAME%";};
        };
      };
      "cps2" = {
        emulators = with pkgs; [ ];
        fullname = "Capcom Play System 2";
        systemsortname = "capcompl2";
        extension = commonExtensions;
        path = "${rompath}/CPS2";
        command = {
          "MAME (Standalone)" = {cmd = "mame %BASENAME%";};
        };
      };
      "cave" = {
        emulators = with pkgs; [ ];
        fullname = "Cave Co.";
        systemsortname = "caveco";
        extension = commonExtensions;
        path = "${rompath}/Cave";
        command = {
          "MAME (Standalone)" = {cmd = "mame %BASENAME%";};
        };
      };
      "amiga" = {
        emulators = with pkgs; [ fsuae fsuae-launcher ];
        fullname = "Commodore Amiga";
        systemsortname = "cmdor1985";
        extension = [ ".adf" ".ADF" ] ++ commonExtensions;
        path = "${rompath}/Amiga";
        command = {
          "FSUAE" = { cmd = "fs-uae-launcher /home/jd/FS-UAE/Configurations/%BASENAME%.fs-uae"; };
        };
      };
      "x68000" = {
        emulators = with pkgs; [ fsuae fsuae-launcher ];
        fullname = "Sharp X68000";
        systemsortname = "sharp1987";
        extension = commonExtensions;
        path = "${rompath}/SX68K/x68k_flop";
        command = {
          "MAME (Standalone)" = { cmd = "mame x68000 %BASENAME%"; };
        };
      };
      "xbox" = {
        emulators = with pkgs; [ xemu ];
        fullname = "Microsoft XBOX";
        systemsortname = "micsoft2001";
        extension = [ ".xbox" ".iso" ] ++ commonExtensions;
        path = "${rompath}/XBOX";
        command = {
          "XEMU" = { cmd = "xemu -full-screen -dvd_path %ROM% "; };
          "JSRF CXBX-R" = { cmd = "lutris lutris:rungame/jsrf-cxbx-r"; };
        };
      };
    };
  };
}
