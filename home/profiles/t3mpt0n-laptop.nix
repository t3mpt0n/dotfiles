{
  pkgs,
  ...
}: {
  imports = [
    ../programs/git_laptop.nix
    ../.
  ];
}
