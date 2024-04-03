local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- ========================================================================
    -- https://github.com/neoclide/coc.nvim coc.nvim
    {
        'neoclide/coc.nvim',
        build = 'pnpm install',
        config = function()
            require("plugins/coc")
        end
    },

    -- ========================================================================
    -- https://github.com/numToStr/Comment.nvim 注释
    {
        'numToStr/Comment.nvim',
    },

    -- ========================================================================
    -- https://github.com/neoclide/jsonc.vim  highlight of jsonc filetype
    {
        'neoclide/jsonc.vim',
        config = function()
            require('plugins/comment')
        end
    },

    -- ========================================================================
    -- https://github.com/nvim-tree/nvim-tree.lua 目录树插件
    {
        'nvim-tree/nvim-tree.lua',
        version = '*',
        config = function()
            require(
                "plugins/nvim-tree")
        end
    },

    -- ========================================================================
    -- https://github.com/shaunsingh/nord.nvim 编辑器配色插件
    {
        'shaunsingh/nord.nvim',
        config = function()
            vim.cmd([[colorscheme nord]])
        end
    },

    -- ========================================================================
    -- https://github.com/nvim-telescope/telescope.nvim 模糊搜索
    {
        "nvim-telescope/telescope.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins/telescope")
        end
    },
    { 'fannheyward/telescope-coc.nvim' },

    -- ========================================================================
    -- https://github.com/nvim-treesitter/nvim-treesitter code highlight
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },

    -- ========================================================================
    -- https://github.com/folke/todo-comments.nvim 注释关键字高亮
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require(
                "plugins/todo-comments")
        end
    },

    -- ========================================================================
    -- https://github.com/kevinhwang91/nvim-hlslens 高亮搜索关键字
    {
        'kevinhwang91/nvim-hlslens',
        config = function()
            require("plugins/nvim-hlslens")
        end
    },

    -- ========================================================================
    -- https://github.com/nvim-lualine/lualine.nvim 状态栏
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('plugins/lualine')
        end
    },

    -- ========================================================================
    -- https://github.com/petertriho/nvim-scrollbar 滚动条
    {
        'petertriho/nvim-scrollbar',
        config = function()
            require('plugins/nvim-scrollbar')
        end
    },

    -- ========================================================================
    -- https://github.com/shellRaining/hlchunk.nvim 函数扩号线
    {
        'shellRaining/hlchunk.nvim',
        config = function()
            require('plugins/hlchunk')
        end
    },

    -- ========================================================================
    -- https://github.com/nathom/filetype.nvim filetype.vim 加速替代
    {
        'nathom/filetype.nvim',
        lazy = false,
        config = function()
            require('plugins/filetype')
            vim.g.did_load_filetypes = 1
        end
    },

    -- ========================================================================
    -- https://github.com/iamcco/markdown-preview.nvim markdown 预览插件
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    -- ========================================================================
    -- https://github.com/tpope/vim-fugitive
    {
        "tpope/vim-fugitive",
        config = function()
            vim.cmd([[source ~/.config/nvim/lua/plugins/vim-fugitive.vim]])
        end
    },

    -- ========================================================================
    -- https://github.com/chentoast/marks.nvim mark 插件
    {
        "chentoast/marks.nvim",
        config = function()
            require('plugins/marks')
        end
    },

    -- ========================================================================
    -- https://github.com/nvim-pack/nvim-spectre 批量替换插件
    {
        "windwp/nvim-spectre",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require('plugins/nvim-spectre')
        end
    },

    -- ========================================================================
    -- https://github.com/kylechui/nvim-surround 分隔符快捷操作
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require('plugins/nvim-surround')
        end
    },
})


vim.cmd([[source ~/.config/nvim/lua/plugins/coc-custom.vim]])
vim.cmd([[source ~/.config/nvim/lua/plugins/custom.vim]])
