-- -----------------------------------------------------------------------------
--  Auto Commands
--  Author:      jessun.pro@gmail.com
--  Description: Core editor automation (file management, UI behavior, cursor logic).
--  Location:    lua/autocmds.lua
-- -----------------------------------------------------------------------------

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Create a cleared group to avoid duplication on reload
local core_group = augroup("CoreAutoCmds", { clear = true })

-- ============================================================================
-- 1. File & Buffer Management
-- ============================================================================

-- Force check for external changes
-- Trigger `checktime` when gaining focus or switching buffers to keep files in sync.
autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    group = core_group,
    callback = function()
        if vim.fn.mode() ~= "c" then
            vim.cmd("checktime")
        end
    end,
})

-- Auto-create parent directories on save
-- If the directory structure doesn't exist, create it recursively before saving.
autocmd("BufWritePre", {
    group = core_group,
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- ============================================================================
-- 2. Cursor & View Logic
-- ============================================================================

-- Restore Cursor Position
-- Jump to the last known cursor position when reopening a file.
-- Logic:
-- 1. Mark exists and is valid (line > 1).
-- 2. Mark is within the current file boundaries.
-- 3. Filetype is NOT 'commit' (git messages should start at the top).
autocmd("BufReadPost", {
    group = core_group,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        local ft = vim.bo.filetype

        if mark[1] > 0 and mark[1] <= lcount and ft ~= "commit" then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- ============================================================================
-- 3. Smart Relative Line Numbers
-- ============================================================================

-- Enable relative numbers when entering Normal mode or gaining focus.
-- Checks if 'number' is enabled first to avoid affecting special buffers (like Help).
autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
    group = core_group,
    callback = function()
        if vim.opt.number:get() and vim.fn.mode() ~= "i" then
            vim.opt.relativenumber = true
        end
    end,
})

-- Switch to absolute numbers when entering Insert mode or losing focus.
autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
    group = core_group,
    callback = function()
        if vim.opt.number:get() then
            vim.opt.relativenumber = false
        end
    end,
})

-- ============================================================================
-- 4. Window & Layout Behavior
-- ============================================================================

-- Automatically rebalance window splits when the host terminal is resized.
autocmd("VimResized", {
    group = core_group,
    command = "wincmd =",
})

-- Force help documentation to open in a vertical split (right side).
-- Optimized for modern wide-screen displays.
autocmd("FileType", {
    group = core_group,
    pattern = "help",
    command = "wincmd L",
})

-- Map 'q' to close ephemeral buffers immediately.
-- Applies to: Help, QuickFix, Netrw, Man pages.
autocmd("FileType", {
    group = core_group,
    pattern = { "help", "qf", "netrw", "man" },
    callback = function(event)
        vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
    end,
})

autocmd("FileType", {
    pattern = "jsonc",
    callback = function()
        vim.bo.expandtab = true
    end,
})

autocmd("FileType", {
    pattern = "gitcommit",
    callback = function()
        vim.opt_local.colorcolumn = "50"
    end,
})

-- ============================================================================
-- End of file
-- ============================================================================
