-- local o = vim.o
local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.fillchars = { eob = " " }

opt.expandtab = false
opt.tabstop = 8
opt.shiftwidth = 4
opt.softtabstop = 0

opt.termguicolors = true

opt.guicursor = {
	"n-v-c-sm:block", -- Normal, visual, command, showmatch: block cursor
	"i-ci-ve:block-blinkon500-blinkoff500", -- Insert modes: blinking block
	"r-cr-o:hor20", -- Replace and operator-pending: horizontal bar
}
