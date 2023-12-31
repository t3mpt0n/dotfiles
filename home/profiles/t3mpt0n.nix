{
  self,
  ...
}: {
  imports = [
    ../programs
    ../wayland
    ../terminal
    ../custom/es-de
    ../custom/gzdoom
    ../shell
    ../.
    self.inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];
}
