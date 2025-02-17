return function()
    local servers = require("opts.servers")
    local ensure_installed = vim.tbl_keys(servers or {})

    require("mason").setup()
    require("mason-tool-installer").setup({
        ensure_installed = ensure_installed,
    })

    require("mason-lspconfig").setup({
        handlers = {
            function(server_name)
                local server = servers[server_name] or {}
                server.capabilities = require("blink.cmp").get_lsp_capabilities(server.capabilities)
                require("lspconfig")[server_name].setup(server)
            end,
        },
    })

    --- Diagnostic
    if vim.g.have_nerd_font then
        local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
        local diagnostic_signs = {}
        for type, icon in pairs(signs) do
            diagnostic_signs[vim.diagnostic.severity[type]] = icon
        end
        vim.diagnostic.config({ signs = { text = diagnostic_signs } })
    end
end
