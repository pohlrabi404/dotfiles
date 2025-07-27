return {
	{
		"stevearc/conform.nvim",
		ft = { "lua", "java", "arduino" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				java = { lsp_format = "prefer" },
				arduino = {},
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "prefer",
			},
		},
	},
}
