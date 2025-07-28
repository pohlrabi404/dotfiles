-- plugins
vim.o.loadplugins = false
vim.cmd("runtime plugin/osc52.lua")
vim.cmd("runtime plugin/shada.lua")

vim.pack.add({
	-- theme: gruber-darker
	"https://github.com/blazkowolf/gruber-darker.nvim",
	-- tmux: navigation
	"https://github.com/aserowy/tmux.nvim",
	-- jumping around
	"https://github.com/ggandor/leap.nvim",
	-- funny fidget
	"https://github.com/j-hui/fidget.nvim"
})

require("ui")
require("general")
require("keybinds")
require("navigations")
require("lsp")
require("ssh")
