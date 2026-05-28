{
  programs = {
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
