{

# Disable Telemetry
# The telemetry feature
# (https://support.mozilla.org/kb/share-telemetry-data-mozilla-help-improve-firefox)
# sends data about the performance and responsiveness of Firefox to Mozilla.
  "toolkit.telemetry.enabled" = false;
  "toolkit.telemetry.archive.enabled" = false;
  "toolkit.telemetry.rejected" = true;
  "toolkit.telemetry.unified" = false;
  "toolkit.telemetry.unifiedIsOptIn" = false;
  "toolkit.telemetry.prompted" = 2;
  "toolkit.telemetry.server" = "";
  "toolkit.telemetry.cachedClientID" = "";
  "toolkit.telemetry.newProfilePing.enabled" = false;
  "toolkit.telemetry.shutdownPingSender.enabled" = false;
  "toolkit.telemetry.updatePing.enabled" = false;
  "toolkit.telemetry.bhrPing.enabled" = false;
  "toolkit.telemetry.firstShutdownPing.enabled" = false;
  "toolkit.telemetry.hybridContent.enabled" = false;
  "toolkit.telemetry.reportingpolicy.firstRun" = false;

# Disable health report
# Disable sending Firefox health reports
# (https://www.mozilla.org/privacy/firefox/#health-report) to Mozilla
  "datareporting.healthreport.uploadEnabled" = false;
  "datareporting.policy.dataSubmissionEnabled" = false;
  "datareporting.healthreport.service.enabled" = false;

# Disable Crash Reports
# The crash report (https://www.mozilla.org/privacy/firefox/#crash-reporter) may
# contain data that identifies you or is otherwise sensitive to you.
  "breakpad.reportURL" = "";
  "browser.tabs.crashReporting.sendReport" = false;
  "browser.crashReports.unsubmittedCheck.enabled" = false;
  "browser.crashReports.unsubmittedCheck.autoSubmit" = false;
  "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;

}
