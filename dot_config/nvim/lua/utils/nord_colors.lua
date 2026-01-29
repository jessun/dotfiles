-- lua/config/nord_colors.lua

local M      = {}

-- ============================================================================
-- 1. 标准 Nord 调色板 (Official Palette)
-- ============================================================================

-- Polar Night (极夜：背景色)
-- 用于背景、状态栏、面板等深色区域
M.nord0      = "#2e3440" -- 最深背景
M.nord1      = "#3b4252" -- 较深背景 (常用于 UI 元素背景)
M.nord2      = "#434c5e" -- 选中/高亮背景
M.nord3      = "#4c566a" -- 灰色 (常用于注释、幽灵文字)

-- Snow Storm (雪风：前景色)
-- 用于正文文字
M.nord4      = "#d8dee9" -- 主文字 (Main Text)
M.nord5      = "#e5e9f0" -- 亮文字
M.nord6      = "#eceff4" -- 最亮/高亮文字

-- Frost (霜冻：核心冷色调)
-- 用于函数、关键字、类名等代码高亮
M.nord7      = "#8fbcbb" -- 蓝绿色 (Teal)
M.nord8      = "#88c0d0" -- 冰青色 (Cyan) - 极具辨识度的 Nord 标志色
M.nord9      = "#81a1c1" -- 天蓝色 (Blue)
M.nord10     = "#5e81ac" -- 深蓝色 (Dark Blue)

-- Aurora (极光：暖色调/强调色)
-- 用于错误、警告、字符串、数字等
M.nord11     = "#bf616a" -- 红色 (Red) - 错误
M.nord12     = "#d08770" -- 橙色 (Orange)
M.nord13     = "#ebcb8b" -- 黄色 (Yellow) - 警告/字符串
M.nord14     = "#a3be8c" -- 绿色 (Green) - 字符串/成功
M.nord15     = "#b48ead" -- 紫色 (Purple)

-- ============================================================================
-- 2. 语义化别名 (Semantic Alias)
-- ============================================================================
-- 让你在写配置时不用去想 "nord11 是红色还是橙色？"

M.base       = {
    bg           = M.nord0, -- 编辑器背景
    bg_highlight = M.nord1, -- 菜单背景
    bg_selection = M.nord2, -- 选中背景
    comment      = M.nord3, -- 注释
    fg           = M.nord4, -- 默认文字
    fg_highlight = M.nord6, -- 高亮文字
}

M.accents    = {
    cyan     = M.nord8,
    blue     = M.nord9,
    darkblue = M.nord10,
    teal     = M.nord7,
    red      = M.nord11,
    orange   = M.nord12,
    yellow   = M.nord13,
    green    = M.nord14,
    purple   = M.nord15,
}

M.Diagnostic = {
    error = M.accents.red,
    warn = M.accents.yellow,
    info = M.accents.cyan,
    hint = M.accents.purple,
}

return M
