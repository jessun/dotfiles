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
set_hl(0, "CocMenuSel", { link = "PmenuSel" })
set_hl(0, "NormalFloat", { bg = "#4c566a" })
set_hl(0, 'Pmenu', { bg = "#4C566A", fg = "#D8DEE9" })
set_hl(0, 'PmenuSbar', { bg = "#D8DEE9" })
set_hl(0, 'PmenuSel', { bg = "#D08770", fg = "#ECEFF4", bold = true })
set_hl(0, 'PmenuThumb', { bg = "#D8DEE9" })
--=============================================================================

-- NeoTree ====================================================================
local set_hl = vim.api.nvim_set_hl
set_hl(0, "NeoTreeDirectoryName", { fg = "#88c0d0", bold = true })
--=============================================================================

-- theme ====================================================================
require('lspconfig.ui.windows').default_options.border = "single"
vim.diagnostic.config({
    float = { border = "single" },
    virtual_text = false,
    virtual_lines = nil,
})
--=============================================================================
