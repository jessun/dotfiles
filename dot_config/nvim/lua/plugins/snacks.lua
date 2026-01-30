local sk = require('snacks')

local input_cfg = {
    enabled = true,
    icon = "",
}

local dim_cfg = {
    enabled = true,
    ---@type snacks.scope.Config
    scope = {
        min_size = 5,
        max_size = 20,
        siblings = true,
    },
    -- animate scopes. Enabled by default for Neovim >= 0.10
    -- Works on older versions but has to trigger redraws during animation.
    ---@type snacks.animate.Config|{enabled?: boolean}
    animate = {
        enabled = vim.fn.has("nvim-0.10") == 1,
        easing = "outQuad",
        duration = {
            step = 20,   -- ms per step
            total = 300, -- maximum duration
        },
    },
    -- what buffers to dim
    filter = function(buf)
        return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ""
    end,

}

local zen_cfg = {
    -- You can add any `Snacks.toggle` id here.
    -- Toggle state is restored when the window is closed.
    -- Toggle config options are NOT merged.
    ---@type table<string, boolean>
    toggles = {
        dim = true,
        git_signs = false,
        mini_diff_signs = false,
        -- diagnostics = false,
        -- inlay_hints = false,
    },
    center = true,          -- center the window
    show = {
        statusline = false, -- can only be shown when using the global statusline
        tabline = false,
    },
    ---@type snacks.win.Config
    win = { style = "zen" },
    --- Callback when the window is opened.
    ---@param win snacks.win
    on_open = function(win) end,
    --- Callback when the window is closed.
    ---@param win snacks.win
    on_close = function(win) end,
    --- Options for the `Snacks.zen.zoom()`
    ---@type snacks.zen.Config
    zoom = {
        toggles = {},
        center = false,
        show = { statusline = true, tabline = true },
        win = {
            backdrop = false,
            width = 0, -- full width
        },
    },
}



sk.setup {
    animate = { enabled = true },
    scroll = { enabled = true },
    bufdelete = { enabled = true },
    dim = dim_cfg,
    zen = zen_cfg,
    input = input_cfg,
    picker = { enabled = true },

    -- gitbrowse = { enabled = true },
    -- lazygit = { enabled = true },
    -- notifier = { enabled = true },
    -- quickfile = { enabled = true },
    -- rename = { enabled = true },
    -- scope = { enabled = true },
    -- terminal = { enabled = true },
    -- words = { enabled = true },
    -- scratch = { enabled = true },
    -- debug = { enabled = true },
    -- image = { enabled = true },



    -- dashboard = { enabled = true },
    -- explorer = { enabled = true },
    -- indent = { enabled = true },
    -- statuscolumn = { enabled = true },
    -- bigfile = { enabled = true },
}

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map({ "n" }, "<leader>z", function()
    sk.dim()
end, opts)

vim.ui.input = function(data, on_confirm)
    sk.input(data, on_confirm)
end

vim.ui.select = function(items, opts, on_choice)
    sk.picker.select(items, opts, on_choice)
end
