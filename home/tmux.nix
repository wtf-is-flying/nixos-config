{ lib, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "a";

    shell = lib.getExe pkgs.fish;
    terminal = "screen-256color";

    mouse = true;
    keyMode = "vi";
    escapeTime = 0; # Fix slow vi mode

    historyLimit = 50000;
    baseIndex = 1;
    focusEvents = true;

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
    ];

    extraConfig = builtins.readFile ./config/tmux/tmux.conf;
  };
}
