{ pkgs, ... }:
#with lib;
#let
#  cfg = config.modules.cli.direnv;
#in
{
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
        nix-direnv.enable = true;
    };
}

