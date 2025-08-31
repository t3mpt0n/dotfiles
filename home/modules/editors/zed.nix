{
  pkgs,
  lib,
  ...
}: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "basedpyright"
      "nix"
    ];
  };
}
