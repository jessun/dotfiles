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

Snacks.setup {
    animate = {},
    bufdelete = {},
    dim = dim_cfg,
    input = input_cfg,
    lazygit = {},
    notifier = {},
    picker = {},
    quickfile = {},
    rename = {},
    scratch = {},
    scroll = {},
    terminal = {},
    toggle = {},
    words = {},
}

vim.ui.input = function(data, on_confirm)
    Snacks.input(data, on_confirm)
end

vim.ui.select = function(items, opts, on_choice)
    Snacks.picker.select(items, opts, on_choice)
end

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map({ "n" }, "<leader>z", function() Snacks.toggle.dim():toggle() end, opts)
map({ "n" }, "<leader>g", function() Snacks.lazygit.open() end, opts)
map({ "n" }, "<leader>n", function() Snacks.notifier.show_history() end, opts)
map({ "n" }, "<leader>h", function() Snacks.toggle.inlay_hints():toggle() end, opts)
map({ "n" }, "]]", function() Snacks.words.jump(1, true) end, { desc = "Next Reference (下一个引用)" })
map({ "n" }, "[[", function() Snacks.words.jump(-1, true) end, { desc = "Prev Reference (上一个引用)" })
map({ "n", "t" }, "<C-\\>", function() Snacks.terminal.toggle() end, opts)
