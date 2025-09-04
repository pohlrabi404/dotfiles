return {
	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
		lazy = false,
		dependencies = {
			-- include a picker of your choice, see picker section for more details
			"ibhagwan/fzf-lua",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			picker = {
				provider = "fzf-lua",
			},
		},
	},
}
