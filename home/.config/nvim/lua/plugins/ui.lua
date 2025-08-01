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
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = { -- set to setup table
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		config = function()
			vim.api.nvim_set_hl(0, "IndentBlanklineInactive", { fg = "#444444" })
			vim.api.nvim_set_hl(0, "IndentBlanklineActive", { fg = "#888888" })

			require("ibl").setup({
				indent = {
					char = "▏", -- NOTE: this is very left-aligned on meslo nerd font. different fonts may mess this up
					highlight = {
						"IndentBlanklineInactive",
					},
				},
				scope = {
					enabled = true,
					show_start = false,
					show_end = false,
					highlight = {
						"IndentBlanklineActive",
					},
				},
			})
		end,
	},
}
