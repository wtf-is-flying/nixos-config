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
      enable = false;
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
      icons = "auto";
      extraOptions = [
        "--group-directories-first"
      ];
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting "" # Disable the welcome message
        set -g fish_key_bindings fish_vi_key_bindings # Enable Vi mode natively
      '';

      functions = {
        "multicd" = "echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)";
      };

      binds = {
        "up_default" = {
          name = "\\cp";
          mode = "default";
          command = "up-or-search";
        };
        "up_insert" = {
          name = "\\cp";
          mode = "insert";
          command = "up-or-search";
        };
        "down_default" = {
          name = "\\cn";
          mode = "default";
          command = "down-or-search";
        };
        "down_insert" = {
          name = "\\cn";
          mode = "insert";
          command = "down-or-search";
        };
      };

      shellAliases = {
        cat = "bat --style plain --pager never";
        l = "eza -l";
        la = "eza -la";
        ls = "eza";
      };

      shellAbbrs = {
        dotdot = {
          regex = "^\\.\\.+$";
          function = "multicd";
        };
        g = "lazygit";
        j = "jjui";
        lzd = "lazydocker";
        pc = "process-compose";
        rr = "rops run";
        vi = "nvim";
      };
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
