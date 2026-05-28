{ lib, pkgs, ... }:
let
  inherit (pkgs.stdenv) isLinux;
in
{
  programs.wezterm = {
    enable = true;
    settings = {
      default_prog = [
        (lib.getExe pkgs.fish)
      ];
      hide_tab_bar_if_only_one_tab = true;

      color_scheme = "Everforest Dark Hard (Gogh)";

      font = lib.generators.mkLuaInline ''
        wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" })
      '';
      font_size = if isLinux then 10 else 12;

      # Don't override SSH_AUTH_SOCK
      # https://github.com/wezterm/wezterm/issues/7324
      mux_enable_ssh_agent = false;
    };
  };
}
