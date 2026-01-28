vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*", -- 针对所有配色方案
    callback = function()
        -- 1. 设置【目录/文件夹】的颜色
        -- 这里的 fg 可以是具体的十六进制颜色，也可以是配色方案里的组名
        vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#8fbcbb", bold = true }) -- 比如设置为淡蓝色
        vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#8fbcbb" })              -- 文件夹图标颜色

        -- 2. 设置【普通文件】的颜色
        vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#D8DEE9" }) -- 比如设置为灰白色
        -- 注意：NeoTreeFileIcon 通常由 nvim-web-devicons 控制，这里改它可能无效，除非你禁用 devicons

        -- 3. (可选) 如果你希望 Git 状态（如修改、新增）不要影响文件颜色，
        --    你可以把 Git 相关的组也强制改成和普通文件一样（不推荐，会失去状态提示）
        -- vim.api.nvim_set_hl(0, "NeoTreeGitModified", { link = "NeoTreeFileName" })
        -- vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { link = "NeoTreeFileName" })
        -- vim.api.nvim_set_hl(0, "CmpBorder", { bg = "NONE", fg = "#D8DEE9" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#4c566a" }) -- 如果你想让浮动窗透明
        -- 设置补全菜单背景色 (深灰色背景，灰白色文字)
        vim.api.nvim_set_hl(0, 'Pmenu', { bg = "#4c566a", fg = "#D8DEE9" })
        -- 设置选中项颜色 (深蓝色背景，白色文字，加粗)
        vim.api.nvim_set_hl(0, 'PmenuSel', { bg = "#b48ead", fg = "#D8DEE9", bold = true })
        -- (可选) 滚动条颜色
        vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = "#4c566a" })
        vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = "#4c566a" })
    end,
})
