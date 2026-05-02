{
  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breezetwilight.desktop";
      wallpaper = ../assets/wallpaper.png;
    };

    shortcuts = {
      "services/com.mitchellh.ghostty.desktop"._launch = "Meta+Return";
    };

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
