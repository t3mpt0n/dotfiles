{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs.python311Packages; [
    jedi
    jedi-language-server
    pylint
  ];
}
