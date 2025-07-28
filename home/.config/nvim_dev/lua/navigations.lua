local keymap_group = vim.api.nvim_create_augroup("pohl.navigation", { clear = true })
local vcmd = vim.api.nvim_create_autocmd

vcmd("VimEnter", {
	group = keymap_group,
	callback = function()
		require("leap").set_default_mappings()
	end
})
