{
  pkgs,
  inputs,
  ...
}: {
  home.packages =
    let
      rom_tools = with pkgs; [
        flips
      ];
    in [
      inputs.self.outputs.packages.x86_64-linux.ares
    ] ++ rom_tools;
}
