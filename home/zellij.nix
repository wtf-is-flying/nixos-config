{ lib, pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    settings = {
      default_shell = lib.getExe pkgs.fish;
    };
  };
}
