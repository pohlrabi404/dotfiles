return {
	{
		"j-hui/fidget.nvim",
		event = "VeryLazy",
		config = function()
			local notify = require("fidget").notify
			vim.notify = notify
			print = function(...)
				local print_safe_args = {}
				local _ = { ... }
				for i = 1, #_ do
					table.insert(print_safe_args, tostring(_[i]))
				end
				notify(table.concat(print_safe_args, " "), vim.log.levels.INFO)
			end
			require("fidget").setup()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		opts = {},
	},
}
