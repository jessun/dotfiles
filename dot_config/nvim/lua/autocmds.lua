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

local enable_auto_diag = false
vim.api.nvim_create_autocmd("CursorHold", {
	group = vim.api.nvim_create_augroup("AutoDiagnosticFloat", { clear = true }),
	callback = function()
		if not enable_auto_diag then
			return
		end

		local opts = {
			focusable = false, -- 极其重要：防止光标跳到悬浮窗里
			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
			border = "solid", -- 保持你喜欢的 solid 边框
			source = "always",
			prefix = " ",
			scope = "cursor",
		}
		-- 只有当当前位置有错误时才尝试显示，避免无意义的调用
		if #vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 }) > 0 then
			vim.diagnostic.open_float(nil, opts)
		end
	end,
})

-- 3. 创建切换开关的快捷键
-- 这里绑定到 <leader>td (Toggle Diagnostics)
vim.keymap.set("n", "<F7>", function()
	enable_auto_diag = not enable_auto_diag

	if enable_auto_diag then
		vim.notify("LSP float diagnostic show", vim.log.levels.INFO)
		-- 开启时立即触发一次，不用等下一次移动
		vim.cmd("doautocmd CursorHold")
	else
		vim.notify("LSP float diagnostic hide", vim.log.levels.WARN)
	end
end, { desc = "Toggle Auto Diagnostic Float" })
-- ============================================================================
-- End of file
-- ============================================================================
