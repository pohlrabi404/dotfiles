local options = {
	"number",
	"relativenumber",
	"wrap",
	"cursorline",
	"cursorcolumn",
	"colorcolumn",
	"signcolumn",
	"foldcolumn",
	"conceallevel",
	"winblend",
	"scrolloff",
	"sidescrolloff",
	-- more depends on which settings your plugin changes
}

local saved_opts = {}
for _, opt in ipairs(options) do
	saved_opts[opt] = vim.wo[opt]
end

vim.api.nvim_create_autocmd("WinNew", {
	callback = function()
		if saved_opts then
			for opt, value in pairs(saved_opts) do
				-- there shouldn't be that many options so an
				-- ugly loop like this doesn't matter too much
				vim.api.nvim_set_option_value(opt, value, { win = 0 })
			end
		end
	end,
})
