{
  inputs,
  ...
}:
{
  imports = [
    ./extra.nix
    ./opts.nix
    ./plugins
    ./colors.nix
    ./performance.nix
  ];
  globals = {
    mapleader = " ";
    maplocalleader = ",";
  };
}
