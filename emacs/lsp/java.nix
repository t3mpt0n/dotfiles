{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    maven
    gradle
    jdt-language-server
    jdk
  ];
}
