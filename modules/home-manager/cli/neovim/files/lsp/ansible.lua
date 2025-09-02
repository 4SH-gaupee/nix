return {
	cmd = { 'ansible-language-server' },
	filetypes = { 'yaml.ansible' },
  root_markers = { '.git' },
  settings = {
    ansible = {
      ansible = {
        useFullyQualifiedCollectionNames = true,
      },
      validation = {
        lint = {
          enabled = true,
          arguments = "-x role-name,package-latest,fqcn-builtins",
        },
      },
    },
  },
}

