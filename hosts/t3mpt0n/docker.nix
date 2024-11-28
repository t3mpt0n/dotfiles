{
  pkgs,
  lib,
  ...
}: {
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
