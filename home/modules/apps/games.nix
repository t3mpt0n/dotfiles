{
  pkgs,
  lib,
  ...
}: {
  home.packages = let
    retroarchCores = with pkgs.libretro; [
      fbneo # Final Burn Neo
      genesis-plus-gx # Sega Genesis and Sega CD Emulator
      beetle-saturn # Sega Saturn Emulator
      beetle-pce # PC ENGINE Emulator 
    ];
    in with pkgs; [
    parsec-bin
    lutris
    steam-rom-manager
    protontricks
    protonup-qt
    heroic-unwrapped
    gamemode
    pegasus-frontend
    iortcw
    libsForQt5.kget
    mangohud
    dualsensectl
    atlauncher
    trigger-control
    mame
    mame-tools
    gamepad-tool
    lunar-client
    osu-lazer-bin
    prismlauncher

    punes # NES Emulator
    ares # Multi-System Emulator
    retroarch-bare # Multi-System Emulator
    retroarch-assets # For Retroarch
    ] ++ retroarchCores;
}
