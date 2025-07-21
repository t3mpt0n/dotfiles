{
  pkgs,
  lib,
  ...
}: {
  home.packages = let
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
    retrofe
    alvr
    lunar-client
    gdlauncher-carbon
    runelite
    ];
}
