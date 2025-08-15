return {
	{
		"aserowy/tmux.nvim",
		lazy = false,
		config = function()
			require("tmux").setup()
		end,
		opts = {
			copy_sync = {
				enable = true,
				redirect_to_clipboard = false,
			},
			navigation = {
				enable_default_keybindings = false,
			},
			resize = {
				enable_default_keybindings = false,
				resize_step_x = 5,
				resize_step_y = 5,
			},
			swap = {
				enable_default_keybindings = false,
			},
		},
	},
	{
		"rmagatti/auto-session",
		lazy = false,

		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/", "~/Downloads", "/" },
			-- log_level = 'debug',
		},
	},
}
