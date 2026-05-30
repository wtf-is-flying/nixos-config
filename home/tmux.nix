{ lib, pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    shell = lib.getExe pkgs.fish;
    terminal = "tmux-256color";

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
      tmuxPlugins.tmux-toggle-popup
    ];

    extraConfig = builtins.readFile ./config/tmux/tmux.conf;
  };

  # Patch tmux-256color terminfo to add undercurl support
  home.activation.compileUndercurlTerminfo = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    verboseEcho "Compiling tmux-256color terminfo with Smulx (undercurl) support"
    run mkdir -p "$HOME/.terminfo"
    cat > /tmp/tmux-256color.ti << 'EOF'
    ${builtins.readFile ./config/tmux/tmux-256color.ti}
    EOF
    run tic -x -o "$HOME/.terminfo" /tmp/tmux-256color.ti
  '';

}
