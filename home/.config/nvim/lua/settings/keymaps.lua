vim.g.mapleader = " "
vim.g.maplocalleader = ";"

local k = vim.keymap.set
local keymap_group = vim.api.nvim_create_augroup("pohl.keymap", { clear = true })
local vcmd = vim.api.nvim_create_autocmd

k("", "<ESC>", "<ESC>:noh<CR>:Fidget clear<CR>", { silent = true })
k("t", "<ESC>", "<C-\\><C-n>", {})

k("n", "<localleader>o", ":Oil<CR>", {})
k("n", "<localleader>g", ":Neogit<CR>", {})
k("n", "<localleader>w", ":w<CR>")
k("n", "<localleader>q", ":q<CR>")
k("n", "<localleader>r", ":restart<CR>")
k("n", "<localleader>s", ":update<CR>:source %<CR>")
k({ "n", "v" }, "<localleader>y", '"+y')
k({ "n", "v" }, "<localleader>p", '"+p')

vcmd("BufNew", {
	group = keymap_group,
	callback = function()
		local split = require("tmux")
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
	end,
})

vcmd("LspAttach", {
	group = keymap_group,
	callback = function()
		k("n", "gra", ":FzfLua lsp_code_actions<CR>")
		k("n", "grn", vim.lsp.buf.rename)
		k("n", "grt", ":FzfLua lsp_typedefs<CR>")
		k("n", "gri", ":FzfLua lsp_implementations<CR>")
		k("n", "grd", ":FzfLua lsp_document_diagnostics<CR>")
		k("n", "grw", ":FzfLua lsp_workspace_diagnostics<CR>")
		k("n", "grr", ":FzfLua lsp_references<CR>")
		k("n", "gO", ":FzfLua lsp_document_symbols<CR>")
		k("n", "grf", vim.diagnostic.open_float)
	end,
})

vcmd("VimEnter", {
	group = keymap_group,
	callback = function()
		k("n", "<leader>f", ":FzfLua files<CR>")
		k("n", "<leader>b", ":FzfLua buffers<CR>")
		k("n", "<leader>h", ":FzfLua helptags<CR>")
		k("n", "<leader>g", ":FzfLua live_grep_glob<CR>")
	end,
})
