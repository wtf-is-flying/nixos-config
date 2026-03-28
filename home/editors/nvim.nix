{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
  };

  xdg.configFile = {
    "nvim" = {
      source = ./nvim-config;
      recursive = true;
    };
  };
}
