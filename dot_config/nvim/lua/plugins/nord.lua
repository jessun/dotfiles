-- 1. 创建 augroup (对应 augroup NordSearchFix 和 autocmd!)
-- clear = true 会自动清除组内旧的命令，无需手动写 autocmd!
vim.cmd.color('nord')
-- 定义高亮配置表 (复用配置以保持代码整洁)
local search_opts = {
    fg = "#4c566a",   -- 对应 guifg
    bg = "#ECEFF4",   -- 对应 guibg
    bold = true,      -- 对应 gui=bold
    nocombine = true, -- 对应 gui=nocombine (关键！防止颜色混合)

    -- 终端兼容配置 (cterm)
    ctermfg = 240,                            -- 对应 ctermfg
    ctermbg = 254,                            -- 对应 ctermbg
    cterm = { bold = true, nocombine = true } -- 对应 cterm=bold,nocombine
}

local set_hl = vim.api.nvim_create_autocmd

-- 应用高亮设置
-- 参数 0 表示全局命名空间
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*", -- 针对所有配色方案
    callback = function()
        -- 1. 设置【目录/文件夹】的颜色
        -- 这里的 fg 可以是具体的十六进制颜色，也可以是配色方案里的组名
        set_hl(0, "NeoTreeDirectoryName", { fg = "#88c0d0", bold = true }) -- 比如设置为淡蓝色
        set_hl(0, "NeoTreeDirectoryIcon", { fg = "#88c0d0" })              -- 文件夹图标颜色

        -- 2. 设置【普通文件】的颜色
        set_hl(0, "NeoTreeFileName", { fg = "#D8DEE9" }) -- 比如设置为灰白色
        -- 注意：NeoTreeFileIcon 通常由 nvim-web-devicons 控制，这里改它可能无效，除非你禁用 devicons

        -- 3. (可选) 如果你希望 Git 状态（如修改、新增）不要影响文件颜色，
        --    你可以把 Git 相关的组也强制改成和普通文件一样（不推荐，会失去状态提示）
        -- set_hl(0, "NeoTreeGitModified", { link = "NeoTreeFileName" })
        -- set_hl(0, "NeoTreeGitUntracked", { link = "NeoTreeFileName" })
        -- set_hl(0, "CmpBorder", { bg = "NONE", fg = "#D8DEE9" })
        set_hl(0, "NormalFloat", { bg = "#4c566a" }) -- 如果你想让浮动窗透明
        -- 设置补全菜单背景色 (深灰色背景，灰白色文字)
        set_hl(0, 'Pmenu', { bg = "#4c566a", fg = "#D8DEE9" })
        -- 设置选中项颜色 (深蓝色背景，白色文字，加粗)
        set_hl(0, 'PmenuSel', { bg = "#b48ead", fg = "#D8DEE9", bold = true })
        -- (可选) 滚动条颜色
        set_hl(0, 'PmenuSbar', { bg = "#4c566a" })
        set_hl(0, 'PmenuThumb', { bg = "#4c566a" })

        -- search
        set_hl(0, "Search", search_opts)
        set_hl(0, "IncSearch", search_opts)
    end,
})
