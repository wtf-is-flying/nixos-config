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
        SearchEngines = {
          Add = [
            {
              Name = "Kagi";
              Alias = "kagi";
              URLTemplate = "https://kagi.com/search?q={searchTerms}";
              SuggestURLTemplate = "https://kagisuggest.com/api/autosuggest?q={searchTerms}";
            }
          ];

          Default = "Kagi";
        };

        Cookies = {
          Allow =
            let
              domains = [
                "deezer.com"
                "devdocs.io"
                "duckduckgo.com"
                "github.com"
                "instapaper.com"
                "kagi.com"
                "proton.me"
                "simplelogin.io"
                "twitch.tv"
                "youtube.com"
              ];
            in
            builtins.concatMap (d: [
              "http://${d}"
              "https://${d}"
            ]) domains;
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
        "browser.search.suggest.enabled" = true;

        # Use KDE file picker
        "widget.use-xdg-desktop-portal.file-picker" = 1;

        # Enable Firefox sync
        "identity.fxaccounts.enabled" = true;

        # Vertical tabs
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.position_start" = false;
        "sidebar.visibility" = "always-show";
      };
    };
  };
}
