{ pkgs, config, ... }:

{
  home = {
    packages = with pkgs; [
      bat
      fd
      ripgrep
      tealdeer
      yazi
    ];
  };

  programs = {
    atuin = {
      enable = true;
      enableFishIntegration = true;

      settings = {
        enter_accept = true;
        logs = {
          enabled = true;
          dir = "${config.xdg.stateHome}/atuin/logs";
        };
      };
    };

    direnv = {
      enable = true;
      # Should not be needed
      # enableFishIntegration = true;
    };

    eza = {
      enable = true;
      enableFishIntegration = true;
    };

    fish = {
      enable = true;
      interactiveShellInit = builtins.readFile ./config/fish/config.fish;
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

  };
}
