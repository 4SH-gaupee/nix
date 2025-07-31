{
# Firefox sends data about installed addons as metadata updates
# (https://blog.mozilla.org/addons/how-to-opt-out-of-add-on-metadata-updates/), so
# Mozilla is able to recommend you other addons.
  "extensions.getAddons.cache.enabled" = false;

# Disable about:addons' Get Add-ons panel
# The start page with recommended addons uses google analytics.
  "extensions.getAddons.showPane" = false;
  "extensions.webservice.discoverURL" = "";

# disable pocket extension
 "extensions.pocket.enabled" = false;

# disable extensions recommendations
  "extensions.htmlaboutaddons.recommendations.enabled" = false;

# Automatically activate extensions
  "extensions.autoDisableScopes" = 0;

# Deacticate extensions auto-update
  "extensions.update.enabled" = false;
  "extensions.update.autoUpdateDefault" = false;
}
