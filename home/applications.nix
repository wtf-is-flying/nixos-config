# Programs that don't fit anywhere else :)

{
  lib,
  pkgs,
  config,
  ...
}:

let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
in
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
    ++ lib.optionals isLinux [
      tailscale-systray
    ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    anki = lib.mkIf isLinux {
      enable = true;
      language = "en_US";

      profiles."User 1".sync.username = "learn.rethink836@slmail.me";
      profiles."User 1".sync.keyFile = config.sops.secrets.anki_key.path;
    };

    calibre.enable = isLinux;

    lazydocker.enable = true;

    mpv.enable = true;

    vesktop.enable = isLinux;
  };
}
