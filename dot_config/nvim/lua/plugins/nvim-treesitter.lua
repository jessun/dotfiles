require('nvim-treesitter').setup({
    install_dir = vim.fn.stdpath('data') .. '/site',
    highlight = {
        enable = true, -- 启用高亮
        additional_vim_regex_highlighting = false,
    },
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "rust", "json", "javascript", "typescript" },
    auto_install = true,
})


vim.opt.rtp:prepend(vim.fn.stdpath('data') .. '/site')
