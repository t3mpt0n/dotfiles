{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    vscode-langservers-extracted
    typescript-language-server
    nodePackages_latest.browser-sync
  ];
}
