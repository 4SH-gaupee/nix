require("conform").setup({
    format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "never",
  },

  -- Formatter configuration by filetype
  formatters_by_ft = {
    lua = { "stylua" },
    xml = { "xmlformat" },
    json = { "prettierd" },
    hcl = { "hclfmt" },
    yaml = { "prettierd" },
    markdown = { "prettierd" },
    sh = { "shfmt" },
    ["_"] = { "trim_whitespace" },
    -- python = { "isort", "black" },
    -- javascript = { { "prettierd", "prettier" } },
  },

  -- Optional: Disable notifications on error
  notify_on_error = false,
})

