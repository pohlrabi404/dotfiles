require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	defaults = {
		lazy = true,
	},
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "gruber-darker" } },
	checker = {
		enabled = true,
		notify = true,
	},
	change_detection = {
		enabled = true,
		notify = true,
	},
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
