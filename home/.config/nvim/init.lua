local o = vim.o
local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.fillchars = { eob = ' ' }

require("autocmds/auto-ssh")
