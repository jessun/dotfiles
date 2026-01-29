-- ============================================================================
-- 1. Helper Functions
-- ============================================================================

-- 专门用于 require 模块的安全加载函数
local function safe_require(module_name)
    -- require 只需要模块名，不需要 .lua 后缀，也不需要绝对路径
    local status, err = pcall(require, module_name)
    if not status then
        vim.notify(
            "加载模块失败 [" .. module_name .. "]:\n" .. err,
            vim.log.levels.ERROR
        )
    end
    return status
end

-- 专门用于加载任意路径文件的函数 (用于 data 目录等非模块文件)
local function safe_dofile(path)
    if vim.fn.filereadable(path) == 1 then
        local status, err = pcall(dofile, path)
        if not status then
            vim.notify(
                "加载文件失败 [" .. path .. "]:\n" .. err,
                vim.log.levels.ERROR
            )
        end
    else
        -- 这里可以选择是否报错，或者仅仅是 warn
        vim.notify("文件不存在: " .. path, vim.log.levels.WARN)
    end
end

-- ============================================================================
-- 2. Config Loaders
-- ============================================================================

-- 重构 1: 使用 require 加载插件配置
-- 假设传入 filename 为 "nvim-cmp.lua"
local function load_plugin_config(filename)
    -- 1. 去掉 .lua 后缀 (require 不需要后缀)
    local module_name = filename:gsub("%.lua$", "")

    -- 2. 拼接模块名 (lua/plugins/ 下的文件模块名为 "plugins.xxx")
    local target_module = "plugins." .. module_name

    safe_require(target_module)
end

-- 重构 2: 使用 vim.fs.joinpath 加载数据配置
-- 保持使用 dofile，因为这些文件通常不在 lua 的 require 搜索路径中
local function load_data_config(filepath)
    -- 使用 vim.fs.joinpath 自动处理路径分隔符 (Neovim 0.10+)
    local path = vim.fs.joinpath(vim.fn.stdpath("data"), filepath)
    safe_dofile(path)
end
-- ============================================================================
-- 2. LSP
-- ============================================================================
-- "COC=1 nvim"
local enable_coc = os.getenv("COC")
if enable_coc == "true" or enable_coc == "1" then
    vim.g.enable_coc = true
else
    vim.g.enable_coc = false
end
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
    { 'gbprod/nord.nvim' },
    -- { 'shaunsingh/nord.nvim', },
    -- { 'nordtheme/vim' },
    -- { 'AlexvZyl/nordic.nvim' },
    -- { 'rmehri01/onenord.nvim' },
    -- { 'fcancelinha/nordern.nvim' },
    { 'a/vim-trash-polka' },

    { 'tanvirtin/monokai.nvim' },
    { 'cocopon/iceberg.vim' },
    { 'rktjmp/lush.nvim' },
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
            load_plugin_config("comment.lua")
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
            load_plugin_config("telescope.lua")
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
            load_plugin_config("hlchunk.lua")
        end
    },
    -- marks 插件 =========================================================
    {
        "chentoast/marks.nvim",
        config = function()
            load_plugin_config("marks.lua")
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
            load_plugin_config("lualine.lua")
        end
    },
    -- 大文件 =============================================================
    {
        "LunarVim/bigfile.nvim",
        version = "*",
        config = function()
            load_plugin_config("bigfile.lua")
        end
    },
    -- git sign =============================================================
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            load_plugin_config("gitsigns.lua")
        end
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
        config = function()
            load_plugin_config("noice.lua")
        end
    }
}

local coc_plugins = {
    -- Coc.nvim ===============================================================
    {
        'neoclide/coc.nvim',
        build = 'pnpm install',
        config = function()
            load_data_config("/lazy/coc.nvim/doc/coc-example-config.lua")
            load_plugin_config("coc.lua")
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
    {
        'gelguy/wilder.nvim',
        cond = false,
        config = function()
            load_plugin_config("wilder.lua")
        end
    }
}
local nvim_lsp_plugins = {
    -- LSP ================================================================
    {
        'junnplus/lsp-setup.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
        },
        config = function()
            load_plugin_config("lsp-setup.lua")
        end
    },
    -- 显示代码中的 LSP 错误 ==============================================
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            load_plugin_config("lsp_lines.lua")
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
            load_plugin_config("neo-tree.lua")
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
    -- Golang =============================================================
    {
        "ray-x/go.nvim",
        cond = false,
        event = { "CmdlineEnter" },
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
    -- Rust =============================================================
    {
        "mrcjkb/rustaceanvim",
        lazy = false, -- This plugin is already lazy
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
            load_plugin_config("yanky.lua")
        end
    },
    -- code outline =============================================================
    {
        "hedyhli/outline.nvim",
        lazy = false,
        cmd = { "Outline", "OutlineOpen" },
        config = function()
            load_plugin_config("outline.lua")
        end
    },
    -- formatter =============================================================
    {
        'stevearc/conform.nvim',
        config = function()
            load_plugin_config("conform.lua")
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
    -- automatically check for plugin updates
    checker = { enabled = false },
})
-- ============================================================================
-- after.lua
-- ============================================================================
load_plugin_config("after.lua")
-- ============================================================================
-- End of file
-- ============================================================================
