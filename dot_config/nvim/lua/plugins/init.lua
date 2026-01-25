vim.g.coc_config_home = vim.fn.stdpath("config")
vim.g.coc_data_home = vim.fn.stdpath("data") .. "/coc"

-- Global extension list to be installed automatically
vim.g.coc_global_extensions = {
    'coc-dictionary',
    'coc-emoji',
    'coc-explorer',
    'coc-extension-codemod',
    'coc-git',
    'coc-go',
    'coc-highlight',
    'coc-json',
    'coc-lists',
    'coc-lua',
    'coc-marketplace',
    'coc-rust-analyzer',
    'coc-snippets',
    'coc-spell-checker',
    'coc-syntax',
    'coc-tag',
    'coc-translator',
    'coc-vimlsp',
    'coc-word',
    'coc-yank',
}

local function safe_load_file(path)
    if vim.fn.filereadable(path) == 1 then
        -- 使用 pcall 安全执行，防止报错中断启动
        local status, err = pcall(dofile, path)
        if not status then
            vim.notify("加载失败 [" .. path .. "]:\n" .. err, vim.log.levels.ERROR)
            -- else
            -- vim.notify("已加载: " .. path, vim.log.levels.INFO) -- 调试用
        end
    else
        error("path[" .. path .. "] not exist")
    end
end


local function load_plugin_config(filename)
    local plugin_path = vim.fn.stdpath("config") .. "/lua/plugins/" .. filename
    safe_load_file(plugin_path)
end

local function load_data_config(filepath)
    local path = vim.fn.stdpath("data") .. "/" .. filepath
    safe_load_file(path)
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)


-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        --  编辑器配色插件 ====================================================
        { 'rktjmp/lush.nvim' },
        { 'gbprod/nord.nvim',            config = function() vim.cmd.color('nord') end }, -- 编辑器配色插件
        { 'AlexvZyl/nordic.nvim' },
        { 'rmehri01/onenord.nvim' },
        { 'fcancelinha/nordern.nvim' },
        { 'chriskempson/base16-vim' },
        { 'rebelot/kanagawa.nvim' },
        { 'vague-theme/vague.nvim' },
        { 'zenbones-theme/zenbones.nvim' },
        { 'kvrohit/rasmus.nvim' },
        {
            'antonk52/lake.nvim',
            config = function() -- vim.cmd.color('lake')
            end
        },
        -- no color
        { 'LuRsT/austere.vim' },
        { 'cideM/yui' },
        { 'pgdouyon/vim-yin-yang' },
        { 'kxzk/skull-vim' },
        { 'ntk148v/komau.vim' },
        { 'maxmx03/solarized.nvim' },
        -- Coc.nvim ===========================================================
        {
            'neoclide/coc.nvim',
            build = 'pnpm install',
            config = function()
                load_data_config("/lazy/coc.nvim/doc/coc-example-config.lua")
                load_plugin_config("coc.nvim.lua")
            end
        },
        -- 注释插件 ===========================================================
        {
            'numToStr/Comment.nvim',
            config = function()
                load_plugin_config("comment.nvim.lua")
            end
        },
        -- Telescope Fuzzy Finder =============================================
        {
            'nvim-telescope/telescope.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
                -- optional but recommended
                { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            },
            config = function()
                load_plugin_config("telescope.nvim.lua")
            end
        },
        -- Telescope coc integration ===========================================
        {
            'fannheyward/telescope-coc.nvim',
            dependencies = "nvim-lua/plenary.nvim",
        },
        -- 高亮 ===============================================================
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                load_plugin_config("nvim-treesitter.lua")
            end
        },
        -- TODO 注释关键字高亮 ================================================
        {
            "folke/todo-comments.nvim",
            dependencies = "nvim-lua/plenary.nvim",
            config = function()
                load_plugin_config("todo-comments.lua")
            end
        },
        -- 高亮搜索关键字 =====================================================
        {
            'kevinhwang91/nvim-hlslens',
            config = function()
                load_plugin_config("nvim-hlslens.lua")
            end
        },
        -- 函数括号线 =========================================================
        {
            "shellRaining/hlchunk.nvim",
            event = { "BufReadPre", "BufNewFile" },
            config = function()
                load_plugin_config("hlchunk.nvim.lua")
            end
        },
        -- markdown 预览插件 ==================================================
        {
            "iamcco/markdown-preview.nvim",
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            ft = { "markdown" },
            build = function() vim.fn["mkdp#util#install"]() end,
        },
        -- marks 插件 =========================================================
        {
            "chentoast/marks.nvim",
            config = function()
                load_plugin_config("marks.nvim.lua")
            end
        },
        -- 批量替换插件 =======================================================
        {
            "windwp/nvim-spectre",
            dependencies = "nvim-lua/plenary.nvim",
            config = function()
                load_plugin_config("nvim-spectre.lua")
            end
        },
        -- 分隔符快捷操作 =====================================================
        {
            "kylechui/nvim-surround",
            version = "*", -- Use for stability; omit to use `main` branch for the latest features
            event = "VeryLazy",
            config = function()
                load_plugin_config("nvim-surround.lua")
            end
        },
        {
            'junegunn/vim-peekaboo'
        },
        -- lualine ============================================================
        {
            'nvim-lualine/lualine.nvim',
            config = function()
                load_plugin_config("lualine.nvim.lua")
            end
        },
        --  大文件 =============================================================
        {
            "LunarVim/bigfile.nvim",
            version = "*",
            config = function()
                load_plugin_config("bigfile.nvim.lua")
            end
        },
        {
            "lewis6991/gitsigns.nvim",
            event = { "BufReadPre", "BufNewFile" },
            config = function()
                load_plugin_config("gitsigns.nvim.lua")
            end
        },
        -- 滚动条 =============================================================
        -- {
        --     'petertriho/nvim-scrollbar',
        --     config = function()
        --         load_plugin_config("nvim-scrollbar.lua")
        --     end
        -- },
        {
            "hedyhli/outline.nvim",
            lazy = true,
            cmd = { "Outline", "OutlineOpen" },
            config = function()
                load_plugin_config("outline.nvim.lua")
            end
        }
    },
    -- Configure any other settings here. See the documentation for more details.
    --
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = false },
})
-- ============================================================================
-- End of file
-- ============================================================================
