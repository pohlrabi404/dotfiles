-- local o = vim.o
local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.fillchars = { eob = " " }
opt.winborder = "single"
opt.signcolumn = "yes"

opt.swapfile = false

opt.expandtab = false
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 0

opt.termguicolors = true

opt.ignorecase = true
opt.smartcase = true

opt.scrolloff = 10

opt.guicursor = {
	"n-v-c-sm:block",                    -- Normal, visual, command, showmatch: block cursor
	"i-ci-ve:block-blinkon500-blinkoff500", -- Insert modes: blinking block
	"r-cr-o:hor20",                      -- Replace and operator-pending: horizontal bar
}
