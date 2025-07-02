require("conform").setup({
  -- Format on save configuration
  format_on_save = function(bufnr)
    -- Disable format on save for specific filetypes
    local disable_filetypes = { c = true, cpp = true }
    local lsp_format
    if disable_filetypes[vim.bo[bufnr].filetype] then
      lsp_format = "never"
    else
      lsp_format = "fallback"
    end
    return {
      timeout_ms = 500,
      lsp_format = lsp_format,
    }
  end,

  -- Formatter configuration by filetype
  formatters_by_ft = {
    lua = { "stylua" },
    xml = { "xmlformat" },
    json = { "prettierd" },
    hcl = { "hclfmt" },
    yaml = { "prettierd" },
    markdown = { "prettierd" },
    -- python = { "isort", "black" },
    -- javascript = { { "prettierd", "prettier" } },
  },

  -- Optional: Disable notifications on error
  notify_on_error = false,
})

