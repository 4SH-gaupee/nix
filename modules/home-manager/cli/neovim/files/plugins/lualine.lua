require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'catppuccin',
        component_separators = { left = '|', right = '|'},
        section_separators = { left = "", right = ""},
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
        -- reduce performance impact reducing refresh pace
        refresh = {
          statusline = 1500,
          tabline = 1500,
          winbar = 1500,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}

