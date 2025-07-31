{ lib, config, pkgs, ... }:
with lib;
let
  merge = foldr (a: b: a // b) { };
  cfg = config.modules.web.firefox;
in
{
  options.modules.web.firefox = {
    enable = mkEnableOption "enable Firefox web browser";

    baseExtensions = mkOption {
      type = types.listOf types.package;
      default = with pkgs.nur.repos.rycee.firefox-addons; [
          browserpass
          consent-o-matic
	  bitwarden
          cookie-autodelete
          darkreader
	  multi-account-containers
	  facebook-container
	  old-reddit-redirect
          tridactyl
          ublock-origin
        ];
      description = "Base Firefox Plugins to install";
    };

    optionalExtensions = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "Optional Firefox Plugins to install";
    };

    enableNixGL = mkOption {
      type = types.bool;
      default = false;
      description = "Use NixGL to start Firefox";
    };
  };
  config = mkIf cfg.enable {
    programs.browserpass = {
      enable = true;
      browsers = ["firefox"];
    };
    xdg.mimeApps.defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };

    xdg.configFile."tridactyl/tridactylrc".text = ''
      sanitize tridactyllocal tridactylsync
      " Define custom theme
      set customthemes.custom #completions table, #tridactyl-input {font-size: .9rem!important;} #tridactyl-reader main { width: min(65rem, 90%)!important;}
      set theme custom
      " Smooth scrolling
      set smoothscroll true
      " Ctrl-F should use the browser's native 'find' functionality.
      unbind <C-f>
      " But also support Tridactyl search too.
      bind / fillcmdline find
      bind ? fillcmdline find -?
      bind n findnext 1
      bind N findnext -1
      " K and J should move between tabs.
      bind J tabprev
      bind K tabnext
      " Binds for force reader mode
      bind gr reader
      bind gR reader --tab
      set editorcmd foot -T "Edit text from Firefox" nvim %f
    '';

    programs.firefox = let
        allExtensions = cfg.baseExtensions ++ cfg.optionalExtensions;
    in {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        nativeMessagingHosts = [
          # Tridactyl native connector
          pkgs.tridactyl-native
          pkgs.browserpass
        ];
      };
      profiles.gaupee = {
        id = 0;
        name = "gaupee";
        isDefault = true;
        extensions.packages = allExtensions;
        search = {
          force = true;
          default = "ddg";
          engines =  {
            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
                ];
              }];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "NixOS Wiki" = {
              urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
              icon = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
                definedAliases = [ "@nw" ];
            };

            "bing".metaData.hidden = true;
            "google".metaData.hidden = true;
            "Amazon.fr".metaData.hidden = true;
            "Facebook".metaData.hidden = true;
            "youtube".metaData.hidden = true;
          };
        };
        settings = merge [
          (import ./conf/doh.nix)
          (import ./conf/drm.nix)
          (import ./conf/experiments.nix)
          (import ./conf/extensions.nix)
          (import ./conf/preferences.nix)
          (import ./conf/privacy.nix)
          (import ./conf/safebrowsing.nix)
          (import ./conf/suggest.nix)
          (import ./conf/telemetry.nix)
          (import ./conf/theme.nix)
          (import ./conf/tracking.nix)
        ];
      };
    };
  };
}

