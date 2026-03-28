{
  programs = {
    git = {
      enable = true;
      settings = {
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

  };
}
