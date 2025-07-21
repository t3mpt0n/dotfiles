{
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.self.outputs.packages.x86_64-linux.extract-xiso
  ];
}
