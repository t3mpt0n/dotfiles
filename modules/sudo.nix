{
  pkgs,
  ...
}: {
  security.sudo = {
    enable = true;
    execWheelOnly = true;
  };
}
