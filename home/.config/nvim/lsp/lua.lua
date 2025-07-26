return {
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
		},
	},
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".git" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
		},
	},
}
