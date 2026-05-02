{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
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
    hostName = "tower";

    # Enables wireless support via wpa_supplicant.
    # networking.wireless.enable = true;
  };

  hardware = {
    # Hardware acceleration
    graphics.enable = true;

    # NVIDIA driver
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
    };
  };

  services = {
    # KDE Plasma
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    # Sound
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };

    # Sunshine
    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true; # only needed for Wayland
      openFirewall = true;

      # Enable hardware acceleration
      package = pkgs.sunshine.override { cudaSupport = true; };
    };

    xserver = {
      videoDrivers = [ "nvidia" ];
    };
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jy = {
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
