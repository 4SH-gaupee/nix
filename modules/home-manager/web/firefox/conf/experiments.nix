{

# Disable shield studies
# Mozilla shield studies (https://wiki.mozilla.org/Firefox/Shield) is a feature
# which allows mozilla to remotely install experimental addons.
  "app.normandy.enabled" = false;
  "app.normandy.api_url" = "";
  "app.shield.optoutstudies.enabled" = false;
  "extensions.shield-recipe-client.enabled" = false;
  "extensions.shield-recipe-client.api_url" = "";

# Disable experiments
# Telemetry Experiments (https://wiki.mozilla.org/Telemetry/Experiments) is a
# feature that allows Firefox to automatically download and run specially-designed
# restartless addons based on certain conditions.
  "experiments.enabled" = false;
  "experiments.manifest.uri" = "";
  "experiments.supported" = false;
  "experiments.activeExperiment" = false;
  "network.allow-experiments" = false;
}
