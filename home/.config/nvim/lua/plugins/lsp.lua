return {
	{
		"mason-org/mason.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		event = "VeryLazy",
		dependencies = { "rafamadriz/friendly-snippets" },
		build = "cargo build --release",

		opts = {
			keymap = { preset = "default" },
			appearance = {
				nerd_font_variant = "mono",
			},
			signature = { enabled = true, },
			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 500 },
				accept = {
					create_undo_point = true,
					resolve_timeout_ms = 100,
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
			term = {
				enabled = true,
			},
		},
		opts_extend = { "sources.default" },
	},
}
