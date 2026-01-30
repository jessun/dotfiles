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
local sk = require('snacks')

sk.setup {
    animate = { enabled = true },
    scroll = { enabled = true },
    bufdelete = { enabled = true },
    dim = dim_cfg,

    -- gitbrowse = { enabled = true },
    -- input = { enabled = true },
    -- lazygit = { enabled = true },
    -- notifier = { enabled = true },
    -- picker = { enabled = true },
    -- quickfile = { enabled = true },
    -- rename = { enabled = true },
    -- scope = { enabled = true },
    -- terminal = { enabled = true },
    -- words = { enabled = true },
    -- zen = { enabled = true },
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
