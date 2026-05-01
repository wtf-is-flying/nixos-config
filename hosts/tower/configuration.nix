# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = [
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

    # Use latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;

    initrd.luks.devices."luks-d03e09d2-e7ca-4e30-a097-4a24a37b7858".device =
      "/dev/disk/by-uuid/d03e09d2-e7ca-4e30-a097-4a24a37b7858";
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Enable networking
    networkmanager.enable = true;

    firewall.allowedTCPPorts = [
      # localsend
      53317
    ];
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  i18n = {

    # Select internationalisation properties.
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
    };

    steam.enable = true;
  };

  hardware = {
    graphics.enable = true;

    # NVIDIA driver
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
    };
  };

  services = {
    # Enable the KDE Plasma Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    xserver = {
      # Enable the X11 windowing system.
      # You can disable this if you're only using the Wayland session.
      enable = true;

      videoDrivers = [ "nvidia" ];

      # Configure keymap in X11
      xkb = {
        layout = "fr";
        variant = "";
      };
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };

    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };

    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true; # only needed for Wayland
      openFirewall = true;

      # Enable hardware acceleration
      package = pkgs.sunshine.override { cudaSupport = true; };
    };

    tailscale = {
      # Enable tailscale at startup
      enable = true;

      # If you would like to use a preauthorized key
      # authKeyFile = "/run/secrets/tailscale_key";
    };
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

  # Configure console keymap
  console.keyMap = "fr";

  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jy = {
    isNormalUser = true;
    description = "Jacques-Yves";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];

    packages = with pkgs; [
      kdePackages.kate
      imagemagick
      signal-desktop
      tailscale-systray
    ];
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
