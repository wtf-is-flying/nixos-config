{
  programs = {
    ## Git =====================================================================

    git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
        user = {
          name = "wtf-is-flying";
          email = "106453261+wtf-is-flying@users.noreply.github.com";
        };
        fetch = {
          prune = true;
        };
        pull = {
          rebase = false;
        };
      };
    };

    lazygit = {
      enable = true;
      enableFishIntegration = true;
    };

    ## Jujutsu =================================================================

    jujutsu = {
      enable = true;

      settings = {
        user = {
          name = "wtf-is-flying";
          email = "106453261+wtf-is-flying@users.noreply.github.com";
        };
        ui = {
          pager = "less -FRX";
          "default-command" = "log";
        };
      };
    };

    jjui.enable = true;
  };
}
