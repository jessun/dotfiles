require('hlchunk').setup({
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
            "#FF0000",
            "#FF7F00",
            "#FFFF00",
            "#00FF00",
            "#00FFFF",
            "#0000FF",
            "#8B00FF",
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
        enable = true,
        support_filetypes = {
            "*"
        },
        style = "#D08770",
    },
    chunk = {
        enable = true,
        support_filetypes = {
            "*.go",
            "*.rs"
        },
        chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "┌",
            left_bottom = "└",
            right_arrow = ">",
        },
        style = "#A3BE8C",
    },
})
