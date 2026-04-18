{ pkgs, ... }:

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
      interactiveShellInit = builtins.readFile ./config.fish;
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

  services = {
    ssh-agent = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
