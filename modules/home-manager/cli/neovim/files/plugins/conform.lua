require("conform").setup({
    format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "never",
  },

	formatters = {
    terraform = {
      inherit = false,
      command = "tofu",
      args = { "fmt", "-" },
      stdin = true,
    },
  },

  -- Formatter configuration by filetype
  formatters_by_ft = {
    ["_"] = { "trim_whitespace" },
		nix = { "alejandra"},
		terraform = { "terraform" },
    json = { "prettierd" },
    lua = { "stylua" },
    markdown = { "prettierd" },
    sh = { "shfmt" },
    xml = { "xmlformat" },
    yaml = { "prettierd" },
    -- python = { "isort", "black" },
    -- javascript = { { "prettierd", "prettier" } },
  },

  -- Optional: Disable notifications on error
  notify_on_error = false,
})

