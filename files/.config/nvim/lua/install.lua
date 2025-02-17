return {
    -- UI
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvchad/ui",
    "nvchad/volt",
    { "nvchad/base46", build = function() require("base46").load_all_highlights() end },
    {
        "stevearc/dressing.nvim",
        event = { "User FilePost" },
        opts = {},
    },

    -- indent
    "lukas-reineke/indent-blankline.nvim",

    -- yazi
    {
        "mikavilpas/yazi.nvim",
        cmd = "Yazi",
        opts = {
            floating_window_scaling_factor = 0.8,
        },
    },

    -- session
    {
        "rmagatti/auto-session",
        cmd = { "SessionRestore" },
        opts = {
            suppress_dirs = { "~/", "~/Downloads/", "/" },
        },
    },

    -- treesitter
    "nvim-treesitter/nvim-treesitter",

    -- motion
    "ggandor/leap.nvim",
    "tpope/vim-repeat",
    "windwp/nvim-autopairs",

    -- fzf-lua
    {
        "ibhagwan/fzf-lua",
        cmd = "FzfLua",
        config = function(_, opts)
            require("fzf-lua").setup(opts)
            Execmd("User", {
                pattern = "Fzf",
            })
        end,
        opts = {
            winopts = {
                height = 0.80,
                width = 0.80,
                row = 0.50,
                col = 0.50,
            },
            preview = {},
        },
    },

    -- git
    {
        "lewis6991/gitsigns.nvim",
        event = "User FilePost",
        opts = require("opts.gitsigns")
    },

    -- formatter
    {
        "stevearc/conform.nvim",
        event = { "User FilePost" },
        ---@diagnostic disable-next-line: different-requires
        opts = require("opts.conform"),
        config = require("configs.conform"),
    },

    -- lsp
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall" },
        config = function()
            dofile(vim.g.base46_cache .. "mason")
            require("mason").setup()
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = "User FilePost",
        config = require("configs.lspconfig"),
    },

    {
        "saghen/blink.cmp",
        version = "*",
        config = function(_, opts)
            opts = opts or {}
            dofile(vim.g.base46_cache .. "cmp")
            require("blink.cmp").setup(opts)
        end,
        opts = require("opts.blink"),
    },
    "L3MON4D3/LuaSnip",
    "fang2hou/blink-copilot",
    {
        "github/copilot.vim",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "User FilePost",
        init = function()
            vim.g.copilot_no_maps = true
        end,
        config = function()
            -- Block the normal Copilot suggestions
            vim.api.nvim_create_augroup("github_copilot", { clear = true })
            for _, event in pairs({ "FileType", "BufUnload", "BufEnter" }) do
                vim.api.nvim_create_autocmd({ event }, {
                    group = "github_copilot",
                    callback = function()
                        vim.fn["copilot#On" .. event]()
                    end,
                })
            end
        end,
    },
    {
        'milanglacier/minuet-ai.nvim',
        -- lazy = false,
        config = function()
            require('minuet').setup {
                provider = 'codestral',
                n_completions = 1,
                context_window = 512,
                provider_options = {
                    codestral = {
                        model = 'codestral-latest',
                        api_key = function() return "t9ALGFmWUj4x2JjUYBNsoYAJmg2FapX5" end,
                        end_point = 'https://codestral.mistral.ai/v1/fim/completions',
                        stream = true,
                        optional = {
                            max_tokens = 256,
                            stop = { "\n\n" },
                        },
                    },
                },
            }
        end,
    },
}
