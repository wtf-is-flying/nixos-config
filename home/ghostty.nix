{ lib, pkgs, ... }:
let
  inherit (pkgs.stdenv) isLinux;
in
{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    package = if isLinux then pkgs.ghostty else pkgs.ghostty-bin;
    settings = {
      command = lib.getExe pkgs.fish;
      font-family = "JetBrainsMono Nerd Font";
      font-size = if isLinux then 10 else 12;
      theme = "Vague";
    };
  };
}
