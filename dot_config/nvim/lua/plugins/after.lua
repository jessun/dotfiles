vim.cmd.color('nord')

-- Nord color =================================================================
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

local set_hl = vim.api.nvim_set_hl
set_hl(0, "Search", search_opts)
set_hl(0, "IncSearch", search_opts)
set_hl(0, "NormalFloat", { bg = "#4c566a" })
set_hl(0, 'Pmenu', { bg = "#4C566A", fg = "#D8DEE9" })
set_hl(0, 'PmenuSbar', { bg = "#D8DEE9" })
set_hl(0, 'PmenuSel', { bg = "#D08770", fg = "#ECEFF4", bold = true })
set_hl(0, 'PmenuThumb', { bg = "#D8DEE9" })
set_hl(0, "CocMenuSel", { link = "PmenuSel" }) -- IMPORTANT:only works here
--=============================================================================

-- NeoTree ====================================================================
local set_hl = vim.api.nvim_set_hl
set_hl(0, "NeoTreeDirectoryName", { fg = "#88c0d0", bold = true })
--=============================================================================

local set_hl = vim.api.nvim_set_hl

-- 定义 Nord 调色板 (方便后期微调)
local nord = {
    dark_bg      = "#2E3440", -- Nord0: 极深背景
    menu_bg      = "#4C566A", -- Nord1: 菜单背景 (比编辑器背景稍亮)
    selection_bg = "#D08770", -- Nord3: 选中项背景 (明显的橙色)
    comment      = "#4C566A", -- Nord3: 幽灵文字/注释
    text_main    = "#D8DEE9", -- Nord4: 主文字
    text_bright  = "#ECEFF4", -- Nord6: 高亮文字
    cyan         = "#88C0D0", -- Nord8: 匹配字符 (冰蓝)
    blue         = "#81A1C1", -- Nord9: 边框/滑块 (天蓝)
}

-- 1. 菜单背景
-- 使用 Nord1 让菜单从 Nord0 的编辑器背景中浮现出来
set_hl(0, "BlinkCmpMenu", { fg = nord.text_main, bg = nord.menu_bg })
-- 2. 选中项
-- 经典的 Nord 选中风格：灰色背景 + 雪白文字 + 加粗
set_hl(0, "BlinkCmpMenuSelection", { fg = nord.text_bright, bg = nord.selection_bg, bold = true })
-- 3. 匹配字符
-- 使用标志性的 Nord8 冰蓝色，非常醒目
set_hl(0, "BlinkCmpLabelMatch", { fg = nord.cyan, bold = true })
-- 4. 幽灵文字
-- 模拟注释的颜色，低调不抢眼
set_hl(0, "BlinkCmpGhostText", { fg = nord.comment, italic = true })

-- 5. 文档窗口
-- 保持与菜单一致
set_hl(0, "BlinkCmpDoc", { fg = nord.text_main, bg = nord.menu_bg })
-- 边框使用 Nord9 天蓝色，增加一点精致感
set_hl(0, "BlinkCmpDocBorder", { fg = nord.blue, bg = nord.menu_bg })
-- 6. (附赠) 滚动条设置 - 保持风格统一
set_hl(0, "BlinkCmpScrollBarThumb", { bg = nord.blue })
set_hl(0, "BlinkCmpScrollBarGutter", { bg = nord.menu_bg })
