return {
  cmd = { 'helm_ls', 'serve' },
  filetypes = { 'helm', 'yaml.helm-values' },
  single_file_support = true,
  root_markers = { 'values.yaml', 'Chart.yaml' },
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
  settings = {
    ['helm-ls'] = {
      yamlls = {
        enabled = true,
        enabledforfilesglob = "*.{yaml,yml}",
        diagnosticslimit = 50,
        showdiagnosticsdirectly = false,
        path = "yaml-language-server",
        config = {
          schemas = {},
          completion = true,
          hover = true,
        }
      }
    }
  }
}

