{
  pkgs,
  ...
}: {
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad;
    enableExcludeWrapper = false;
  };
}
