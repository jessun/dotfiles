return {
    { "junegunn/vim-peekaboo" },
    {
        "chentoast/marks.nvim",
        opts = {},
    },
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        cond = false,
        opts = {},
    },
    {
        "hedyhli/outline.nvim",
        -- cond = not vim.g.enable_coc,
        cmd = { "Outline", "OutlineOpen" },
        opts = {},
        keys = { -- Example mapping to toggle outline
            { "<leader>o", "<cmd>Outline<CR>", desc = "Outline: toggle" },
            { "<F3>",      "<cmd>Outline<CR>", desc = "Outline: toggle" },
        },
    },
    {
        "rmagatti/auto-session",
        lazy = false,

        ---enables autocomplete for opts
        ---@module "auto-session"
        ---@type AutoSession.Config
        opts = {
            suppressed_dirs = {
                "~/",
                "~/workbench/",
                "~/Downloads",
                "/",
            },
            -- log_level = 'debug',
        },
    },
}
