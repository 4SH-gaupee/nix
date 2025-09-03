require("blink.cmp").setup({
  keymap = {
    preset = "none",
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    ['<Tab>'] = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
    ['<C-space>'] = { 'show', 'fallback' },
    ['<C-y>'] = { 'select_and_accept' },
    ['<C-e>'] = { 'cancel' },

  },
  completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
    },
  sources = {
    default = { "lazydev", "lsp", "buffer", "snippets", "path", "omni" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },

  cmdline = {
    enabled = false,
  }
})

