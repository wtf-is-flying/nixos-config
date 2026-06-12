{
  lazyvim-nix,
  ...
}:
{
  imports = [ lazyvim-nix.homeManagerModules.default ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
  };

  programs.lazyvim = {
    enable = true;
    configFiles = ./config/lazyvim;

    extras = {
      coding.yanky.enable = true;

      formatting = {
        prettier = {
          enable = true;
          installDependencies = true;
        };
      };

      lang = {
        docker = {
          enable = true;
          installDependencies = true;
        };

        go = {
          enable = true;
          installDependencies = true; # Install gopls, gofumpt, etc.
        };

        helm = {
          enable = true;
          installDependencies = true;
        };

        nix = {
          enable = true;
          installDependencies = true;
        };

        python = {
          enable = true;
          installDependencies = true; # Install ruff
        };

        rust = {
          enable = true;
          installDependencies = true;
        };

        sql = {
          enable = true;
          installDependencies = true;
        };

        toml = {
          enable = true;
        };

        typst = {
          enable = true;
          installDependencies = true;
        };

        yaml = {
          enable = true;
          installDependencies = true;
        };
      };

      test.core.enable = true;
    };

    # Additional packages (optional)
    # extraPackages = with pkgs; [
    #   nixd # Nix LSP
    #   alejandra # Nix formatter
    # ];

    # Only needed for languages not covered by LazyVim extras
    # treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
    #   wgsl # WebGPU Shading Language
    #   templ # Go templ files
    # ];
  };
}
