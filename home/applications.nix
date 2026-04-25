# Programs that don't fit anywhere else :)

{ pkgs, ... }:
{
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    lsof
    tree
    zip
    unzip

    btop
    jq
    just

    localsend
  ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    lazydocker = {
      enable = true;
    };

    vesktop.enable = true;
  };
}
