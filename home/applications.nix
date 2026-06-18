# Programs that don't fit anywhere else :)

{
  pkgs,
  config,
  ...
}:
{
  # Packages that should be installed to the user profile.
  home.packages =
    with pkgs;
    [
      btop
      imagemagick
      jq
      just
      localsend
      lsof
      qbittorrent
      signal-desktop
      sops
      tree
      unzip
      zip
    ]
    ++ lib.optionals stdenv.isLinux [
      tailscale-systray
    ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    anki = {
      enable = true;
      language = "en_US";
      sync.username = "learn.rethink836@slmail.me";
      sync.keyFile = config.sops.secrets.anki_key.path;
    };

    lazydocker.enable = true;

    mpv.enable = true;

    vesktop.enable = pkgs.stdenv.isLinux;
  };
}
