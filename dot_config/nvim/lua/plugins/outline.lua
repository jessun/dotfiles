require("outline").setup {
    -- Your setup opts here (leave empty to use defaults)
}

vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
