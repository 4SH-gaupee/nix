return {
  cmd = { "ansible-language-server", "--stdio" },
  filetypes = { "yaml.ansible" },
	root_markers = { '.git' },
  settings = {
    ansible = {
      python = {
        interpreterPath = vim.fn.exepath("python3"), -- safer than "python"
      },
      ansible = {
        useFullyQualifiedCollectionNames = true,
      },
      validation = {
        lint = {
          enabled = true,
          arguments = "-x role-name,package-latest,fqcn-builtins",
        },
      },
			completion = {
        provideRedirectModules = true,
        provideModuleOptionAliases = true,
      },
    },
  },
}

