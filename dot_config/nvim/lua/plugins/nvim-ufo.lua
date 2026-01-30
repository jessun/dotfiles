local ufo = require('ufo')
ufo.setup {
    -- 使用 Treesitter 和 LSP 作为折叠提供源
    provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
    end,
    preview = {
        win_config = {
            winblend = 0
        },
        mappings = {
            scrollU = '<C-b>',
            scrollD = '<C-f>',
            jumpTop = '[',
            jumpBot = ']'
        }
    },
}

local map = vim.keymap.set
map('n', 'zR', ufo.openAllFolds)
map('n', 'zM', ufo.closeAllFolds)
map('n', 'zr', ufo.openFoldsExceptKinds)
map('n', 'zm', ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
map('n', '<leader>k', function()
    local winid = ufo.peekFoldedLinesUnderCursor()
    if not winid then
        -- choose one of coc.nvim and nvim lsp
        -- vim.fn.CocActionAsync('definitionHover') -- coc.nvim
        vim.lsp.buf.hover()
    end
end)
