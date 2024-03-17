{
  lib,
  inputs,
  pkgs,
  self,
  ...
}: let
  inherit (pkgs) fetchFromGitHub fetchFromGitLab;
  inherit (self.outputs.packages.x86_64-linux) nestopia dsda-doom;
  fceux = (pkgs.fceux.overrideAttrs (oldAttrs: rec {
    version = "2.6.6";
    src = fetchFromGitHub {
      owner = "TASEmulators";
      repo = "fceux";
      rev = "v${version}";
      sha256 = "sha256-Wp23oLapMqQtL2DCkm2xX1vodtEr/XNSOErf3nrFRQs=";
    };
  }));

  es-de = (pkgs.emulationstation-de.overrideAttrs (oldAttrs: rec {
    version = "3.0.0";
    src = fetchFromGitLab {
      owner = "es-de";
      repo = "emulationstation-de";
      rev = "v${version}";
      sha256 = "sha256-BAfsRXh1o5AUPCEaMcrJwOQOOdSENdmGpl3wjbsCDzM=";
    };
    installPhase = ''
    '';
  }));
  gamescopecmd = "gamescope -W 2560 -H 1440 -w 2560 -h 1440 -r 60 -O DP-3 --xwayland-count 1 --adaptive-sync --fullscreen";
in rec {
  programs.emulationstation = {
    enable = true;
    package = es-de;
    emulators = [
      pkgs.ares
      pkgs.retroarchFull
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
        emulators = with pkgs; [ ];
        fullname = "Nintendo Wii U";
        systemsortname = "nint2012";
        extension = [ ".wua" ".WUA" ] ++ commonExtensions;
        path = "${rompath}/Wii U";
        command = {
          "CEMU" = {};
        };
      };
      "switch" = {
        emulators = with pkgs; [yuzu-early-access ryujinx];
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
          "RetroArch (Blastem)" = { cmd = "retroarch -L ${pkgs.retroarchFull.outPath}/lib/retroarch/cores/blastem_libretro.so %ROM%"; };
          "RetroArch (Genesis Plus GX)" = { cmd = "retroarch -L ${pkgs.retroarchFull.outPath}/lib/retroarch/cores/genesis_plus_gx_libretro.so %ROM%"; };
        };
      };
      "sega32xna" = {
        emulators = with pkgs; [];
        fullname = "Sega 32X";
        systemsortname = "sega1994";
        extension = [ ".32x" ] ++ commonExtensions;
        path = "${rompath}/32X";
        command = {
          "RetroArch (PicoDrive)" = { cmd = "retroarch -L ${pkgs.retroarchFull.outPath}/lib/retroarch/cores/picodrive_libretro.so %ROM%"; };
        };
      };
      "saturn" = {
        emulators = with pkgs; [];
        fullname = "Sega Saturn";
        systemsortname = "sega1994";
        extension = [ ".bin" ".BIN" ".cue" ".CUE" ".chd" ".CHD" ] ++ commonExtensions;
        path = "${rompath}/Saturn";
        command = {
          "RetroArch (Beetle Saturn)" = { cmd = "retroarch -L ${pkgs.retroarchFull.outPath}/lib/retroarch/cores/mednafen_saturn_libretro.so %ROM%"; };
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
        extension = [".bin" ".BIN" ".chd" ".CHD" ".m3u" ".M3U" ] ++ commonExtensions;
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
      "ps3" = {
        emulators = with pkgs; [ rpcs3 ];
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
      "windows" = rec {
        fullname = "Microsoft Windows";
        systemsortname = "micsoftwin";
        extension = [ ".desktop" ".DESKTOP" ".sh" ".SH" ] ++ commonExtensions;
        path = "/home/jd/Desktop/Lutris";
        command = {
          "Run Lutris" = { cmd = "cat %ROM% | grep -i 'Exec=' | sed 's/Exec=//g' | bash"; };
        };
      };
    };
  };
}
