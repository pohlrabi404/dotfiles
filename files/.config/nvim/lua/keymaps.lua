local map = vim.keymap.set

-- Moving around between windows
map("n", "<Esc>", "<Esc><cmd>nohlsearch<CR>")

-- Exit terminal mode
map("t", "<C-e>", "<C-\\><C-N>")

map("n", "j", "jzz")
map("n", "k", "kzz")
map("n", "<c-d>", "<c-d>zz")

map("i", "<c-;>", "<Esc>A;")
map("i", "<c-,>", "<Esc>A,")

map({ "n", "t" }, "<localleader>t", function()
    local term = require("nvchad.term")
	term.toggle({
		id = "term",
		pos = "float",
        float_opts = {
            width = 1,
            height = 0.3,
            row = 0.8,
            col = 0,
        },
	})
end, { desc = "Terminal" })

map({ "n", "t" }, "<localleader>g", function()
    local term = require("nvchad.term")
	term.toggle({
		id = "lazygit",
		pos = "float",
        float_opts = {
            width = 0.8,
            height = 0.8,
            row = 0.05,
            col = 0.1,
        },
        cmd = "lazygit",
	})
end, { desc = "Lazygit" })

map("n", "<leader>ss", "<cmd>SessionSave<CR>", { desc = "[S]ave [s]ession" })
map("n", "<leader>st", "<cmd>SessionToggleAutoSave<CR>", { desc = "[s]ession [t]oggle autosave" })

map({ "n", "x", "o" }, "gn", function()
	require("leap.treesitter").select()
end, { desc = "[g]rab [n]ode" })

-- yazi
map("n", "<leader>ff", "<cmd>Yazi<CR>", { desc = "[f]ind [f]ile" })
map("n", "<leader>fc", "<cmd>Yazi cwd<CR>", { desc = "[f]ind [c]urrent directory" })

map("n", "<leader>/", function()
	require("which-key").show({ global = true })
end, { desc = "show local mappings" })

map("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "show global mappings" })

-- fzflua
-- setup fzflua to be similar to telescope using profile
map("n", "<leader>fg", "<cmd>lua require('fzf-lua').files()<CR>", { desc = "[f]ind [f]ile" })
