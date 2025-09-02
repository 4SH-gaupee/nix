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
          auto_show_delay_ms = 0,
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
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
            name = "Buffer",
            module = "blink.cmp.sources.buffer",
            opts = {
              get_bufnrs = function()
                return vim.tbl_filter(function(bufnr)
                  return vim.bo[bufnr].buftype == ""
                end, vim.api.nvim_list_bufs())
              end,
            },
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                item.labelDetails = {
                  description = "(buf)",
                }
              end
              return items
            end,
          },
      orgmode = {
        name = 'Orgmode',
        module = 'orgmode.org.autocompletion.blink',
        fallbacks = { 'buffer' },
      },
      ripgrep = {
        enabled = function()
          -- disable for the sm repo. Its just too big for ripgrep
          local git_cmd = vim.fn.system("git rev-parse --show-toplevel | tr -d '\n'")
          return not string.find(git_cmd, "dev/sm")
        end,
        module = "blink-ripgrep",
        name = "Ripgrep",
        opts = {
          project_root_marker = { "Dockerfile", "Jenkinsfile", ".git" },
          project_root_fallback = false,
          future_features = {
            -- Kill previous searches when a new search is started. This is
            -- useful to save resources and might become the default in the
            -- future.
            kill_previous_searches = true,
          },
        },
        transform_items = function(_, items)
          for _, item in ipairs(items) do
            item.labelDetails = {
              description = "(rg)",
            }
          end
          return items
        end,
        score_offset = 5,
      },
      snippets = {
        name = "Snippets",
        module = "blink.cmp.sources.snippets",
        score_offset = 10,
      },
      lsp = {
        name = "LSP",
        module = "blink.cmp.sources.lsp",
        score_offset = 50,
      },

      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
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
