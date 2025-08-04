{ pkgs, ... }:

{
  programs.foot = {
    enable = true;
    server.enable = false; # optional, if you want foot in client mode
    settings = {
      main = {
        font = "Hack:size=12";  # Font setting
        pad = "12x12";  # Padding around the terminal text
        dpi-aware = "yes";
        selection-target = "both";
      };
      colors = {
        alpha = 0.8;  # Transparency setting
      };
    };
  };
}

