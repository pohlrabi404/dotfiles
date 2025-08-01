return {
	{
		"stevearc/conform.nvim",
		ft = { "lua", "java", "arduino", "cpp" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				java = {},
				arduino = {},
				cpp = { "clang-format" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},
}
