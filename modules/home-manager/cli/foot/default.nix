{ pkgs, ... }:

{
  programs.foot = {
    enable = true;
    server.enable = false; # optional, if you want foot in client mode
    settings = {
      main = {
        font = "Hack:size=11";  # Font setting
        dpi-aware = "yes";
        selection-target = "both";
      };
      colors = {
        alpha = 0.8;  # Transparency setting
      };
      bell = {
      	system = false;
      };
    };
  };
}

