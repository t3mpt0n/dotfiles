{
  config,
  pkgs,
  ...
}: {
  services.mako = {
    enable = true;
    package = pkgs.mako;
    actions = true;
    anchor = "top-right";
    icons = true;
    font = "Fira Code 17";
    defaultTimeout = 3000;
    layer = "overlay";
    output = "HDMI-A-1";
  };
}
