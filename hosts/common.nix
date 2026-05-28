# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes + nix-command
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking = {
    # Enable networking
    networkmanager.enable = true;

    firewall.allowedTCPPorts = [
      # localsend
      53317
    ];
  };

  # Time zone
  time.timeZone = "Europe/Paris";

  # Internationalisation
  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };

  programs = {
    ssh = {
      startAgent = true;
      enableAskPassword = true;
      extraConfig = "
      Host vps
        Hostname 82.165.182.162
        Port 9274
        User jy
    ";
    };

    steam.enable = true;
  };

  services = {
    # Kanata
    kanata = {
      enable = true;

      keyboards.default = {
        extraDefCfg = ''
          process-unmapped-keys yes
        '';
        config = ''
          #|
              Keymap: https://github.com/jtroo/kanata/blob/209f173f6fdda371cc21bad3cf2c3b9b7328b85b/parser/src/keys/mod.rs#L176
          |#

          (defsrc
              caps
          )

          (deflayer default
              @cap
          )

          (defalias
              cap (tap-hold-press 0 200 esc lctl)
          )
        '';
      };
    };

    # Mullvad VPN
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };

    # Tailscale
    tailscale = {
      enable = true;
    };

    # Disable X11
    xserver.enable = false;
  };

  # List packages installed in system profile.
  # To search, run: $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      curl
      usbutils
      vim
      wget
    ];

    variables = {
      SSH_ASKPASS_REQUIRE = "prefer";
    };
  };

  security = {
    rtkit.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jy = {
    isNormalUser = true;
    description = "Jacques-Yves";
    extraGroups = [
      "networkmanager"
      "uinput" # Required by Kanata
      "wheel"
    ];
  };

  # Fonts
  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.jetbrains-mono
    roboto
    source-sans
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
