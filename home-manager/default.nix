{ inputs, lib, config, pkgs, ... }:

{
  imports = [
    ../modules/home-manager/default.nix
  ]
  home.username = "gaupee";

  home.stateVersion = "24.11";
  # Let home Manager install and manage itself.
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;
}
