{
  self,
  ...
}: {
  imports = [
    ../programs
    ../wayland
    ../terminal
    ../custom/es-de
    ../shell
    ../.
    self.inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];
}
