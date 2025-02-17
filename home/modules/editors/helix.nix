{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "gruvbox";
      editor = {
        bufferline = "multiple";
        cursorline = true;
        line-number = "relative";
        rulers = [ 120 ];
        true-color = true;
        end-of-line-diagnostics = "hint";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = {
          character = "|";
          render = true;
        };
        inline-diagnostics = {
          cursor-line = "error";
          other-lines = "disable";
        };
        statusline = {
          left = [
            "mode"
            "spinner"
            "version-control"
            "file-name"
          ];
        };
      };
    };

    languages = {
      language-server = {
        nixd = {
          command = "${lib.getExe pkgs.nixd}";
          config =
            let
              confFlake = ''(builtins.getFlake "${inputs.self}")'';
            in
            {
              nixpkgs.expr = "import ${confFlake}.inputs.nixpkgs { }";
              options = {
                system_opts.expr = "${confFlake}.nixosConfigurations.t3mpt0n";
                home_manager_opts.expr = "${confFlake}.nixosConfigurations.t3mpt0n.home-manager.users.jd";
              };
            };
        };

        pylsp = {
          command = "${lib.getExe pkgs.python313Packages.python-lsp-server}";
        };

        marksman = {
          command = "${lib.getExe pkgs.marksman}";
        };
      };

      language = [
        {
          # # NIX
          name = "nix";
          formatter.command = "${lib.getExe pkgs.nixfmt-rfc-style}";
          auto-format = true;
          file-types = [ "nix" ];
          language-servers = [ "nixd" ];
        }

        {
          ## PYTHON
          name = "python";
          formatter.command = "${lib.getExe pkgs.python313Packages.black}";
          auto-format = true;
          file-types = [ "py" ];
          language-servers = [
            "pylsp"
          ];
        }

        {
          ## MARKDOWN
          name = "markdown";
          auto-format = true;
          file-types = [ "md" ];
          language-servers = [
            "marksman"
          ];
        }
      ];
    };

    extraPackages = with pkgs; [
      python313Packages.rope
      python313Packages.pyflakes
      python313Packages.yapf
    ];
  };
}
