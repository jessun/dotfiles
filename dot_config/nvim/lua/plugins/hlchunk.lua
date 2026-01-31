local nord = require("utils.nord")
return {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        blank = {
            enable = false,
        },
        indent = {
            enable = false,
            use_treesitter = false,
            -- You can uncomment to get more indented line look like
            chars = {
                "│",
                "¦",
                "┆",
                "┊",
            },
            -- you can uncomment to get more indented line style
            style = {
                nord.accents.red,
                nord.accents.orange,
                nord.accents.yellow,
                nord.accents.green,
                nord.accents.blue,
                nord.accents.cyan,
                nord.accents.purple,
            },
            exclude_filetype = {
                dashboard = true,
                help = true,
                lspinfo = true,
                packer = true,
                checkhealth = true,
                man = true,
                mason = true,
                NvimTree = true,
                plugin = true,
            },
        },
        line_num = {
            enable = false,
            support_filetypes = {
                "*"
            },
            style = nord.accents.darkblue,
        },
        chunk = {
            enable = true,
            chars = {
                horizontal_line = "─",
                vertical_line = "│",
                left_top = "┌",
                left_bottom = "└",
                right_arrow = ">",
            },
            style = nord.accents.green,
        },
    },
}
