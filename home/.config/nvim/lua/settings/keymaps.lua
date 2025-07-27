local key = vim.keymap.set
key("", "<ESC>", "<ESC>:noh<CR>:Fidget clear<CR>", { silent = true })
key("t", "<ESC>", "<C-\\><C-n>", {})
key("n", "<C-x><C-o>", ":Oil<CR>", {})
key("n", "<C-x><C-g>", ":Neogit<CR>", {})

local keymap_group = vim.api.nvim_create_augroup("KeymapEvent", { clear = true })
vim.api.nvim_create_autocmd("BufNew", {
	group = keymap_group,
	callback = function()
		local split = require("tmux")
		key("", "<A-h>", split.move_left)
		key("", "<A-l>", split.move_right)
		key("", "<A-j>", split.move_bottom)
		key("", "<A-k>", split.move_top)
		--
		key("", "<A-S-k>", split.resize_top)
		key("", "<A-S-j>", split.resize_bottom)
		key("", "<A-S-h>", split.resize_left)
		key("", "<A-S-l>", split.resize_right)
		--
		key("", "<C-S-k>", split.swap_top)
		key("", "<C-S-j>", split.swap_bottom)
		key("", "<C-S-h>", split.swap_left)
		key("", "<C-S-l>", split.swap_right)
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = keymap_group,
	callback = function()
		key("", "<C-x><C-f>", ":FzfLua files<CR>", {})
		key("", "<C-x><C-b>", ":FzfLua buffers<CR>", {})
		key("", "<C-x><C-h>", ":FzfLua helptags<CR>", {})
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = keymap_group,
	callback = function()
		key("", "<C-l><C-a>", ":FzfLua lsp_code_actions<CR>")
		key("", "<C-l><C-r>", vim.lsp.buf.rename)
	end,
})
