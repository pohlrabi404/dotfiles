vim.g.mapleader = " "
vim.g.maplocalleader = ";"

local keymap_group = vim.api.nvim_create_augroup("pohl.keymap", { clear = true })
local vcmd = vim.api.nvim_create_autocmd
local k = vim.keymap.set

k("", "<ESC>", "<ESC>:noh<CR>:Fidget clear<CR>", { silent = true })
k("t", "<ESC>", "<C-\\><C-n>", {})

k("n", "<localleader>w", ":w<CR>")
k("n", "<localleader>q", ":q<CR>")
k("n", "<localleader>r", ":restart<CR>")
k("n", "<localleader>s", ":update<CR>:source %<CR>")
k({ "n", "v" }, "<localleader>y", "\"+y")
k({ "n", "v" }, "<localleader>p", "\"+p")

vcmd("VimEnter", {
	group = keymap_group,
	callback = function()
		local split = require("tmux")
		split.setup({
			navigation = { enable_default_keybinds = false },
			resize = { enable_default_keybinds = false },
			swap = { 
				enable_default_keybinds = false,
				cycle_navigation = true,
			},
		})
		k("", "<A-h>", split.move_left)
		k("", "<A-l>", split.move_right)
		k("", "<A-j>", split.move_bottom)
		k("", "<A-k>", split.move_top)
		--
		k("", "<A-S-k>", split.resize_top)
		k("", "<A-S-j>", split.resize_bottom)
		k("", "<A-S-h>", split.resize_left)
		k("", "<A-S-l>", split.resize_right)
		--
		k("", "<C-S-k>", split.swap_top)
		k("", "<C-S-j>", split.swap_bottom)
		k("", "<C-S-h>", split.swap_left)
		k("", "<C-S-l>", split.swap_right)

		local neogit = require("neogit")
		k("n", "<localleader>g", neogit.open)
	end
})
