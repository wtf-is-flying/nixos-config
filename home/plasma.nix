{ pkgs, ... }:
{
  programs.plasma = {
    enable = true;

    # workspace = {
    #   wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Patak/contents/images/1080x1920.png";
    # };

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
