{
  lib,
  pkgs,
  config,
  ...
}:
let
  commonFirefoxConfiguration = {
    languagePacks = [
      "en-US"
      "fr-FR"
    ];

    profiles.default = {
      isDefault = true;
      search = {
        force = true;
        default = "kagi";
        privateDefault = "ddg";
        engines = {
          kagi = {
            name = "Kagi";
            urls = [
              { template = "https://kagi.com/search?q={searchTerms}"; }
              {
                template = "https://kagisuggest.com/api/autosuggest?q={searchTerms}";
                type = "application/x-suggestions+json";
              }
            ];
            icon = "https://kagi.com/favicon.ico";
          };
        };
      };
      settings = {
        "browser.startup.homepage" = "about:home";
        "browser.search.suggest.enabled" = true;
        "browser.urlbar.suggest.searches" = true;

        # Enable Firefox sync
        "identity.fxaccounts.enabled" = true;

        # Vertical tabs
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.position_start" = false;
        "sidebar.visibility" = "always-show";

        # Layout
        "browser.uiCustomization.state" = builtins.toJSON {
          placements = {
            nav-bar = [
              "firefox-view-button"
              "back-button"
              "forward-button"
              "urlbar-container"
              "vertical-spacer"
              "alltabs-button"
              "sidebar-button"
              "unified-extensions-button"
              "ublock0_raymondhill_net-browser-action"
              "_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action"
            ];
            unified-extensions-area = [ "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action" ];
          };
          currentVersion = 23;
          newElementCount = 2;
        };
      }
      // lib.optionalAttrs pkgs.stdenv.isLinux {
        # Use KDE file picker
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };

    policies = {
      Cookies = {
        Allow =
          let
            domains = [
              "amazon.fr"
              "chatgpt.com"
              "claude.ai"
              "deezer.com"
              "devdocs.io"
              "doctolib.fr"
              "duckduckgo.com"
              "github.com"
              "google.com"
              "hltv.org"
              "instapaper.com"
              "kagi.com"
              "proton.me"
              "simplelogin.io"
              "trainline.fr"
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
  };
in
{
  programs = {
    chromium = {
      enable = true;
      package = pkgs.brave;
    };

    firefox =
      lib.recursiveUpdate commonFirefoxConfiguration {
        enable = true;

        profiles.default.settings = {
          # Disable irritating first-run stuff
          "browser.disableResetPrompt" = true;
          "browser.download.panel.shown" = true;
          "browser.feeds.showFirstRunUI" = false;
          "browser.messaging-system.whatsNewPanel.enabled" = false;
          "browser.rights.3.shown" = true;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.shell.defaultBrowserCheckCount" = 1;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.uitour.enabled" = false;
          "startup.homepage_override_url" = "";
          "trailhead.firstrun.didSeeAboutWelcome" = true;
          "browser.bookmarks.restore_default_bookmarks" = false;
          "browser.bookmarks.addedImportButton" = true;

          # Disable crappy home activity stream page
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
          "browser.newtabpage.blocked" = lib.genAttrs [
            # Youtube
            "26UbzFJ7qT9/4DhodHKA1Q=="
            # Facebook
            "4gPpjkxgZzXPVtuEoAL9Ig=="
            # Wikipedia
            "eV8/WsSLxHadrTL1gAxhug=="
            # Reddit
            "gLv0ja2RYVgxKdp0I5qwvA=="
            # Amazon
            "K00ILysCaEq8+bEqV/3nuw=="
            # Twitter
            "T9nJot5PurhJSy8n038xGA=="
          ] (_: 1);

          # Disable some telemetry
          "app.shield.optoutstudies.enabled" = false;
          "browser.discovery.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          "datareporting.healthreport.service.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.sessions.current.clean" = true;
          "devtools.onboarding.telemetry.logged" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.prompted" = 2;
          "toolkit.telemetry.rejected" = true;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "toolkit.telemetry.server" = "";
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.unifiedIsOptIn" = false;
          "toolkit.telemetry.updatePing.enabled" = false;

          # Disable "save password" prompt
          "signon.rememberSignons" = false;
          # Harden
          "privacy.trackingprotection.enabled" = true;
          "dom.security.https_only_mode" = true;
        };
      }
      // lib.optionalAttrs pkgs.stdenv.isLinux {
        configPath = "${config.xdg.configHome}/mozilla/firefox";
      };

    librewolf = lib.mkIf pkgs.stdenv.isLinux (
      lib.recursiveUpdate commonFirefoxConfiguration {
        enable = true;
      }
    );
  };
}
