{
  lib,
  modulesPath,
  pkgs,
  ...
}@args:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes + nix-command
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services = {
    openssh = {
      enable = true;
      ports = [
        9274
      ];
    };

    endlessh = {
      enable = true;
      port = 22;
      openFirewall = true;
    };

    pihole-ftl = {
      enable = true;
      settings = {
        # See <https://docs.pi-hole.net/ftldns/configfile/>

        # External DNS Servers quad9 and cloudflare
        dns.upstreams = [
          "9.9.9.9"
          "1.1.1.1"
        ];
      };

      lists = [
        # Lists can be added via URL
        {
          url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt";
          type = "block";
          enabled = true;
          description = "hagezi blocklist";
        }
      ];
    };

    pihole-web = {
      enable = true;
      ports = [
        80
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    curl
    gitMinimal
    neovim
  ];

  users.users = {
    root.openssh.authorizedKeys.keys = [
      # change this to your ssh key
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOfvrsaCAuzwcIXCPuWRIC3Fhu9YGblKV6CiCXdr5gXr jy@nixos"
    ]
    ++ (args.extraPublicKeys or [ ]); # this is used for unit-testing this module and can be removed if not needed

    jy = {
      isNormalUser = true;
      description = "Jacques-Yves";
      extraGroups = [
        "wheel"
      ];
      packages = with pkgs; [
        bind
      ];
    };
  };

  system.stateVersion = "25.11";
}
