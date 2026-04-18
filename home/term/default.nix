{
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };

  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      command = "fish";
      font-family = "JetBrainsMono Nerd Font";
      font-size = 10;
      theme = "Everforest Dark Hard";
    };
  };
}
