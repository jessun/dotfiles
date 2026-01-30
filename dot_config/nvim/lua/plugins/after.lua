local set_hl = vim.api.nvim_set_hl
local nord = require("utils.nord_colors")

-- 0. 初始化
vim.cmd.color('nord')

-- ============================================================================
-- 1. Editor / Core (编辑器基础)
-- ============================================================================
local search_opts = {
    fg = nord.base.bg,
    bg = nord.accents.orange,
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

local kind_colors = {
    -- 代码逻辑类 (Cyan / Blue)
    Function      = nord.accents.cyan, -- Nord8 (冰蓝)
    Method        = nord.accents.cyan, -- Nord8
    Constructor   = nord.accents.blue, -- Nord9 (天蓝)

    -- 数据结构类 (Teal / Yellow)
    Class         = nord.accents.teal, -- Nord7 (蓝绿)
    Interface     = nord.accents.teal,
    Struct        = nord.accents.teal,
    Enum          = nord.accents.yellow, -- Nord13 (黄)
    EnumMember    = nord.accents.yellow,

    -- 变量与常量 (White / Orange)
    Variable      = nord.base.fg, -- Nord4 (白/普通)
    Field         = nord.base.fg,
    Property      = nord.base.fg,
    Constant      = nord.accents.orange, -- Nord12 (橙)

    -- 关键字与操作符 (Purple)
    Keyword       = nord.accents.purple, -- Nord15 (紫)
    Operator      = nord.accents.purple,
    TypeParameter = nord.accents.purple,

    -- 文本与文件 (Gray / Blue)
    Text          = nord.base.comment, -- Nord3 (灰)
    File          = nord.accents.blue,
    Folder        = nord.accents.blue,

    -- 片段 (Green)
    Snippet       = nord.accents.green, -- Nord14 (绿)

    -- 其他
    Event         = nord.accents.yellow,
    Module        = nord.accents.blue,
    Unit          = nord.accents.orange,
}

-- 2. 循环自动生成高亮组
--    生成格式: BlinkCmpKindFunction, BlinkCmpKindMethod ...
for kind, color in pairs(kind_colors) do
    set_hl(0, "BlinkCmpKind" .. kind, { fg = color, bg = "NONE" })
end

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
-- CmpNormal: 补全菜单的背景
set_hl(0, "CmpNormal", { bg = nord.base.comment, fg = nord.base.fg })
-- CmpBorder: 边框颜色
set_hl(0, "CmpBorder", { bg = nord.accents.blue })
-- CmpSel: 被选中的条目
set_hl(0, "CmpSel", { bg = nord.accents.orange, fg = nord.base.fg_highlight, bold = true })
-- 列表文字
set_hl(0, "CmpItemAbbr", { fg = nord.base.fg })
set_hl(0, "CmpItemAbbrDeprecated", { fg = nord.base.comment, strikethrough = true })
-- 幽灵文字
set_hl(0, "CmpGhostText", { fg = nord.base.comment, italic = true })
-- 匹配与来源
set_hl(0, "CmpItemAbbrMatch", { fg = nord.accents.cyan, bold = true })
set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = nord.accents.cyan, bold = true })
set_hl(0, "CmpItemMenu", { fg = nord.accents.blue, italic = true })

-- (可选) 文档悬浮窗的颜色，可以稍微浅一点区分
set_hl(0, "CmpDoc", { bg = nord.nord3, fg = nord.base.fg })
set_hl(0, "CmpDocBorder", { bg = nord.accents.blue })
-- 灰白色系：文本、变量
set_hl(0, "CmpItemKindVariable", { fg = nord.base.fg })
set_hl(0, "CmpItemKindText", { fg = nord.base.fg })

-- 蓝色系：函数、方法
set_hl(0, "CmpItemKindFunction", { fg = nord.accents.cyan })
set_hl(0, "CmpItemKindMethod", { fg = nord.accents.cyan })

-- 绿色系：字符串、类
set_hl(0, "CmpItemKindKeyword", { fg = nord.accents.blue })
set_hl(0, "CmpItemKindProperty", { fg = nord.accents.blue })
set_hl(0, "CmpItemKindUnit", { fg = nord.accents.blue })

-- 黄橙色系：类、结构体
set_hl(0, "CmpItemKindClass", { fg = nord.accents.yellow })
set_hl(0, "CmpItemKindStruct", { fg = nord.accents.yellow })
set_hl(0, "CmpItemKindInterface", { fg = nord.accents.yellow })

-- 红色系：片段 (Snippet)
set_hl(0, "CmpItemKindSnippet", { fg = nord.accents.red })

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
-- 9. jinh0/eyeliner.nvim
-- ============================================================================
set_hl(0, 'EyelinerPrimary', { bg = nord.accents.orange, fg = nord.base.fg_highlight })
set_hl(0, 'EyelinerSecondary', { bg = nord.accents.darkblue, fg = nord.base.fg_highlight, })
-- ============================================================================
-- End of file
-- ============================================================================
