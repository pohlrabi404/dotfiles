-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = ";"

Autocmd = vim.api.nvim_create_autocmd
Autogroup = vim.api.nvim_create_augroup
Execmd = vim.api.nvim_exec_autocmds

vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"

require("lazy").setup({
    spec = {
        { import = "install" },
    },
    defaults = {
        lazy = true,
    },
    checker = {
        enabled = true,
    },
    change_detection = {
        notify = false,
    },
    ui = {
        size = {
            width = 0.7,
            height = 0.7,
        },
        border = "rounded",
    },
    profiling = {
        loader = true,
        require = true,
    },
    performance = {
        cache = {
            enabled = true,
        },
        reset_package = true,
        rtp = {
            reset = true,
            disabled_plugins = {
                "2html_plugin",
                "tohtml",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logipat",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "matchit",
                "tar",
                "tarPlugin",
                "rrhelper",
                "spellfile_plugin",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
                "tutor",
                "rplugin",
                "syntax",
                "synmenu",
                "optwin",
                "compiler",
                "bugreport",
                "ftplugin",
            },
        },
    },
})

dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require("options")
require("autocmds")

vim.schedule(function()
    require("keymaps")
end)

require("configs.ui")
require("filetypes")
