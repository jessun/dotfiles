require("telescope").setup({
    defaults = {
        layout_config = {
            width = 0.999,
            height = 0.999,
            -- other layout configuration here
        },
    },
    extensions = {
        coc = {
            prefer_locations = true,    -- always use Telescope locations to preview definitions/declarations/implementations etc
            push_cursor_on_edit = true, -- save the cursor position to jump back in the future
            timeout = 3000,             -- timeout for coc commands
        }
    }
})
require('telescope').load_extension('coc')

vim.api.nvim_set_keymap("n", "<leader>t/", ":Telescope live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tb", ":Telescope buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tc", ":Telescope commands<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tf", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>th", ":Telescope help_tags<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tk", ":Telescope marks<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tm", ":Telescope keymaps<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tr", ":Telescope registers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>to",
    ":lua require('telescope.builtin').colorscheme({enable_preview=true})<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>td", ":Telescope coc diagnostics<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "tr", ":Telescope coc references<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "tu", ":Telescope coc references_used<CR>", { noremap = true, silent = true })

-- --- Quick Access Mappings ---
vim.api.nvim_set_keymap("n", "<leader>m", ":Telescope keymaps<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><leader>", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>b", ":Telescope buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>/", ":Telescope live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>d", ":Telescope coc workspace_diagnostics<CR>", { noremap = true, silent = true })
local builtin = require('telescope.builtin')
-- <leader>w: 在当前 Buffer 中搜索当前光标下的单词
vim.keymap.set('n', '<leader>w',
    function() builtin.current_buffer_fuzzy_find({ default_text = vim.fn.expand('<cword>') }) end,
    { noremap = true, silent = true, desc = "Search word in buffer" })

-- <leader>W: 在当前 Workspace (项目) 中搜索当前光标下的单词
vim.keymap.set('n', '<leader>W', function()
    builtin.live_grep({ default_text = vim.fn.expand('<cword>') })
end, { noremap = true, silent = true, desc = "Search word in workspace" })
