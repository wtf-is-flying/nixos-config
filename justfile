# List recipes
default:
    just --list

# Apply NixOS configuration
deploy host:
    sudo nixos-rebuild switch --flake .#{{ host }}

# Apply NixOS configuration (verbose)
debug host:
    sudo nixos-rebuild switch --flake .#{{ host }} --show-trace --verbose

# Apply Home Manager configuration
home:
    home-manager switch --flake .#jy

# Update flake
update:
    nix flake update

# Update specific input. Usage: make upp i=home-manager
upp:
    nix flake update $(i)

history:
    nix profile history --profile /nix/var/nix/profiles/system

# Start a nix REPL
repl:
    nix repl -f flake:nixpkgs

# Remove all generations older than 7 days
clean:
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

# Garbage collect all unused nix store entries
gc:
    sudo nix-collect-garbage --delete-old
