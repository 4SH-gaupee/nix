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
    menu = {
      draw = {
        components = {
          label = {
            width = { fill = true, max = 60, },
          },
        },
        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
      },
    },
    documentation = { auto_show = true },
    list = {
      max_items = 30;
      selection = {
        preselect = false,
        auto_insert = true,
      },
      cycle = {
        from_bottom = true,
        from_top = true,
      },
    },
  },
  sources = {
    default = {
      "lsp",
      "path",
      "snippets",
      "buffer",
      "emoji",
      "dictionary",
    },
    providers = {
      path = {
        module = 'blink.cmp.sources.path',
        score_offset = 3,
        opts = {
          trailing_slash = false,
          label_trailing_slash = false,
          get_cwd = function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end,
          show_hidden_files_by_default = true,
        }
      },
      emoji = {
        module = "blink-emoji",
        name = "Emoji",
        score_offset = 15, -- Tune by preference
        opts = { insert = true }, -- Insert emoji (default) or complete its name
        should_show_items = function()
          return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
        end,
      },
      dictionary = {
        module = "blink-cmp-dictionary",
        name = "Dict",
        min_keyword_length = 3,
        max_items = 10,
        opts = {
          dictionary_files = function()
            if vim.bo.filetype == "markdown" or vim.bo.filetype == "gitcommit" then
              return {}
            end
            return {}
          end,
        },
      },
      buffer = {
        module = 'blink.cmp.sources.buffer',
        score_offset = -3,
        min_keyword_length = 4,
        opts = {
          -- default to all visible buffers
          get_bufnrs = function()
            return vim
              .iter(vim.api.nvim_list_wins())
              :map(function(win) return vim.api.nvim_win_get_buf(win) end)
              :filter(function(buf) return vim.bo[buf].buftype ~= 'nofile' end)
              :totable()
          end,
        }
      },
    },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning"
  },
  cmdline = {
    enabled = false,
  },
  appearance = {
    nerd_font_variant = "normal",
    kind_icons = {
      Text = "",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "󰇽",
      Variable = "󰂡",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "󰅲",
    }
  }
})
