vim.cmd.colorscheme("gruber-darker")
vim.cmd(":hi statusline guibg=NONE guifg=#ffdd33")

local o = vim.opt
o.guicursor = {
	"n-v-c-sm:block",                    -- Normal, visual, command, showmatch: block cursor
	"i-ci-ve:block-blinkon500-blinkoff500", -- Insert modes: blinking block
	"r-cr-o:hor20",                      -- Replace and operator-pending: horizontal bar
}
o.winborder = "single"

local keymap_group = vim.api.nvim_create_augroup("pohl.ui", { clear = true })
local vcmd = vim.api.nvim_create_autocmd

vcmd("VimEnter", {
	group = keymap_group,
	callback = function()
		local notify = require("fidget").notify
		vim.notify = notify
		print = function(...)
			local print_safe_args = {}
			local _ = { ... }
			for i = 1, #_ do
				table.insert(print_safe_args, tostring(_[i]))
			end
			notify(table.concat(print_safe_args, " "), vim.log.levels.INFO)
		end
		require("fidget").setup()
	end
})
