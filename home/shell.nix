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
        "\cp_default" = {
          name = "\cp";
          mode = "default";
          command = "up-or-search";
        };
        "\cp_insert" = {
          name = "\cp";
          mode = "insert";
          command = "up-or-search";
        };
        "\cn_default" = {
          name = "\cn";
          mode = "default";
          command = "up-or-search";
        };
        "\cn_insert" = {
          name = "\cn";
          mode = "insert";
          command = "up-or-search";
        };
      };

      shellAliases = {
        cat = "bat --style plain --pager never";
      };

      shellAbbrs = {
        dotdot = {
          regex = "^\\.\\.+$";
          function = "multicd";
        };
        gg = "lazygit";
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
