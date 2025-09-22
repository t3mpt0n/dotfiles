{
  pkgs,
  ...
}: {
  programs.lutris = {
    enable = true;
    defaultWinePackage = pkgs.proton-ge-bin;
    winePackages = [ pkgs.wineWow64Packages.full ];
  };
}
