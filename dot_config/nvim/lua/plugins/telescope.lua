require("telescope").setup({
    defaults = {
        layout_config = {
            width = 0.999,
            height = 0.999,
            -- other layout configuration here
        },
    },
})

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
map({ "n" }, "<leader>t/", ":Telescope live_grep<CR>", opts)
map({ "n" }, "<leader>tb", ":Telescope buffers<CR>", opts)
map({ "n" }, "<leader>tc", ":Telescope commands<CR>", opts)
map({ "n" }, "<leader>tf", ":Telescope find_files<CR>", opts)
map({ "n" }, "<leader>th", ":Telescope help_tags<CR>", opts)
map({ "n" }, "<leader>tk", ":Telescope marks<CR>", opts)
map({ "n" }, "<leader>tm", ":Telescope keymaps<CR>", opts)
map({ "n" }, "<leader>td", ":Telescope diagnostics<CR>", opts)
map({ "n" }, "<leader>tr", ":Telescope registers<CR>", opts)
map({ "n" }, "<leader>to", ":lua require('telescope.builtin').colorscheme({enable_preview=true})<CR>", opts)

-- --- Quick Access Mappings ---
map({ "n" }, "<leader>m", ":Telescope keymaps<CR>", opts)
map({ "n" }, "<leader><leader>", ":Telescope find_files<CR>", opts)
map({ "n" }, "<leader>b", ":Telescope buffers<CR>", opts)
map({ "n" }, "<leader>/", ":Telescope live_grep<CR>", opts)
map({ "n" }, "<leader>d", ":Telescope diagnostics<CR>", opts)

local builtin = require('telescope.builtin')
-- <leader>w: 在当前 Buffer 中搜索当前光标下的单词
map({ "n" }, "<leader>w",
    function()
        builtin.current_buffer_fuzzy_find({
            default_text = vim.fn.expand('<cword>')
        })
    end, opts)

-- <leader>W: 在当前 Workspace (项目) 中搜索当前光标下的单词
map({ "n" }, "<leader>W",
    function()
        builtin.live_grep({
            default_text = vim.fn.expand('<cword>')
        })
    end, opts)
