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

        metals = {
          command = "${lib.getExe pkgs.metals}";
        };

        clojure-lsp = {
          command = "${lib.getExe pkgs.clojure-lsp}";
        };

        elixir-ls = {
          command = "${lib.getExe pkgs.elixir_ls}";
        };

        texlab = {
          command = "${lib.getExe pkgs.texlab}";
          config = {
            texlab.build.onSave = true;
          };
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

        {
          ## SCALA
          name = "scala";
          formatter.command = "${lib.getExe pkgs.scalafmt}";
          auto-format = true;
          file-types = [
            "scala"
            "sbt"
          ];
          language-servers = [
            "metals"
          ];
        }

        {
          ## CLOJURE
          name = "clojure";
          formatter.command = "${lib.getExe pkgs.cljfmt}";
          auto-format = true;
          file-types = [ "clj" ];
          language-servers = [
            "clojure-lsp"
          ];
        }

        {
          ## ELIXIR
          name = "elixir";
          formatter.command = "${lib.getExe' pkgs.elixir "mix"} format";
          auto-format = true;
          file-types = [
            "ex"
            "exs"
          ];
          language-servers = [ "elixir-ls" ];
        }

        {
          ## LaTeX
          name = "latex";
          file-types = [ "tex" ];
          language-servers = [ "texlab" ];
        }
      ];
    };

    extraPackages = with pkgs; [
      python313Packages.rope
      python313Packages.pyflakes
      python313Packages.yapf
      texliveFull
    ];
  };
}
