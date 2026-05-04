# nixos-config

NixOS is a pretty nice distro.

## Secrets

```bash
mkdir -p $HOME/.config/sops/age

read -s SSH_TO_AGE_PASSPHRASE; export SSH_TO_AGE_PASSPHRASE;

nix run nixpkgs#ssh-to-age -- \
          -private-key \
          -i $HOME/.ssh/id_ed25519 \
          -o $HOME/.config/sops/age/keys.txt
```
