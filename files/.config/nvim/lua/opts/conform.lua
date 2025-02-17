return function(_, opts)
    opts = opts or {}
    local custom_opts = {
        formatter_by_ft = {
            lua = { "stylua" },
            python = { "black" },
            nix = { "nixfmt" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
}
    return vim.tbl_deep_extend("force", custom_opts, opts)
end
