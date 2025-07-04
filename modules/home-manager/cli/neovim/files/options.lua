vim.opt_local.cursorcolumn = true -- Highlight the current column
vim.opt_local.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
vim.opt_local.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing operations
vim.opt_local.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
vim.opt_local.expandtab = true -- Expand tab to 2 spaces


-- disable lsplog
-- This is not usefull on a daily basis and should positively impact performance
vim.lsp.set_log_level("off")


vim.filetype.add({
	pattern = {
		-- ansible playbook
		[".*/.*playbook.*.ya?ml"] = "yaml.ansible",
		[".*/.*tasks.*/.*ya?ml"] = "yaml.ansible",
		[".*/.*roles.*/.*ya?ml"] = "yaml.ansible",
		[".*/.*ansible.*/.*ya?ml"] = "yaml.ansible",
		[".*/.*collections.*/.*ya?ml"] = "yaml.ansible",
		[".*/local.ya?ml"] = "yaml.ansible",
		[".*/.j2"] = "jinja",
	},
})
local lint_augroup = vim.api.nvim_create_augroup("setIndent", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
	group = "setIndent",
	pattern = {
		"css",
		"html",
		"javascript",
		"lua",
		"markdown",
		"md",
		"typescript",
		"scss",
		"xml",
		"xhtml",
		"yaml",
	},
	command = "setlocal shiftwidth=2 tabstop=2",
})

if vim.env.TMUX ~= nil then
	-- Define an autocommand for BufEnter and FocusGained events
	vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
		pattern = "*",
		callback = function()
			local current_file = vim.fn.expand("%:t")
			local tmux_command = string.format("tmux rename-window '📄 nvim - %s'", current_file)
			vim.fn.system(tmux_command)
		end,
	})

	-- Define an autocommand for the VimLeave event
	vim.api.nvim_create_autocmd("VimLeavePre", {
		pattern = "*",
		callback = function()
			local shell = vim.env.SHELL or "bash"
			vim.fn.system("tmux set-window-option automatic-rename on")
		end,
	})
end

