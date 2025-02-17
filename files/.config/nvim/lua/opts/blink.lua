return {
    snippets = {
        expand = function(snippet)
            require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
            if filter and filter.direction then
                return require("luasnip").jumpable(filter.direction)
            end
            return require("luasnip").in_snippet()
        end,
        jump = function(direction)
            require("luasnip").jump(direction)
        end,
        preset = "luasnip",
    },
    keymap = {
        preset = "none",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-n>"] = { "cancel", "fallback" },
    },
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
    },
    completion = {
        ghost_text = {
            enabled = true,
        },
        accept = {
            create_undo_point = true,
        },
        list = {
            max_items = 10,
            cycle = {
                from_top = true,
                from_bottom = true,
            },
            selection = {
                auto_insert = function(ctx)
                    if ctx.mode == "cmdline" then
                        return false
                    end
                    return true
                end,
                preselect = function(ctx)
                    if ctx.mode == "cmdline" then
                        return false
                    end
                    return true
                end,
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 100,
            window = {
                border = "rounded",
            },
        },
        menu = {
            border = "rounded",
        },
        trigger = { prefetch_on_insert = false }
    },

    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
            -- lazydev = {
            -- 	name = "LazyDev",
            -- 	module = "lazydev.integrations.blink",
            -- 	score_offset = 100,
            lsp = {
                name = "LSP",
                module = "blink.cmp.sources.lsp",
                enabled = true,
                async = false,
                timeout_ms = 2000,
            },
            -- copilot = {
            --     name = "copilot",
            --     module = "blink-copilot",
            --     score_offset = 100,
            --     async = true,
            --     opts = {
            --         max_completions = 3,
            --         max_attemps = 4,
            --     },
            -- },
            -- minuet = {
            --     name = "minuet",
            --     module = "minuet.blink",
            --     score_offset = 150,
            --     async = true,
            --     opts = {
            --         max_attemps = 4,
            --         max_completions = 3,
            --     },
            -- },
        },
    },

    -- fuzzy = {
    --     prebuilt_binaries = {
    --         download = false,
    --         force_version = "v0.11.0",
    --         -- force_system_triple = "*",
    --     },
    --     max_typos = function(keyword) return math.floor(#keyword / 4) end,
    --     use_frecency = true,
    --     use_proximity = true,
    -- },
}
