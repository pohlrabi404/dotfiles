return {
	{
		"stevearc/conform.nvim",
		ft = { "lua", "java", "arduino", "cpp", "javascript", "html", "css" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				java = {},
				arduino = { "clang-format" },
				cpp = { "clang-format" },
				html = { "prettierd" },
				javascript = { "prettierd" },
				css = { "prettierd" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},
}
