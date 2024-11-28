{
  lib,
  inputs,
  pkgs,
  self,
  ...
}: let
  inherit (pkgs) fetchurl fetchzip fetchFromGitHub fetchFromGitLab appimageTools;
  inherit (self.outputs.packages.x86_64-linux) nestopia dsda-doom;
  inherit (inputs.gaming.packages.x86_64-linux) es-de mesen;
  gamescopecmd = "gamescope -W 2560 -H 1440 -w 2560 -h 1440 -r 60 -O DP-3 --xwayland-count 1 --adaptive-sync --fullscreen";
#  rpcs3 = appimageTools.wrapType2 {
#    name = "rpcs3";
#    src = fetchurl {
#      url = "https://github.com/RPCS3/rpcs3-binaries-linux/releases/download/build-f1f124dcbfb248e3347b56c08eb2935752faee69/rpcs3-v0.0.33-17032-f1f124dc_linux64.AppImage";
#      hash = "sha256-DWsANO15KjLsNqzLyKHeiCDOw83oIGiUAesTpYDGkhY=";
#    };
#    extraPkgs = p: with p; [ kdePackages.qtbase kdePackages.qtmultimedia openal glew vulkan-headers vulkan-loader libpng ffmpeg libevdev zlib libusb1 curl wolfssl python3 pugixml SDL2 flatbuffers llvm_16 xorg.libSM];
#  };
  xemu131 = pkgs.xemu.overrideAttrs (finalAttrs: previousAttrs: {
    pname = previousAttrs.pname;
    version = "0.7.131";

    src = fetchFromGitHub {
      owner = "xemu-project";
      repo = "xemu";
      rev = "v${finalAttrs.version}";
      fetchSubmodules = true;
      hash = "sha256-xupCEqTovrEA7qEEr9nBjO7iIbTeXv59cg99W6Nc/54=";
    };
  });
  RetroarchCorePath = "/lib/retroarch/cores/";
  fuae-launch = pkgs.fsuae-launcher.overrideAttrs (finalAttrs: previousAttrs: {
    pname = previousAttrs.pname;
    version = "3.1.66";
    src = pkgs.fetchurl {
      url = "https://fs-uae.net/files/FS-UAE-Launcher/Stable/${finalAttrs.version}/fs-uae-launcher-${finalAttrs.version}.tar.xz";
      hash = "sha256-R/CQaeW0dMApXpieE+3vDrdsWYL979luxi4LU2Ogjr4=";
    };

    buildInputs = with pkgs.python3Packages; [
      distutils
    ] ++ previousAttrs.buildInputs;
  });
  ryujinx-mirror = appimageTools.wrapType2 {
    name = "ryujinx";
    src = fetchurl {
      url = "https://github.com/ryujinx-mirror/ryujinx/releases/download/r.49574a9/ryujinx-r.49574a9-x64.AppImage";
      hash = "sha256-OQAXTwPwzwtZL1KZCVI/Aj2OEh+XB6H7MBjUH8+/KrM=";
    };
    extraPkgs = p: with p; [ xorg.libX11 libgdiplus ffmpeg openal libsoundio sndio pulseaudio vulkan-loader xorg.libICE xorg.libSM xorg.libXi xorg.libXcursor xorg.libXext xorg.libXrandr fontconfig glew libGL udev SDL2 SDL2_mixer icu ];
  };
in rec {
  programs.emulationstation = {
    enable = true;
    package = es-de;
    emulators = [
      pkgs.ares
      pkgs.retroarchBare
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
        emulators = with pkgs; [ fceux punes nestopia ] ++ [ mesen ];
        fullname = "Nintendo Entertainment System";
        systemsortname = "nint1985";
        extension = [ ".nes" ".NES" ] ++ commonExtensions;
        path = "${rompath}/NES";
        command = {
          "NESTopia (Standalone)" = {cmd = "nestopia --fullscreen %ROM%";};
          "FCEUX (Standalone)" = {cmd = "env QT_QPA_PLATFORM=xcb fceux %ROM% --fullscreen 1";};
          "Mesen (Standalone)" = {cmd = "env SDL_VIDEODRIVER=x11 mesen %ROM% --fullscreen"; };
        };
      };
      "famicom" = {
        inherit (nes) emulators extension command;
        fullname = "Nintendo Family Computer";
        systemsortname = "nint1983";
        path = "${rompath}/FC";
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
      "gba" = {
        emulators = with pkgs; [ mgba ];
        fullname = "Nintendo GameBoy Advance";
        systemsortname = "nint2001";
        extension = [ ".gba" ".GBA" ] ++ commonExtensions;
        path = "${rompath}/GBA";
        command = {
          "MGBA" = {cmd = "mgba %ROM%";};
        };
      };
      "nds" = {
        emulators = with pkgs; [ melonDS ];
        fullname = "Nintendo DS";
        systemsortname = "nint2004";
        extension = [ ".nds" ".NDS" ] ++ commonExtensions;
        path = "${rompath}/NDS";
        command = {
          "MelonDS" = { cmd = ""; };
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
          "bsnes" = {cmd = "${gamescopecmd} -- bsnes --fullscreen %ROM%";};
          "Mesen (standalone)" = {cmd = "env SDL_VIDEODRIVER=x11 mesen --fullscreen %ROM%";};
        };
      };
      "sfc" = {
        inherit (snesna) emulators command extension;
        fullname = "Super Famicom";
        systemsortname = "nint1990";
        path = "${rompath}/SFC";
      };
      "n64" = {
        emulators = with pkgs; [ mupen64plus libretro.parallel-n64 ];
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
        emulators = [ ryujinx-mirror ];
        fullname = "Nintendo Switch";
        systemsortname = "nint2017";
        extension = [ ".xci" ".XCI" ".nsp" ".NSP" ] ++ commonExtensions;
        path = "${rompath}/Switch";
        command = {
          "Ryujinx" = {cmd = "ryujinx %ROM%";};
          "Yuzu" = {cmd = "yuzu %ROM%";};
        };
      };
      "mastersystem" = {
        emulators = with pkgs; [ libretro.genesis-plus-gx ];
        fullname = "Sega Master System";
        systemsortname = "sega1986";
        extension = [".sms" ".SMS"] ++ commonExtensions;
        path = "${rompath}/SMS";
        command = {
          "SMS Plus GX (RetroArch)" = { cmd = "retroarch -L genesis_plus_gx_libretro.so %ROM%"; };
        };
      };
      "genesis" = {
        emulators = with pkgs; [ libretro.blastem libretro.genesis-plus-gx ];
        fullname = "Sega Genesis";
        systemsortname = "sega1989us";
        extension = [ ".bin" ".BIN" ".md" ".MD" ".gen" ".GEN" ] ++ commonExtensions;
        path = "${rompath}/Genesis";
        command = {
          "RetroArch (Blastem)" = { cmd = "retroarch -L blastem_libretro.so %ROM%"; };
          "RetroArch (Genesis Plus GX)" = { cmd = "retroarch -L genesis_plus_gx_libretro.so %ROM%"; };
        };
      };
      "megadrivejp" = {
        inherit (genesis) emulators extension command;
        fullname = "Sega Mega Drive";
        systemsortname = "sega1988";
        path = "${rompath}/MD";
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
      "model2" = {
        emulators = with pkgs; [];
        fullname = "Sega Model 2";
        systemsortname = "sega1993";
        extension = commonExtensions;
        path = "${rompath}/MODEL2";
        command = {
          "M2EMU" = {
            cmd = "/home/jd/Games/M2Emu.sh %BASENAME%";
          };
        };
      };
      "model3" = {
        emulators = with pkgs; [ supermodel ];
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
        emulators = with pkgs; [ libretro.picodrive ];
        fullname = "Sega 32X";
        systemsortname = "sega1994";
        extension = [ ".32x" ] ++ commonExtensions;
        path = "${rompath}/32X";
        command = {
          "RetroArch (PicoDrive)" = { cmd = "retroarch -L picodrive_libretro.so %ROM%"; };
        };
      };
      "saturn" = {
        emulators = with pkgs; [ libretro.beetle-saturn ];
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
        emulators = with pkgs; [ duckstation libretro.beetle-psx-hw libretro.beetle-psx ];
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
        emulators = [ pkgs.rpcs3 ];
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
        emulators = with pkgs; [ libretro.fbneo ];
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
        emulators = [ pkgs.fsuae fuae-launch ];
        fullname = "Commodore Amiga";
        systemsortname = "cmdor1985";
        extension = [ ".adf" ".ADF" ".lha" ".LHA" ] ++ commonExtensions;
        path = "${rompath}/Amiga";
        command = {
          "FSUAE" = { cmd = ""; };
        };
      };
      "x68000" = {
        emulators = with pkgs; [ ];
        fullname = "Sharp X68000";
        systemsortname = "sharp1987";
        extension = commonExtensions;
        path = "${rompath}/SX68K/x68k_flop";
        command = {
          "MAME (Standalone)" = { cmd = "mame x68000 %BASENAME%"; };
        };
      };
      "xbox" = {
        emulators = [ xemu131 ];
        fullname = "Microsoft XBOX";
        systemsortname = "micsoft2001";
        extension = [ ".xbox" ".iso" ] ++ commonExtensions;
        path = "${rompath}/XBOX";
        command = {
          "XEMU" = { cmd = "xemu -full-screen -dvd_path %ROM% "; };
        };
      };
      "tg16" = {
        emulators = with pkgs; [ ];
        fullname = "NEC Turbografx 16";
        systemsortname = "nec1989a";
        extension = [ ".pce" ] ++ commonExtensions;
        path = "${rompath}/TG16";
        command = {
          "Mednafen (Standalone)" = { cmd = "mednafen %ROM%"; };
        };
      };
      "tg-cd" = {
        emulators = with pkgs; [ libretro.beetle-pce ];
        fullname = "NEC Turbografx CD";
        systemsortname = "nec1989b";
        extension = [ ".chd" ".CHD" ] ++ commonExtensions;
        path = "${rompath}/TGCD";
        command = {
          "Mednafen (Standalone)" = { cmd = "mednafen %ROM%"; };
          "Retroarch (Beetle PCE)" = { cmd = "retroarch -L ${pkgs.libretro.beetle-pce}${RetroarchCorePath}mednafen_pce_libretro.so %ROM%"; };
        };
      };
      "pcenginecd" = {
        inherit (tg-cd) emulators extension command;
        fullname = "NEC PC Engine CD-ROM2";
        systemsortname = "nec1988";
        path = "${rompath}/CDROM2";
      };
      
#      "msx" = {
#        emulators = with pkgs; [ openmsx ];
#        fullname = "MSX";
#        systemsortname = "mic1983";
#        extension = [ ];
#        path = "${rompath}/MSX";
#        command = {};
#      };
      "lutris" = {
        emulators = [];
        fullname = "Lutris";
        systemsortname = "lutris";
        extension = [ ".sh" ];
        path = "/home/jd/Media/Games/PC/Scripts";
        command = {
          "Execute Bash Script" = { cmd = "steam-run %ROM%"; };
        };
      };
    };
  };
}
