return {
    {
	"stevearc/conform.nvim",
	ft = { "lua" },
	opts = {
	    formatters_by_ft = {
		lua = { "stylua" },
	    },
	    format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	    }
	},
    },
}
