return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'} -- Add any globals you want to ignore as undefined
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true
        }
      },
      telemetry = {
        enable = false -- Disable telemetry
      }
    }
  },
  flags = {
    debounce_text_changes = 150,
  }
}

