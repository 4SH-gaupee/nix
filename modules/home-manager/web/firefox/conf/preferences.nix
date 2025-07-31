{

  "browser.sessionstore.enabled" = true;
  "browser.sessionstore.restore_hidden_tabs" = true;
  "browser.sessionstore.restore_pinned_tabs_on_demand" = true;
  "browser.sessionstore.resume_after_os_start" = true;

# use blank page for new tabs
  "browser.newtabpage.enabled" = false;

# Disable preloading of the new tab page.
# By default Firefox preloads the new tab page (with website thumbnails) in the
# background before it is even opened.
  "browser.newtab.preload" = false;


# Disable check for captive portal.
# By default, Firefox checks for the presence of a captive portal on every
# startup.  This involves traffic to Akamai
# (https://support.mozilla.org/questions/1169302).
  "network.captive-portal-service.enabled" = false;


# Disable Javascript in PDF viewer
# Disables executing of JavaScript in the PDF form viewer. It is possible that
# some PDFs are not rendered correctly due to missing functions.
  "pdfjs.enableScripting" = true;

# Allow fullscreen in Firefox windows
  "full-screen-api.ignore-widgets" = true;

# About:config show warning
 "browser.aboutConfig.showWarning" = false;

# avoid some useless recommendations
 "extensions.htmlaboutaddons.recommendations.enabled" = false;
 "extensions.recommendations.themeRecommendationUrl" = "";

# Do not send FF build ID for site in startup page
 "browser.startup.homepage_override.mstone" = "ignore";

 "browser.aboutHomeSnippets.updateUrl" = "";

# Restore session when restart
 "browser.sessionstore.resume_session_once" = true;

# Disable translation
 "browser.translations.enabled" = false;

# disable AI shit
  "browser.ml.chat.enabled" = false;
  "browser.ml.chat.shortcuts" = false;
  "browser.ml.chat.sidebar" = false;
}
