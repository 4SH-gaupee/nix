local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
local schemastore = require("schemastore")
return {
	capabilities = capabilities,
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
	root_markers = { ".git" },
	settings = {
		yaml = {
			format = {
				enable = false, -- use prettier instead
			},
			completion = true,
			hover = true,
			validate = true,
		},
		schemas = vim.tbl_extend("error", schemastore.yaml.schemas(), {
			-- Explicitly associate the Kubernetes schema URL with all YAML files (or specify patterns)
			["https://github.com/yannh/kubernetes-json-schema/blob/master/v1.34.1-standalone-strict/all.json"] = {
				"*.yaml",
				"*.yml",
			},
			-- Link other specific schemas similarly if needed
		}),
		schemaStore = {
			-- we use above
			enable = false,
			-- https://github.com/dmitmel/dotfiles/blob/master/nvim/dotfiles/lspconfigs/yaml.lua
			-- yamlls won't work if we disable schemaStore but don't specify url ¯\_(ツ)_/¯
			url = "",
		},
	},
}
