local set_hl = vim.api.nvim_set_hl
local nord = require("utils.nord_colors")

-- 0. 初始化
vim.cmd.color('nord')

-- ============================================================================
-- 1. Editor / Core (编辑器基础)
-- ============================================================================
local search_opts = {
    fg = nord.base.comment,
    bg = nord.base.fg_highlight,
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
set_hl(0, "NeoTreeDirectoryName", { fg = nord.accents.cyan, bold = true })

-- ============================================================================
-- 3. Blink.cmp (Blink 专用配置)
-- ============================================================================
-- 菜单与文档背景
set_hl(0, "BlinkCmpMenu", { fg = nord.base.fg, bg = nord.nord3 })
set_hl(0, "BlinkCmpDoc", { fg = nord.base.fg, bg = nord.nord3 })

-- 选中项 (橙色高亮)
set_hl(0, "BlinkCmpMenuSelection", {
    fg = nord.base.fg_highlight,
    bg = nord.accents.orange,
    bold = true
})

-- 细节元素
set_hl(0, "BlinkCmpLabelMatch", { fg = nord.accents.cyan, bold = true })    -- 匹配字
set_hl(0, "BlinkCmpGhostText", { fg = nord.base.comment, italic = true })   -- 幽灵文字
set_hl(0, "BlinkCmpDocBorder", { fg = nord.accents.blue, bg = nord.nord3 }) -- 边框

-- 滚动条
set_hl(0, "BlinkCmpScrollBarThumb", { bg = nord.accents.blue })
set_hl(0, "BlinkCmpScrollBarGutter", { bg = nord.nord3 })

-- ============================================================================
-- 4. Pmenu (全局菜单 / 原生菜单)
-- ============================================================================
set_hl(0, "Pmenu", { fg = nord.base.fg, bg = nord.nord3 })
set_hl(0, "PmenuSel", {
    fg = nord.base.fg_highlight,
    bg = nord.accents.orange,
    bold = true
})
set_hl(0, "PmenuSbar", { bg = nord.nord3 })
set_hl(0, "PmenuThumb", { bg = nord.accents.blue })

-- ============================================================================
-- 5. nvim-cmp (Cmp 专用配置)
-- ============================================================================
-- 列表文字
set_hl(0, "CmpItemAbbr", { fg = nord.base.fg })
set_hl(0, "CmpItemAbbrDeprecated", { fg = nord.base.comment, strikethrough = true })

-- 匹配与来源
set_hl(0, "CmpItemAbbrMatch", { fg = nord.accents.cyan, bold = true })
set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = nord.accents.cyan, bold = true })
set_hl(0, "CmpItemMenu", { fg = nord.accents.blue, italic = true })

-- 幽灵文字
set_hl(0, "CmpGhostText", { fg = nord.base.comment, italic = true })

-- ============================================================================
-- 6. coc.nvim
-- ============================================================================
set_hl(0, "CocHighlightText", { bg = nord.accents.orange, fg = nord.base.bg })
set_hl(0, "CocErrorHighlight", { bg = nord.diagnostic.error, fg = nord.base.bg })
set_hl(0, "CocWarnHighlight", { bg = nord.diagnostic.warn, fg = nord.base.bg })
set_hl(0, "CocInfoHighlight", { bg = nord.diagnostic.info, fg = nord.base.bg })
set_hl(0, "CocHintHighlight", { bg = nord.diagnostic.hint, fg = nord.base.bg })

-- ============================================================================
-- 7. Native LSP (原生悬浮窗)
-- ============================================================================
set_hl(0, "NormalFloat", { fg = nord.base.fg, bg = nord.nord3 })
set_hl(0, "FloatBorder", { fg = nord.accents.blue, bg = nord.nord3 })
set_hl(0, "FloatTitle", { fg = nord.accents.cyan, bg = nord.nord3, bold = true })

-- ============================================================================
-- 8. Diagnostics (诊断信息)
-- ============================================================================
local diagnostics = {
    Error = nord.diagnostic.error,
    Warn  = nord.diagnostic.warn,
    Info  = nord.diagnostic.info,
    Hint  = nord.diagnostic.hint,
}

for type, color in pairs(diagnostics) do
    set_hl(0, "Diagnostic" .. type, { fg = color })
    set_hl(0, "DiagnosticSign" .. type, { fg = color })
    set_hl(0, "DiagnosticUnderline" .. type, { sp = color, undercurl = true })
end
-- ============================================================================
-- End of file
-- ============================================================================
