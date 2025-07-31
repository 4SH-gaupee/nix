{
  "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
  "browser.uidensity" = 1;

# New tab behaviour
  "browser.newtabpage.activity-stream.showSearch" = false;
  "browser.newtabpage.activity-stream.feeds.topsites" = false;
  "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
  "browser.newtabpage.activity-stream.feeds.topstories" = false;
  "browser.newtabpage.activity-stream.snippets" = false;
  "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
  "browser.newtabpage.activity-stream.showSponsored" = false;

# Mozilla messages and recommendations
  "browser.messaging-system.whatsNewPanel.enabled" = false;
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
  "browser.aboutwelcome.enabled" = false;
  "browser.preferences.moreFromMozilla" = false;

# Do not save my logins
  "signon.rememberSignons" = false;

# do not override status page
  "startup.homepage_override_url" = "";
  "startup.homepage_welcome_url" = "";

# do not show bookmark page
  "browser.toolbars.bookmarks.visibility" = "never";

# disable fucking included malwares
  "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "";
  "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = "";
  "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
  "browser.newtabpage.pinned" = "";

# Theme customization
  "browser.uiCustomization.state" = builtins.toJSON {
    currentVersion = 20;
    newElementCount = 4;
    dirtyAreaCache = ["nav-bar" "PersonalToolbar" "toolbar-menubar" "TabsToolbar" "widget-overflow-fixed-list"];
    placements = {
      PersonalToolbar = [];
      TabsToolbar = [
        "tabbrowser-tabs"
        "ublock0_raymondhill_net-browser-action"
        "addon_darkreader_org-browser-action"
        "cookieautodelete_kennydo_com-browser-action"
        "jid1-mnnxcxisbpnsxq_jetpack-browser-action"
        "downloads-button"
      ];
      nav-bar = [
        "back-button"
        "forward-button"
        "stop-reload-button"
        "urlbar-container"
        "unified-extensions-button"
      ];
      toolbar-menubar = ["menubar-items"];
      unified-extensions-area = [
        "browserpass_maximbaz_com-browser-action"
        "gdpr_cavi_au_dk-browser-action"
        "cookieautodelete_kennydo_com-browser-action"
        "addon_darkreader_org-browser-action"
        "jid1-bofifl9vbdl2zq_jetpack-browser-action"
      ];
      widget-overflow-fixed-list = [];
    };
    seen = ["save-to-pocket-button" "developer-button" "ublock0_raymondhill_net-browser-action" "_testpilot-containers-browser-action"];
  };
}
