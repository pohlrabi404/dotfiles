local opt = vim.opt
local o = vim.o
local g = vim.g

------------------------------------
o.relativenumber = true
o.laststatus = 3
o.showmode = false

o.clipboard = "unnamedplus"
opt.guicursor = [[i-ci:block-blinkwait100-blinkon3000-blinkoff100]]
o.cursorline = true
o.cursorlineopt = "number"

-- indentation
o.expandtab = true
o.shiftwidth = 4
o.smartindent = true
o.tabstop = 4
o.softtabstop = 4

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true

-- numbers
o.number = true
o.numberwidth = 2
o.ruler = false

-- disable intro
opt.shortmess:append("sI")

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true

g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_python3_provider = 0

-- color
opt.termguicolors = true

-- tabline
opt.showtabline = 0

-- search
o.hlsearch = true
o.incsearch = true
o.scrolloff = 10
