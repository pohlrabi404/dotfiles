return {
    lua_ls = {
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                },

                diagnostics = {
                    global = { "vim" },
                },

                workspace = {
                    library = {
                        vim.fn.expand("$VIMRUNTIME/lua"),
                        vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                        vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                        "${3rd}/luv/library",
                    },
                    maxPreload = 100000,
                    preloadFileSize = 10000,
                },

                runtime = {
                    version = "LuaJIT",
                },
            },
        },
    },
    pyright = {
        settings = {
            python = {
                analysis = {
                    diagnosticsSeverityOverrides = {
                        reportUnusedExpression = "none",
                    },
                },
            },
        },
    },
    hyprls = {
        settings = {
            hyprls = {
                diagnostics = {
                    enable = true,
                },
            },
        },
    },
    ts_ls = {},
    cssls = {
        settings = {
            css = {
                lint = {
                    unknownAtRules = "ignore",
                },
            },
        },
        capabilities = {
            textDocument = {
                completion = {
                    completionItem = {
                        snippetSupport = true,
                    },
                },
            },
        },
    },
    awk_ls = {},
}
