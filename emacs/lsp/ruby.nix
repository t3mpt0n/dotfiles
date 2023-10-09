{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    (ruby.withPackages (ru: with ru; [
      solargraph
    ]))
    rubocop
  ];
}
