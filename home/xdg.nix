{
  # Default applications
  xdg.mimeApps = {
    enable = true;

    defaultApplications =
      let
        librewolf = "librewolf.desktop";
      in
      {
        "text/html" = librewolf;
        "x-scheme-handler/http" = librewolf;
        "x-scheme-handler/https" = librewolf;
        "x-scheme-handler/about" = librewolf;
        "x-scheme-handler/unknown" = librewolf;
      };
  };
}
