-- -----------------------------------------------------------------------------
--  Core Options
--  Author:      jessun.pro@gmail.com
--  Description: General editor behavior, performance tuning, and XDG file management.
--  Location:    ~/.config/nvim/lua/options.lua
-- -----------------------------------------------------------------------------

local opt = vim.opt
local g = vim.g

-- ============================================================================
-- 1. XDG Path Isolation
-- ============================================================================
-- Logic: Use 'nvim' folder for all data if running as dev app
local app_name = vim.env.NVIM_APPNAME or "nvim"
local state_dir = vim.fn.expand("$HOME/.local/state/" .. app_name .. "/")

-- Ensure directories exist
if vim.fn.isdirectory(state_dir) == 0 then
    vim.fn.mkdir(state_dir, "p", 0700)
end

-- Isolate Swap, Undo, and Backup files
opt.directory = state_dir .. "swap//"
opt.undodir = state_dir .. "undo//"
opt.backupdir = state_dir .. "backup//"
opt.undofile = true -- Enable persistent undo
opt.swapfile = true
opt.backup = false  -- Disable backup (rely on git)

-- ============================================================================
-- 2. UI & Appearance
-- ============================================================================
opt.number = true         -- Show line numbers
opt.relativenumber = true -- Relative line numbers
opt.signcolumn = "yes"    -- Always show sign column
opt.cursorline = true     -- Highlight current line
opt.showtabline = 2       -- Always show tabline
opt.laststatus = 2        -- Always show statusline
opt.cmdheight = 2         -- Command line height
opt.showcmd = true        -- Show incomplete commands
opt.scrolloff = 999       -- Keep cursor vertically centered
opt.sidescrolloff = 5     -- Keep context when scrolling sideways
opt.splitright = true     -- Split vertical windows to the right
opt.splitbelow = true     -- Split horizontal windows to the bottom
opt.list = true           -- Show invisible characters
opt.listchars = { tab = "| ", trail = "·", extends = "»", precedes = "«" }
opt.wrap = false
opt.colorcolumn = "80"

-- ============================================================================
-- 3. Indentation & Editing
-- ============================================================================
opt.expandtab = true                         -- Use spaces instead of tabs
opt.tabstop = 4                              -- 4 spaces for a tab
opt.shiftwidth = 4                           -- 4 spaces for indentation
opt.softtabstop = 4
opt.autoindent = true                        -- Copy indent from previous line
opt.smartindent = true                       -- Smarter indentation for code
opt.breakindent = true                       -- Indent wrapped lines visually
opt.backspace = { "indent", "eol", "start" } -- Fix backspace behavior

-- ============================================================================
-- 4. Search & Performance
-- ============================================================================
opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true  -- Case sensitive if uppercase is used
opt.incsearch = true  -- Show matches while typing
opt.hlsearch = true   -- Highlight matches
opt.updatetime = 100  -- Faster completion/updates
opt.timeoutlen = 500  -- Faster key sequence timeout
opt.lazyredraw = true -- Don't redraw while executing macros

-- ============================================================================
-- 5. System Integration
-- ============================================================================
opt.mouse = "a" -- Enable mouse in all modes

-- Note: 'encoding' is always utf-8 in Neovim and cannot be changed.
-- 'fileencoding' defaults to utf-8, but setting it explicitly is fine.
opt.fileencoding = "utf-8"

-- Use system clipboard
-- Note: Requires xclip/xsel (Linux) or pbcopy (macOS)
opt.clipboard = "unnamedplus"
-- ============================================================================
-- End of file
-- ============================================================================
