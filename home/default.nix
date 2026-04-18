{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./kanata
    ./tmux
    ./shell
    ./term
    ./editors
    ./browsers.nix
  ];

  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "jy";
    homeDirectory = "/home/jy";

    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      lsof
      tree
      zip
      unzip

      cargo
      rustc
      gcc
      go
      lua-language-server
      nixfmt
      nil
      nodejs_24
      python3
      rust-analyzer
      statix
      stylua
      tree-sitter
      uv

      btop
      jq
      just

      localsend
    ];

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "25.11";
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    lazydocker = {
      enable = true;
    };

    vesktop.enable = true;
  };
}
