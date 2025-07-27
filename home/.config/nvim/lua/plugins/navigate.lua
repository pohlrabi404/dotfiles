return {
	{
		"ibhagwan/fzf-lua",
		event = "VeryLazy",
		config = function()
			require("fzf-lua").setup({
				"telescope",
				files = {
					actions = {
						["ctrl-h"] = function(_, ctx)
							local new_cwd = vim.fn.fnamemodify(ctx.__call_opts.cwd or vim.loop.cwd(), ":h")
							if new_cwd == "/" then
								return
							end
							require("fzf-lua").files({ cwd = new_cwd })
						end,
					},
				},
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
		"mrjones2014/smart-splits.nvim",
	},
}
