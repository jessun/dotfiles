require("telescope").setup({
    extensions = {
        coc = {
            prefer_locations = true,
            push_cursor_on_edit = true,
            timeout = 3000,
        }
    }
})
require('telescope').load_extension('coc')

vim.api.nvim_set_keymap("n", "<leader>d", ":Telescope coc workspace_diagnostics<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>td", ":Telescope coc diagnostics<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "tr", ":Telescope coc references<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "tu", ":Telescope coc references_used<CR>", { noremap = true, silent = true })
