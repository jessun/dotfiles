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

local map = vim.keymap.set
local opts = { silent = true }

map("n", "<leader>d", ":Telescope coc workspace_diagnostics<CR>", opts)
map("n", "<leader>td", ":Telescope coc diagnostics<CR>", opts)
map("n", "<leader>tr", ":Telescope coc references<CR>", opts)
map("n", "<leader>tu", ":Telescope coc references_used<CR>", opts)
