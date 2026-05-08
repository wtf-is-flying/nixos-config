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
    configFiles = ./lazyvim-config;

    extras = {
      lang = {
        go = {
          enable = true;
          installDependencies = true; # Install gopls, gofumpt, etc.
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

        typst = {
          enable = true;
          installDependencies = true;
        };
      };
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
