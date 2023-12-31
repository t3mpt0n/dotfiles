{
  inputs,
  ...
}: {
  home = {
    username = "jd";
    homeDirectory = "/home/jd";
    stateVersion = "24.05";
    extraOutputsToInstall = [ "doc" "devdoc" ];
  };

  programs.home-manager.enable = true;
}
