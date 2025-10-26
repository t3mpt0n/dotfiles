{
  lib,
  config,
  pkgs,
  ...
}: {
  options.jc'.srv = {
    aria2 = {
      enable = lib.mkEnableOption "aria2";
    };
  };
}
