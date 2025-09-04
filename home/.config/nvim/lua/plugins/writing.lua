return {
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		version = "1.*",
		opts = {
			dependencies_bin = {
				["tinymist"] = "tinymist",
			},
		},
	},
	-- {
	-- 	dir = "/home/pohl/Projects/Lua/typst-preview.nvim",
	-- 	lazy = false,
	-- },

	{ "echasnovski/mini.doc", version = false, opts = {}, lazy = false },
}
