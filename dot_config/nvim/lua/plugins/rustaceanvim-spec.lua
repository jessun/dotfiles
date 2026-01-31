return {
    "mrcjkb/rustaceanvim",
    cond = vim.g.enable_native_lsp,
    lazy = false, -- This plugin is already lazy
    keys = {
        { "<leader>ac", function() vim.cmd.RustLsp('codeAction') end,           mode = { "n" }, desc = "Rustaceanvim: code action" },
        { "K",          function() vim.cmd.RustLsp({ 'hover', 'actions' }) end, mode = { "n" }, desc = "Rustaceanvim: hover action" },
    },
}
