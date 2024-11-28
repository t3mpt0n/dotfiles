{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    haskell-language-server
  ];
}
