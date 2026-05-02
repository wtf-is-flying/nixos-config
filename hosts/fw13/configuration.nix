{
  nixos-hardware,
  pkgs,
  ...
}:

{
  imports = [
    nixos-hardware.nixosModules.framework-amd-ai-300-series

    ./hardware-configuration.nix
    ../common.nix
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
    hostName = "fw13";

    # Enables wireless support via wpa_supplicant.
    # wireless.enable = true;
  };

  services = {
    # KDE Plasma
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;

    # Sound
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      # jack.enable = true;
    };

    # CUPS to print documents
    printing.enable = true;

    udev = {
      enable = true;
      # Fix fprintd after sleep
      # https://wiki.archlinux.org/title/Fprint#fprintd_starts_before_fingerprint_reader_device_is_initialized_after_resuming_from_sleep
      extraRules = ''
        ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="27c6", ATTRS{idProduct}=="609c", ATTR{power/persist}="1", RUN="${pkgs.coreutils}/bin/chmod 444 %S%p/../power/persist"
      '';
    };

    # Keymap in X11
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };

  security = {
    # Disable fingerprint login
    # SDDM gets stuck waiting for fingerprint when it is enabled.
    # See: https://github.com/NixOS/nixpkgs/issues/239770
    pam.services.login.fprintAuth = false;
  };

  # Touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jy = {
    packages = with pkgs; [
      moonlight-qt
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
