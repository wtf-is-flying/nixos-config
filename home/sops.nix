{
  config,
  sops-nix,
  ...
}:
{
  # Configuration via home.nix
  imports = [
    sops-nix.homeManagerModules.sops
  ];

  sops = {
    # sops-nix secret management
    # Decrypt secrets and expose as environment variables
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    secrets.anki_key = { };
  };
}
