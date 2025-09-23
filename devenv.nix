{ pkgs, lib, config, inputs, ... }:

{

  # https://devenv.sh/packages/
  packages = [
    pkgs.git
    pkgs.yaml-language-server
  ];

  languages = {
    nix = {
      enable = true;
      lsp.package = pkgs.nil;
    };
  };

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/git-hooks/
  # git-hooks.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
