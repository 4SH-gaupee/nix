local map = vim.api.nvim_set_keymap
map("n", "<Space>", "", {})
vim.g.mapleader = " "
vim.keymap.set("n", "<Leader>pv", ":Vex<CR>")
vim.keymap.set("n", "<Leader>ex", ":Ex<CR>")
vim.keymap.set("n", "<Leader><CR>", ":so ~/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<Leader>j", ":cnext<CR>")
vim.keymap.set("n", "<Leader>bj", ":bnext<CR>")
vim.keymap.set("n", "<Leader>k", ":cprev<CR>")
vim.keymap.set("n", "<Leader>bk", ":bprev<CR>")
vim.keymap.set("v", "<Leader>p", '"_dP')
vim.keymap.set("v", "<Leader>y", '"+y')
vim.keymap.set("n", "<Leader>Y", 'gg"+yG')
vim.keymap.set("n", "<leader>g", vim.cmd.Git)
vim.keymap.set("n", "<Leader>cc", ":Telescope conventional_commits<CR>")
vim.keymap.set("n", "<Leader>gr", ":Git pull --rebase<CR>")

-- ./files/keymaps/telescope.lua
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer" })
vim.keymap.set("n", "<leader>s/", function()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end, { desc = "[S]earch [/] in Open Files" })
vim.keymap.set("n", "<leader>sn", function()
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

