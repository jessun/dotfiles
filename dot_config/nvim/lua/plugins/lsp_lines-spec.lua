return {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    lazy = false,
    opts = {},
    keys = {
        { "<leader>l", function() require('lsp_lines').toggle() end, mode = { "n" }, desc = "" }
    },
}
