-- user event that loads after UIEnter + only if file buf is there
Autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
    group = Autogroup("NvFilePost", { clear = true }),
    callback = function(args)
        local file = vim.api.nvim_buf_get_name(args.buf)
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

        if not vim.g.ui_entered and args.event == "UIEnter" then
            vim.g.ui_entered = true
        end

        if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
            Execmd("User", { pattern = "FilePost", modeline = false })
            vim.api.nvim_del_augroup_by_name("NvFilePost")

            vim.schedule(function()
                Execmd("FileType", {})

                if vim.g.editorconfig then
                    require("editorconfig").config(args.buf)
                end
            end)
        end
    end,
})

Autocmd("User", {
    pattern = "FilePost",
    group = Autogroup("OneTime", { clear = true, }),
    callback = function()
        -- leap
        require("leap").create_default_mappings()

        -- indent
        dofile(vim.g.base46_cache .. "blankline")

        local hooks = require("ibl.hooks")
        hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
        require("ibl").setup({
            indent = { char = "|", highlight = "IblChar" },
            scope = { char = "|", highlight = "IblScopeChar" },
        })

        -- session
        require("auto-session").setup({})

        -- treesitter
        dofile(vim.g.base46_cache .. "treesitter")
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "lua", "python", "hyprlang" },
            auto_installed = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = true,
            },
        })

        dofile(vim.g.base46_cache .. "blankline")
        return true
    end,
})

Autocmd("InsertEnter", {
    callback = function()
        require("nvim-autopairs").setup({})
    end,
})

local map = vim.keymap.set
Autocmd("User", {
    pattern = "Fzf",
    callback = function()
        local fzf = require("fzf-lua")
        map("n", "<leader>fg", function()
            fzf.live_grep()
        end, { desc = "[f]iles [g]rep" })
        map("n", "<leader>fb", function()
            fzf.buffers()
        end, { desc = "[f]iles [b]uffers" })
    end,
})

Autocmd("LspAttach", {
    group = Autogroup("lsp-attach-mapping", { clear = true }),
    callback = function()
        local builtin = require("fzf-lua")
        map("n", "gd", builtin.lsp_definitions, { desc = "[g]oto [d]efinitions" })
        map("n", "gr", builtin.lsp_references, { desc = "[g]oto [r]eferences" })
        map("n", "gi", builtin.lsp_implementations, { desc = "[g]oto [i]mplementations" })
        map("n", "gtd", builtin.lsp_typedefs, { desc = "[t]ype [d]definitions" })
        map("n", "gds", builtin.lsp_document_symbols, { desc = "[d]oc [s]ymbols" })
        map("n", "gws", builtin.lsp_live_workspace_symbols, { desc = "[w]ork [s]ymbols" })
        map("n", "gD", builtin.lsp_declarations, { desc = "[g]oto [D]eclaration" })
        map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[r]e[n]ame" })
        map("n", "<leader>ca", builtin.lsp_code_actions, { desc = "[c]ode [a]ction" })
    end,
})
