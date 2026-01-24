-- -----------------------------------------------------------------------------
--  Global Keymaps
--  Author:      jessun.pro@gmail.com
--  Description: Defines general keyboard shortcuts, window navigation, and system clipboard integration.
--  Location:    ~/.config/nvim/lua/keymaps.lua
-- -----------------------------------------------------------------------------

local map = vim.keymap.set
local opts = { silent = true, noremap = true }

-- ============================================================================
-- 1. General File Operations
-- ============================================================================

-- Fast Save (<Space>w)
map("n", "<leader>w", "<cmd>w<CR>", opts)

-- Clear Search Highlights (Backspace)
-- Clears the highlighting of search terms until the next search.
map("n", "<BS>", "<cmd>nohlsearch<CR>", opts)

-- ============================================================================
-- 2. Navigation & Motions
-- ============================================================================

-- Window Navigation (Ctrl + h/j/k/l)
-- Move focus between splits without pressing Ctrl-w.
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Buffer Switching (Alternate File)
-- Map '\' to toggle between the current and the last accessed buffer.
map("n", "\\", "<C-^>", opts)

-- Visual Motions
-- Move by visual lines (screen lines) instead of physical lines.
-- Useful when 'wrap' is enabled.
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- Search Centering
-- Keep the search result in the middle of the screen when jumping.
-- map("n", "n", "nzz", opts)
-- map("n", "N", "Nzz", opts)

-- ============================================================================
-- 3. Clipboard Integration
-- ============================================================================
-- Sync with System Clipboard using <Space>y and <Space>p
-- Requires 'clipboard' option (xclip/pbcopy) to be set in options.lua.

-- Copy to system clipboard
map({ "n", "v" }, "<leader>y", "\"+y", opts)

-- Paste from system clipboard
map({ "n", "v" }, "<leader>p", "\"+p", opts)

-- ============================================================================
-- 4. Utilities
-- ============================================================================

-- F2: Copy Current File Path
-- Gets the full path of the current file, copies it to the system clipboard,
-- and prints a confirmation message.
map("n", "<F2>", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    print("Copied path: " .. path)
end, opts)
-- ============================================================================
-- End of file
-- ============================================================================
