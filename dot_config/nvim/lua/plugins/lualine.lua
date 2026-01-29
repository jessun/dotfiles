local diagnostic_sources = {}

local nord = require("utils.nord_colors")

if vim.g.enable_coc then
    table.insert(diagnostic_sources, "coc")
else
    table.insert(diagnostic_sources, "nvim_lsp")
end

local function search_result()
    if vim.v.hlsearch == 0 then
        return ""
    end
    local last_search = vim.fn.getreg("/")
    if not last_search or last_search == "" then
        return ""
    end
    local searchcount = vim.fn.searchcount({ maxcount = 9999 })
    return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
end

local custom_nord = require("lualine.themes.nord")
custom_nord.normal.a.bg = nord.base.bg
custom_nord.normal.a.fg = nord.base.comment
custom_nord.normal.a.gui = ""

custom_nord.insert.a.bg = nord.base.bg
custom_nord.insert.a.fg = nord.base.comment
custom_nord.insert.a.gui = ""

custom_nord.normal.a.bg = nord.base.bg
custom_nord.normal.b.bg = nord.base.bg
custom_nord.normal.c.bg = nord.base.bg

require("lualine").setup({
    options = {
        theme = custom_nord,
        icons_enabled = false,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        refresh = {
            statusline = 1000,
            tabline = 10,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = {
            {
                "mode",
                fmt = function(str)
                    return str:sub(1, 1)
                end,
            },
        },
        lualine_b = {
            {
                "diagnostics",
                sources = diagnostic_sources,
                diagnostics_color = {
                    error = { bg = nord.base.bg, fg = nord.diagnostic.error },
                    warn = { bg = nord.base.bg, fg = nord.diagnostic.warn },
                    info = { bg = nord.base.bg, fg = nord.diagnostic.info },
                    hint = { bg = nord.base.bg, fg = nord.diagnostic.hint },
                },
                symbols = { error = "E", warn = "W", info = "I", hint = "H", debug = "D" },
                colored = true,         -- Displays diagnostics status in color if set to true.
                always_visible = true,  -- Show diagnostics even if there are none.
                update_in_insert = true -- Update diagnostics in insert mode.
            },
            { "branch", color = { bg = nord.base.bg, fg = nord.base.comment } },
            {
                "diff",
                colored = true,                                           -- Displays a colored diff status if set to true
                symbols = { added = "+", modified = "~", removed = "-" }, -- Changes the symbols used by the diff.
                diff_color = {
                    added = { bg = nord.base.bg, fg = nord.git.added },
                    modified = { bg = nord.base.bg, fg = nord.git.modified },
                    removed = { bg = nord.base.bg, fg = nord.git.removed },
                },
            },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
            { search_result },
            { "location" },
            { "progress" },
            { "filetype" },
        },
    },
    tabline = {
        lualine_a = {
            {
                "buffers",
                show_filename_only = true,       -- Shows shortened relative path when set to false.
                hide_filename_extension = false, -- Hide filename extension when set to true.
                show_modified_status = true,     -- Shows indicator when the buffer is modified.

                mode = 2,                        -- 0: Shows buffer name
                -- 1: Shows buffer index
                -- 2: Shows buffer name + buffer index
                -- 3: Shows buffer number
                -- 4: Shows buffer name + buffer number

                max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
                -- it can also be a function that returns
                -- the value of `max_length` dynamically.
                filetype_names = {
                    TelescopePrompt = "Telescope",
                    dashboard = "Dashboard",
                    packer = "Packer",
                    fzf = "FZF",
                    alpha = "Alpha",
                }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

                buffers_color = {
                    -- Same values as the general color option can be used here.
                    active = "lualine_c_normal",
                    inactive = "lualine_a_normal",
                },

                symbols = {
                    modified = "+", -- Text to show when the buffer is modified
                    -- alternate_file = "#", -- Text to show to identify the alternate file
                    -- directory = "", -- Text to show when the buffer is a directory
                },
            },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
})
