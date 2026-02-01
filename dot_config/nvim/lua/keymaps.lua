-- -----------------------------------------------------------------------------
--  Global Keymaps
--  Author:      jessun.pro@gmail.com
--  Description: Defines general keyboard shortcuts, window navigation, and system clipboard integration.
--  Location:    ~/.config/nvim/lua/keymaps.lua
-- -----------------------------------------------------------------------------
local keyset = vim.keymap.set
local function opts(text)
	return { silent = true, noremap = true, desc = text }
end

-- ============================================================================
-- 1. General File Operations
-- ============================================================================

-- Clear Search Highlights (Backspace)
-- Clears the highlighting of search terms until the next search.
keyset("n", "<BS>", function()
	pcall(vim.cmd.NoiceDismiss)
	pcall(vim.cmd.nohl)
end, opts("Nvim: no highlight"))

-- ============================================================================
-- 2. Navigation & Motions
-- ============================================================================

-- Window Navigation (Ctrl + h/j/k/l)
-- Move focus between splits without pressing Ctrl-w.
keyset("n", "<C-h>", "<C-w>h", opts("Nvim: windows jumping"))
keyset("n", "<C-j>", "<C-w>j", opts("Nvim: windows jumping"))
keyset("n", "<C-k>", "<C-w>k", opts("Nvim: windows jumping"))
keyset("n", "<C-l>", "<C-w>l", opts("Nvim: windows jumping"))

-- Buffer Switching (Alternate File)
-- Map '\' to toggle between the current and the last accessed buffer.
keyset("n", "\\", "<C-^>", opts("Nvim: siwtch to last buffer"))

-- Visual Motions
-- Move by visual lines (screen lines) instead of physical lines.
-- Useful when 'wrap' is enabled.
keyset("n", "j", "gj", opts("Nvim: gj"))
keyset("n", "k", "gk", opts("Nvim: gk"))

-- Search Centering
-- Keep the search result in the middle of the screen when jumping.
-- keyset("n", "n", "nzz", opts)
-- keyset("n", "N", "Nzz", opts)

-- ============================================================================
-- 3. Utilities
-- ============================================================================
-- Copy Current File Path
-- Gets the full path of the current file, copies it to the system clipboard,
-- and prints a confirmation message.
keyset("n", "<F12>", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("Copied path: " .. path)
end, opts("Nvim: copy path to clipboard"))

keyset({ "n", "i", "v" }, "<F1>", function()
	-- 1. 获取当前所有窗口的列表
	local wins = vim.api.nvim_list_wins()
	local help_win = nil

	-- 2. 遍历查找是否有窗口的 buftype 是 'help'
	for _, win in ipairs(wins) do
		local buf = vim.api.nvim_win_get_buf(win)
		-- 检查 buffer 的 buftype 属性
		if vim.api.nvim_get_option_value("buftype", { buf = buf }) == "help" then
			help_win = win
			break
		end
	end

	-- 3. 判断逻辑
	if help_win then
		-- A. 如果找到了帮助窗口，就关闭它
		vim.api.nvim_win_close(help_win, true)
	else
		-- B. 如果没找到，就执行默认的打开帮助命令
		vim.cmd("help")
	end
end, { desc = "Toggle Help Window" })
-- ============================================================================
-- End of file
-- ============================================================================
