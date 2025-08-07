local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local mason = vim.fn.stdpath("data") .. "/mason"
local bin = mason .. "/bin"

return {
	cmd = { bin .. "vscode-css-language-server", "--stdio" },
	capabilities = capabilities,
	filetypes = { "css", "scss", "less" },
	init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
	root_markers = { "package.json", ".git" },
	settings = {
		css = { validate = true },
		scss = { validate = true },
		less = { validate = true },
	},
}
