{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    package = if pkgs.stdenv.isLinux then pkgs.ghostty else pkgs.ghostty-bin;
    settings = {
      command = "fish";
      font-family = "JetBrainsMono Nerd Font";
      font-size = 10;
      theme = "Vague";
    };
  };
}
