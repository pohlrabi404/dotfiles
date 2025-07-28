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
