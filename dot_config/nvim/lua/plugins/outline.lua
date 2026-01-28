require("outline").setup {
    -- Your setup opts here (leave empty to use defaults)
}

local map = vim.keymap.set

map("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
map("n", "<F4>", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
