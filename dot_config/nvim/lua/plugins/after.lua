vim.api.nvim_set_hl(0, "CmpBorder", { bg = "NONE", fg = "NONE" })
-- vim.api.nvim_set_hl(0, "CmpBorder", { bg = "NONE", fg = "#D8DEE9" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#4c566a" }) -- 如果你想让浮动窗透明
-- 设置补全菜单背景色 (深灰色背景，灰白色文字)
vim.api.nvim_set_hl(0, 'Pmenu', { bg = "#4c566a", fg = "#D8DEE9" })
-- 设置选中项颜色 (深蓝色背景，白色文字，加粗)
vim.api.nvim_set_hl(0, 'PmenuSel', { bg = "#b48ead", fg = "#D8DEE9", bold = true })
-- (可选) 滚动条颜色
vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = "#D8DEE9" })
vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = "#D8DEE9" })
