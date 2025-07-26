local bin = vim.fn.stdpath("data") .. "/mason/bin"
return {
	capabilities = {
		textDocument = {
			semanticTokens = vim.NIL,
		},
		workspace = {
			semanticTokens = vim.NIL,
		},
	},
	cmd = {
		bin .. "/arduino-language-server",

		"-cli",
		"arduino-cli",

		"-cli-config",
		vim.env.HOME .. "/.arduino15/arduino-cli.yaml",

		"-clangd",
		bin .. "/clangd",
	},
	filetypes = { "arduino" },
	root_markers = { "sketch.yaml" },
	settings = {},
}
