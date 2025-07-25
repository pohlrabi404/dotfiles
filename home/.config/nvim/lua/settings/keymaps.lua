local key = vim.keymap.set
key("", "<ESC>", "<ESC>:noh<CR>:Fidget clear<CR>", { silent = true })
key("t", "<ESC>", "<C-\\><C-n>", {})
key("n", "<C-x><C-o>", ":Oil<CR>", {})
key("n", "<C-x><C-g>", ":Neogit<CR>", {})

local keymap_group = vim.api.nvim_create_augroup("KeymapEvent", { clear = true })
vim.api.nvim_create_autocmd("BufNew", {
	group = keymap_group,
	callback = function()
		local split = require("smart-splits")
		key("", "<A-h>", split.move_cursor_left)
		key("", "<A-l>", split.move_cursor_right)
		key("", "<A-j>", split.move_cursor_down)
		key("", "<A-k>", split.move_cursor_up)

		key("", "<C-S-k>", split.resize_up)
		key("", "<C-S-j>", split.resize_down)
		key("", "<C-S-h>", split.resize_left)
		key("", "<C-S-l>", split.resize_right)

		key("", "<A-S-k>", split.swap_buf_up)
		key("", "<A-S-j>", split.swap_buf_down)
		key("", "<A-S-h>", split.swap_buf_left)
		key("", "<A-S-l>", split.swap_buf_right)
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = keymap_group,
	callback = function()
		key("n", "<C-x><C-f>", ":FzfLua files<CR>", {})
		key("n", "<C-x><C-b>", ":FzfLua buffers<CR>", {})
		key("n", "<C-x><C-h>", ":FzfLua helptags<CR>", {})
	end,
})
