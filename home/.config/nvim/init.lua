vim.pack.add({
    -- plugin manager
    "https://github.com/folke/lazy.nvim.git",
    -- colorscheme: gruber-darker
    "https://github.com/blazkowolf/gruber-darker.nvim",
})

vim.cmd.colorscheme("gruber-darker")
vim.g.mapleader = " "
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "gruber-darker" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
  performance = {
      rtp = {
	  disabled_plugins = {
	      "gzip",
	      "matchit",
	      "matchparen",
	      "tarPlugin",
	      "zipPlugin",
	      "tutor",
	      "netrwPlugin",
	  },
      },
  },
})

require("settings")
require("autocmds/auto-ssh")
