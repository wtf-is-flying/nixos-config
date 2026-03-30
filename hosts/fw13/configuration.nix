# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  nixos-hardware,
  pkgs,
  ...
}:

{
  imports = [
    nixos-hardware.nixosModules.framework-amd-ai-300-series

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes + nix-command
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot = {
    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    # Use latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    initrd.luks.devices."luks-d95a766b-9673-4e5c-a47b-61354f25ba7b".device =
      "/dev/disk/by-uuid/d95a766b-9673-4e5c-a47b-61354f25ba7b";
  };

  networking = {
    hostName = "nixos";
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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

  services = {
    # Disable X11
    xserver.enable = false;

    # KDE Plasma
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    # Keymap in X11
    xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # CUPS to print documents
    printing.enable = true;

    # Sound with pipewire
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      # jack.enable = true;
    };
  };

  security.rtkit.enable = true;

  # Touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jy = {
    isNormalUser = true;
    description = "Jacques-Yves";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # List packages installed in system profile.
  # To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
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
