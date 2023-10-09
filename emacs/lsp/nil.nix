{
  pkgs,
  lib,
  inputs,
  ...
}: {
  nixpkgs.overlays = [ inputs.nil.overlays.default ];
  environment.systemPackages = [
    pkgs.nil
  ];
}
