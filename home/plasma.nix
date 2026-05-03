{
  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breezetwilight.desktop";
      wallpaper = ../assets/wallpaper.png;
    };

    shortcuts = {
      kwin.Overview = [ "Meta" ];
      plasmashell."activate application launcher" = [ "Alt+F1" ];
      "services/com.mitchellh.ghostty.desktop"._launch = "Meta+Return";
    };

    panels = [
      {
        location = "bottom";
        floating = true;
        height = 44;
      }
    ];

    input.keyboard = {
      layouts = [
        {
          layout = "us";
          variant = "colemak_dh";
        }
        {
          layout = "fr";
        }
      ];

      options = [ "caps:escape" ];
    };

    # powerdevil = {
    #   AC = {
    #     powerButtonAction = "lockScreen";
    #     autoSuspend = {
    #       action = "shutDown";
    #       idleTimeout = 1000;
    #     };
    #     turnOffDisplay = {
    #       idleTimeout = 1000;
    #       idleTimeoutWhenLocked = "immediately";
    #     };
    #   };
    #   battery = {
    #     powerButtonAction = "sleep";
    #     whenSleepingEnter = "standbyThenHibernate";
    #   };
    #   lowBattery = {
    #     whenLaptopLidClosed = "hibernate";
    #   };
    # };
  };
}
