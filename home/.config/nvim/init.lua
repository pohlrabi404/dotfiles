vim.pack.add({
	-- plugin manager
	"https://github.com/folke/lazy.nvim.git",
	-- gruber-darker
	"https://github.com/blazkowolf/gruber-darker.nvim",
})

vim.diagnostic.config({ virtual_lines = { current_line = true } })
vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
		},
	},
})

vim.cmd.colorscheme("gruber-darker")
vim.g.mapleader = " "
require("settings/lazy")
require("settings/general")
require("settings/keymaps")
require("autocmds/auto-ssh")
