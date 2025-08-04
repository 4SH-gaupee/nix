{ pkgs, ... }:

{
  programs.foot = {
    enable = true;
    enableZshIntegration = true;
    server.enable = false; # optional, if you want foot in client mode
    settings = {
      main = {
        font = "JetBrainsMono NerdFont:size=10";  # Font setting
        pad = "12x12";  # Padding around the terminal text
        dpi-aware = "yes";
        selection-target = "both";
      };
      colors = {
        alpha = 0.5;  # Transparency setting
      };
    };
  };
}

