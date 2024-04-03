require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query",
        "elixir", "heex", "javascript", "html",
        "go", "rust", "gomod", "gosum" },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
})
