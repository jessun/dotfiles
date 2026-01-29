local set_hl = vim.api.nvim_set_hl
local colors = require("utils.nord_colors")

-- 0. 初始化
vim.cmd.color('nord')

-- ============================================================================
-- 1. Editor / Core (编辑器基础)
-- ============================================================================
local search_opts = {
    fg = colors.base.comment,
    bg = colors.base.fg_highlight,
    bold = true,
    nocombine = true,
    ctermfg = 240,
    ctermbg = 254,
    cterm = { bold = true, nocombine = true }
}
set_hl(0, "Search", search_opts)
set_hl(0, "IncSearch", search_opts)

-- ============================================================================
-- 2. NeoTree
-- ============================================================================
-- #88c0d0 -> colors.accents.cyan
set_hl(0, "NeoTreeDirectoryName", { fg = colors.accents.cyan, bold = true })

-- ============================================================================
-- 3. Blink.cmp (Blink 专用配置)
-- ============================================================================
-- 菜单与文档背景
set_hl(0, "BlinkCmpMenu", { fg = colors.base.fg, bg = colors.nord3 })
set_hl(0, "BlinkCmpDoc", { fg = colors.base.fg, bg = colors.nord3 })

-- 选中项 (橙色高亮)
set_hl(0, "BlinkCmpMenuSelection", {
    fg = colors.base.fg_highlight,
    bg = colors.accents.orange,
    bold = true
})

-- 细节元素
set_hl(0, "BlinkCmpLabelMatch", { fg = colors.accents.cyan, bold = true })      -- 匹配字
set_hl(0, "BlinkCmpGhostText", { fg = colors.base.comment, italic = true })     -- 幽灵文字
set_hl(0, "BlinkCmpDocBorder", { fg = colors.accents.blue, bg = colors.nord3 }) -- 边框

-- 滚动条
set_hl(0, "BlinkCmpScrollBarThumb", { bg = colors.accents.blue })
set_hl(0, "BlinkCmpScrollBarGutter", { bg = colors.nord3 })

-- ============================================================================
-- 4. Pmenu (全局菜单 / 原生菜单)
-- ============================================================================
set_hl(0, "Pmenu", { fg = colors.base.fg, bg = colors.nord3 })
set_hl(0, "PmenuSel", {
    fg = colors.base.fg_highlight,
    bg = colors.accents.orange,
    bold = true
})
set_hl(0, "PmenuSbar", { bg = colors.nord3 })
set_hl(0, "PmenuThumb", { bg = colors.accents.blue })

-- ============================================================================
-- 5. nvim-cmp (Cmp 专用配置)
-- ============================================================================
-- 列表文字
set_hl(0, "CmpItemAbbr", { fg = colors.base.fg })
set_hl(0, "CmpItemAbbrDeprecated", { fg = colors.base.comment, strikethrough = true })

-- 匹配与来源
set_hl(0, "CmpItemAbbrMatch", { fg = colors.accents.cyan, bold = true })
set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = colors.accents.cyan, bold = true })
set_hl(0, "CmpItemMenu", { fg = colors.accents.blue, italic = true })

-- 幽灵文字
set_hl(0, "CmpGhostText", { fg = colors.base.comment, italic = true })

-- ============================================================================
-- 6. Native LSP (原生悬浮窗)
-- ============================================================================
set_hl(0, "NormalFloat", { fg = colors.base.fg, bg = colors.nord3 })
set_hl(0, "FloatBorder", { fg = colors.accents.blue, bg = colors.nord3 })
set_hl(0, "FloatTitle", { fg = colors.accents.cyan, bg = colors.nord3, bold = true })

-- ============================================================================
-- 7. Diagnostics (诊断信息)
-- ============================================================================
local diagnostics = {
    Error = colors.accents.red,
    Warn  = colors.accents.yellow,
    Info  = colors.accents.cyan,
    Hint  = colors.accents.purple,
}

for type, color in pairs(diagnostics) do
    set_hl(0, "Diagnostic" .. type, { fg = color })
    set_hl(0, "DiagnosticSign" .. type, { fg = color })
    set_hl(0, "DiagnosticUnderline" .. type, { sp = color, undercurl = true })
end
