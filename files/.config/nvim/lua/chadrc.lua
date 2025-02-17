local M

M = {
    base46 = {
        theme = "gruvbox_mod",
        transparency = false,
    },

    statusline = {
        theme = "minimal",
        separator_style = "round",
    },

    lsp = { signature = true },

    nvdash = {
        load_on_startup = true,
        header = {
            " ██▓███   ▒█████   ██░ ██ ",
            "▓██░  ██▒▒██▒  ██▒▓██░ ██▒",
            "▓██░ ██▓▒▒██░  ██▒▒██▀▀██░",
            "▒██▄█▓▒ ▒▒██   ██░░▓█ ░██ ",
            "▒██▒ ░  ░░ ████▓▒░░▓█▒░██▓",
            "▒▓▒░ ░  ░░ ▒░▒░▒░  ▒ ░░▒░▒",
            "░▒ ░       ░ ▒ ▒░  ▒ ░▒░ ░",
            "░░       ░ ░ ░ ▒   ░  ░░ ░",
            "             ░ ░   ░  ░  ░",
            "                          ",
            "                          ",
        },

        buttons = {
            { txt = "  Restore Session", keys = "sr", cmd = "SessionRestore" },
            { txt = "  Find File", keys = "ff", cmd = "Yazi" },
            { txt = "  Recent Files", keys = "fo", cmd = "FzfLua oldfiles" },
            { txt = "󰈭  Find Word", keys = "fg", cmd = "FzfLua live_grep_native" },
            { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },

            { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
            {
                txt = function()
                    local stats = require("lazy").stats()
                    local ms = math.floor(stats.startuptime) .. " ms"
                    return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
                end,
                hl = "NvDashFooter",
                no_gap = true,
            },
            { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
        },
    },

    ui = {
        tabufline = {
            enabled = false,
        },
        cmp = {
            enabled = false,
        },
    },
}

return M
