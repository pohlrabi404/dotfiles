vim.pack.add({
	-- plugin manager
	"https://github.com/folke/lazy.nvim.git",
	-- gruber-darker
	"https://github.com/blazkowolf/gruber-darker.nvim",
})
vim.diagnostic.config({
	virtual_lines = { current_line = true },
	virtual_text = false,
})
vim.cmd.colorscheme("gruber-darker")
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

vim.api.nvim_set_hl(0, "Pmenu", { bg = "#181818" })

-- lsp
local servers = {
	"lua",
	"arduino",
	"java",
	"cpp",
}
vim.lsp.enable(servers)

require("settings/lazy")
require("settings/general")
require("settings/keymaps")
