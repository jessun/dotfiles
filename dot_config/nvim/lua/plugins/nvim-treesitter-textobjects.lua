vim.g.no_plugin_maps = true
-- configuration
require("nvim-treesitter-textobjects").setup {
    select = {
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V',  -- linewise
            -- ['@class.outer'] = '<c-v>', -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true of false
        include_surrounding_whitespace = false,
    },
    move = {
        -- whether to set jumps in the jumplist
        set_jumps = true,
    },
}

local map = vim.keymap.set
-- keymaps
-- You can use the capture groups defined in `textobjects.scm`
map({ "x", "o" }, "am", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
end)
map({ "x", "o" }, "im", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
end)
map({ "x", "o" }, "ac", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
end)
map({ "x", "o" }, "ic", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
end)
-- You can also use captures from other query groups like `locals.scm`
map({ "x", "o" }, "as", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
end)
-- Text objects: swap
map("n", "<leader>a", function()
    require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
end)
map("n", "<leader>A", function()
    require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.outer"
end)

-- Text objects: move
-- keymaps
-- You can use the capture groups defined in `textobjects.scm`
map({ "n", "x", "o" }, "]m", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end)
map({ "n", "x", "o" }, "]]", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end)
-- You can also pass a list to group multiple queries.
map({ "n", "x", "o" }, "]o", function()
    require("nvim-treesitter-textobjects.move").goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
end)
-- You can also use captures from other query groups like `locals.scm` or `folds.scm`
map({ "n", "x", "o" }, "]s", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
end)
map({ "n", "x", "o" }, "]z", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
end)

map({ "n", "x", "o" }, "]M", function()
    require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
end)
map({ "n", "x", "o" }, "][", function()
    require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
end)

map({ "n", "x", "o" }, "[m", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end)
map({ "n", "x", "o" }, "[[", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
end)

map({ "n", "x", "o" }, "[M", function()
    require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
end)
map({ "n", "x", "o" }, "[]", function()
    require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
end)

-- Go to either the start or the end, whichever is closer.
-- Use if you want more granular movements
map({ "n", "x", "o" }, "]d", function()
    require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
end)
map({ "n", "x", "o" }, "[d", function()
    require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
end)

local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
-- map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
map({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
map({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
map({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
map({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
