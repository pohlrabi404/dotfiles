return {
	{
		"ibhagwan/fzf-lua",
		event = "VeryLazy",
		config = function()
			require("fzf-lua").setup({
				"telescope",
			})
			vim.cmd("FzfLua register_ui_select")
		end,
	},
	{
		"stevearc/oil.nvim",
		event = "VeryLazy",
		opts = {
			view_options = {
				show_hidden = true,
			},

			keymaps = {
				["<leader>c"] = function()
					local config_dir = vim.fn.expand("~/.dots/home/.config/")
					require("oil").open(config_dir)
				end,
				["<leader>d"] = function()
					local config_dir = vim.fn.expand("~/Downloads/")
					require("oil").open(config_dir)
				end,
				["<leader>m"] = function()
					local config_dir = vim.fn.expand("~/.config/mpv/playlists/")
					require("oil").open(config_dir)
				end,
				["<leader>p"] = function()
					local config_dir = vim.fn.expand("~/Projects/")
					require("oil").open(config_dir)
				end,
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		lazy = false,
	},
	{
		"ggandor/leap.nvim",
		lazy = false,
		config = function()
			require("leap").set_default_mappings()
		end,
	},
}
