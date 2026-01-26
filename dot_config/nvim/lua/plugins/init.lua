-- ============================================================================
-- 1. Functions
-- ============================================================================
local function safe_load_file(path)
    if vim.fn.filereadable(path) == 1 then
        -- 使用 pcall 安全执行，防止报错中断启动
        local status, err = pcall(dofile, path)
        if not status then
            vim.notify(
                "加载失败 [" .. path .. "]:\n" .. err,
                vim.log.levels.ERROR)
            -- else
            -- vim.notify("已加载: " .. path, vim.log.levels.INFO) -- 调试用
        end
    else
        error("path[" .. path .. "] not exist")
    end
end

--
local function load_plugin_config(filename)
    local plugin_path =
        vim.fn.stdpath("config") .. "/lua/plugins/" .. filename
    safe_load_file(plugin_path)
end

--
local function load_data_config(filepath)
    -- vim.fn.stdpath("data"): ~/.local/share/nvim/
    local path = vim.fn.stdpath("data") .. "/" .. filepath
    safe_load_file(path)
end


-- ============================================================================
-- 2. LSP
-- ============================================================================
vim.g.enable_coc = false
vim.g.enable_native_lsp = not vim.g.enable_coc

-- coc.nvim OR nvim-lspconfig
if vim.g.enable_coc then
    load_plugin_config("coc-plugins.lua")
end


-- ============================================================================
-- 3. Bootstrap lazy.nvim
-- ============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out =
        vim.fn.system(
            { "git", "clone", "--filter=blob:none",
                "--branch=stable", lazyrepo, lazypath })
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

-- ============================================================================
-- 3. Plugins
-- ============================================================================
local plugins = {
    --  编辑器配色插件 ========================================================
    {
        'gbprod/nord.nvim', config = function() vim.cmd.color('nord') end
    },
    { 'rktjmp/lush.nvim' },
    { 'AlexvZyl/nordic.nvim' },
    { 'rmehri01/onenord.nvim' },
    { 'fcancelinha/nordern.nvim' },
    { 'chriskempson/base16-vim' },
    { 'rebelot/kanagawa.nvim' },
    { 'vague-theme/vague.nvim' },
    { 'zenbones-theme/zenbones.nvim' },
    { 'kvrohit/rasmus.nvim' },
    { 'antonk52/lake.nvim', },
    -- no color
    { 'LuRsT/austere.vim' },
    { 'cideM/yui' },
    { 'pgdouyon/vim-yin-yang' },
    { 'kxzk/skull-vim' },
    { 'ntk148v/komau.vim' },
    { 'maxmx03/solarized.nvim' },
    -- 注释插件 ===============================================================
    {
        'numToStr/Comment.nvim',
        config = function()
            load_plugin_config("comment.nvim.lua")
        end
    },
    -- Telescope Fuzzy Finder =================================================
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
    -- TODO 注释关键字高亮 ================================================
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            load_plugin_config("todo-comments.lua")
        end
    },
    -- 高亮 ===============================================================
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            load_plugin_config("nvim-treesitter.lua")
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
    -- registers 快捷操作 ============================================================
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
    -- 大文件 =============================================================
    {
        "LunarVim/bigfile.nvim",
        version = "*",
        config = function()
            load_plugin_config("bigfile.nvim.lua")
        end
    },
    -- git sign =============================================================
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            load_plugin_config("gitsigns.nvim.lua")
        end
    },
    -- code outline =============================================================
    {
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        config = function()
            load_plugin_config("outline.nvim.lua")
        end
    },
}

local coc_plugins = {
    -- Coc.nvim ===============================================================
    {
        'neoclide/coc.nvim',
        build = 'pnpm install',
        config = function()
            load_data_config("/lazy/coc.nvim/doc/coc-example-config.lua")
            load_plugin_config("coc.nvim.lua")
        end
    },
    -- Telescope coc integration ==========================================
    {
        'fannheyward/telescope-coc.nvim',
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            load_plugin_config("coc-telescope.lua")
        end
    },
}
local nvim_lsp_plugins = {
    -- LSP ================================================================
    {
        'junnplus/lsp-setup.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
        },
        config = function()
            load_plugin_config("lsp-setup.nvim.lua")
        end
    },
    -- LSP progress messages ==============================================
    {
        "j-hui/fidget.nvim",
        eanbled = false,
        config = function()
            load_plugin_config("fidget.nvim.lua")
        end
    },
    -- 显示代码中的 LSP 错误 ==============================================
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            load_plugin_config("lsp_lines.nvim.lua")
        end,
    },
    -- 补全插件 ===========================================================
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",   -- 来源：当前 Buffer 内容
            "hrsh7th/cmp-cmdline",  -- 来源：命令行
            "hrsh7th/cmp-nvim-lsp", -- 来源：LSP
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",         -- 来源：文件路径
            "lukas-reineke/cmp-under-comparator",
            "onsails/lspkind.nvim",     -- UI：补全列表图标 (可选，但推荐)
            "quangnguyen30192/cmp-nvim-tags",
            "saadparwaiz1/cmp_luasnip", -- 桥接：LuaSnip 到 CMP
            "uga-rosa/cmp-dictionary",
        },
        config = function()
            load_plugin_config("nvim-cmp.lua")
        end
    },
    -- snippet engine written in Lua ======================================
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        config = function()
            load_plugin_config("luasnip.lua")
        end
    },
    -- File explorer ======================================================
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            -- "nvim-tree/nvim-web-devicons", -- optional, but recommended
        },
        lazy = false, -- neo-tree will lazily load itself
        config = function()
            load_plugin_config("neo-tree.nvim.lua")
        end
    },
    -- 颜色值高亮 =========================================================
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        config = function()
            load_plugin_config("nvim-colorizer.lua")
        end
    },
    -- Rust =============================================================
    {
        "mrcjkb/rustaceanvim",
        version = '^7', -- Recommended
        lazy = false,   -- This plugin is already lazy
        config = function()
            load_plugin_config("rustaceanvim.lua")
        end
    },
    -- LuaLS 配置 =========================================================
    {
        "folke/lazydev.nvim",
    },
    -- Json =============================================================
    {
        "b0o/SchemaStore.nvim",
    },
    -- 高亮光标当前词 =====================================================
    {
        "RRethy/vim-illuminate",
    },
    -- 剪切板历史 =====================================================
    {
        "gbprod/yanky.nvim",
        config = function()
            load_plugin_config("yanky.nvim.lua")
        end
    },
    -- formatter =============================================================
    {
        'stevearc/conform.nvim',
        config = function()
            load_plugin_config("conform.nvim.lua")
        end
    },
}

if vim.g.enable_coc then
    vim.list_extend(plugins, coc_plugins)
end

if vim.g.enable_native_lsp then
    vim.list_extend(plugins, nvim_lsp_plugins)
end

require("lazy").setup({
    spec = plugins,
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "nord" } },
    -- automatically check for plugin updates
    checker = { enabled = false },
})
-- ============================================================================
-- fix theme
-- ============================================================================
load_plugin_config("after.lua")
-- ============================================================================
-- End of file
-- ============================================================================
