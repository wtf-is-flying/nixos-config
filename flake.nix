{
  description = "NixOS configuration";

  # Inputs
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake.html#flake-inputs

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # lazyvim-nix
    lazyvim.url = "github:pfassina/lazyvim-nix";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-hardware,
      lazyvim,
      ...
    }:
    let
      # Shared Nixpkgs configuration
      nixpkgsConfig = {
        allowUnfree = true;
      };

      # Function for NixOS system configuration
      mkNixosConfiguration =
        hostname:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit nixos-hardware;
          };
          modules = [
            { nixpkgs.config = nixpkgsConfig; }
            ./hosts/${hostname}/configuration.nix
          ];
        };

      # Function for Home Manager configuration
      mkHomeManagerConfiguration =
        system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config = nixpkgsConfig;
          };
          modules = [
            ./home
          ];

          extraSpecialArgs = {
            inherit lazyvim; # ← add this
          };
          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
    in
    {
      nixosConfigurations = {
        fw13 = mkNixosConfiguration "fw13";
      };

      homeConfigurations."jy" = mkHomeManagerConfiguration "x86_64-linux";
    };
}
