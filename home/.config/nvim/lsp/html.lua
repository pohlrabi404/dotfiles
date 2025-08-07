local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local mason = vim.fn.stdpath("data") .. "/mason"
local bin = mason .. "/bin"
return {
	cmd = { bin .. "/vscode-html-language-server", "--stdio" },
	capabilities = capabilities,
	filetypes = { "html", "templ" },
	root_markers = { "package.json", ".git" },
	settings = {},
	init_options = {
		provideFormatter = true,
		embeddedLanguages = { css = true, javascript = true },
		configurationSection = { "html", "css", "javascript" },
	},
}
