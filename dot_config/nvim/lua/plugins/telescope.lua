-- https://github.com/nvim-telescope/telescope.nvim
require("telescope").setup({
    defaults = {
        layout_config = {
            width = 0.999,
            height = 0.999,
            -- other layout configuration here
        },
    },
    pickers = {
        find_files = {
        }
    },
    extensions = {
        tmuxinator = {
            select_action = "switch", -- | 'stop' | 'kill'
            stop_action = "stop",     -- | 'kill'
            disable_icons = true,
        },
        coc = {
            prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
        },
    },
})
require('telescope').load_extension('coc')


vim.api.nvim_set_keymap("n", "<leader>*",
    ":lua require('telescope.builtin').live_grep({ default_text = vim.fn.expand('<cword>') })<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><leader>", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>/", ":Telescope live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>t<leader>", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>k", ":Telescope keymaps<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>b", ":Telescope buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>th", ":Telescope help_tags<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tc", ":Telescope commands<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tm", ":Telescope marks<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tr", ":Telescope registers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", '"', ":Telescope registers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>to", ":lua require('telescope.builtin').colorscheme({enable_preview=true})<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>tw", ":Telescope coc workspace_diagnostics<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>td", ":Telescope coc diagnostics<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "tr", ":Telescope coc references<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "tu", ":Telescope coc references_used<CR>", { noremap = true, silent = true })
