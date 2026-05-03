{
  imports = [
    ./applications.nix
    ./browsers.nix
    ./editors
    ./git.nix
    ./languages.nix
    ./plasma.nix
    ./shell
    ./sops.nix
    ./term
    ./tmux
  ];

  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "jy";
    homeDirectory = "/home/jy";

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

  # Default applications
  xdg.mimeApps = {
    enable = true;

    defaultApplications =
      let
        librewolf = "librewolf.desktop";
      in
      {
        "text/html" = librewolf;
        "x-scheme-handler/http" = librewolf;
        "x-scheme-handler/https" = librewolf;
        "x-scheme-handler/about" = librewolf;
        "x-scheme-handler/unknown" = librewolf;
      };
  };
}
