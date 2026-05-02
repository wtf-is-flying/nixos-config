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
        nix.enable = true;

        rust.enable = true;

        python = {
          enable = true;
          installDependencies = true; # Install ruff
          installRuntimeDependencies = true; # Install python3
        };

        go = {
          enable = true;
          installDependencies = true; # Install gopls, gofumpt, etc.
          installRuntimeDependencies = true; # Install go compiler
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
