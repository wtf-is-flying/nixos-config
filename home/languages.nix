{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # C
      gcc

      # Go
      go

      # Lua
      lua-language-server
      stylua

      # Markdown
      markdownlint-cli2

      # Nix
      nil
      nixfmt
      statix

      # Node
      nodejs_24

      # Python
      basedpyright
      python3
      uv

      # Rust
      cargo
      clippy
      rust-analyzer
      rustc
      rustfmt

      # SQL
      sqlfluff

      # TOML
      taplo

      # Typst
      tinymist
      typst
      typstyle

      # Utils
      tree-sitter
    ];
  };

  programs = {
    ruff = {
      enable = true;
      settings = {
        target-version = "py312";

        line-length = 89;
        indent-width = 4;

        exclude = [
          ".bzr"
          ".direnv"
          ".eggs"
          ".git"
          ".git-rewrite"
          ".hg"
          ".ipynb_checkpoints"
          ".mypy_cache"
          ".nox"
          ".pants.d"
          ".pyenv"
          ".pytest_cache"
          ".pytype"
          ".ruff_cache"
          ".svn"
          ".tox"
          ".venv"
          ".vscode"
          "__pypackages__"
          "_build"
          "buck-out"
          "build"
          "dist"
          "node_modules"
          "site-packages"
          "venv"
        ];

        lint = {
          select = [
            "E"
            "W"
            "F"
            "UP"
            "B"
            "N804"
            "N805"
            "SIM"
            "I"
            "D"
            "ANN001"
            "ANN201"
            "ANN205"
            "ANN206"
            "S"
            "A"
            "COM"
            "C4"
            "EM"
            "FA"
            "ISC"
            "ICN"
            "LOG"
            "G"
            "PIE"
            "PT"
            "Q"
            "RSE"
            "RET"
            "TID252"
            "TC001"
            "TC002"
            "TC003"
            "TC004"
            "TC005"
            "TC010"
            "PLC0208"
            "PLC2801"
            "PLE"
          ];

          ignore = [
            "RET503"
            "D100"
            "D101"
            "D102"
            "D103"
            "D104"
            "D105"
            "D106"
            "D107"
            "W191"
            "E111"
            "E114"
            "E117"
            "D206"
            "D300"
            "Q000"
            "Q001"
            "Q003"
            "COM812"
            "COM819"
            "E501"
          ];

          fixable = [ "ALL" ];
          unfixable = [ ];

          dummy-variable-rgx = "^(_+|(_+[a-zA-Z0-9_]*[a-zA-Z0-9]+?))$";

          per-file-ignores = {
            # "__init__.py" = [ "E402" ];
            # "**/{tests,test,docs}/**" = [
            #   "E402"
            #   "D"
            #   "ANN"
            #   "S101"
            # ];
            "*_pb2.py" = [ "ALL" ];
            "*_pb2.pyi" = [ "ALL" ];
          };

          isort = {
            combine-as-imports = true;
          };

          pycodestyle = {
            max-doc-length = 100;
            max-line-length = 100;
          };

          pydocstyle = {
            convention = "google";
          };

          flake8-type-checking = {
            runtime-evaluated-base-classes = [ "pydantic.BaseModel" ];
          };
        };

        format = {
          quote-style = "double";
          indent-style = "space";
          skip-magic-trailing-comma = false;
          line-ending = "auto";
          docstring-code-format = true;
          docstring-code-line-length = "dynamic";
          exclude = [
            "*_pb2.py"
            "*_pb2.pyi"
          ];
        };
      };
    };
  };
}
