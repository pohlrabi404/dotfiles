local bin = vim.fn.stdpath("data") .. "/mason/bin"
local fqbn = "m5stack:esp32:m5stack_atom" -- fallback
local root = vim.uv.cwd() or vim.fn.getcwd()
local yaml = root .. "/sketch.yaml"
local f = io.open(yaml, "r")
if f then
	for line in f:lines() do
		local k, v = line:match("^%s*([%w_]+)%s*:%s*(.+)$")
		if k == "default_fqbn" then
			fqbn = v:match('^"?([^"]+)"?$') or v
			break
		end
	end
	f:close()
end
vim.lsp.config("arduino", {
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

		"-fqbn",
		fqbn,
	},
	filetypes = { "arduino" },
	root_markers = { "sketch.yaml" },
	settings = {},
})
vim.lsp.enable("arduino")
