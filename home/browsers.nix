{
  programs = {
    firefox.enable = true;

    librewolf = {
      enable = true;

      languagePacks = [
        "en-US"
        "fr-FR"
      ];

      policies = {
        Cookies = {
          Allow = [
            "http://github.com"
            "https://github.com"
            "http://proton.me"
            "https://proton.me"
            "http://youtube.com"
            "https://youtube.com"
            "http://twitch.tv"
            "https://twitch.tv"
          ];
        };

        # Extensions
        ExtensionSettings =
          let
            moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
          in
          {
            "*".installation_mode = "allowed";

            "uBlock0@raymondhill.net" = {
              install_url = moz "ublock-origin";
              installation_mode = "force_installed";
              updates_disabled = true;
            };

            "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
              install_url = moz "vimium-ff";
              installation_mode = "force_installed";
              updates_disabled = true;
            };

            "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
              install_url = moz "bitwarden-password-manager";
              installation_mode = "force_installed";
              updates_disabled = true;
            };
          };
      };

      settings = {
        # Use KDE file picker
        "widget.use-xdg-desktop-portal.file-picker" = 1;

        # Enable Firefox sync
        "identity.fxaccounts.enabled" = true;
      };
    };
  };
}
