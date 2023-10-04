{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs.python311Packages; [
    jedi
    pylint
  ];
}
