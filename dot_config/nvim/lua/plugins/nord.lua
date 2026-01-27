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

-- 应用高亮设置
-- 参数 0 表示全局命名空间
vim.api.nvim_set_hl(0, "Search", search_opts)
vim.api.nvim_set_hl(0, "IncSearch", search_opts)
