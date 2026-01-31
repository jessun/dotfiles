return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "VeryLazy",
    init = function()
        vim.o.foldcolumn = '0' -- '0' is not bad
        vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
    end,
    keys = {
        { "zR", function() require('ufo').openAllFolds() end,         mode = "n", desc = "UFO: open all folds" },
        { "zM", function() require('ufo').closeAllFolds() end,        mode = "n", desc = "UFO: close all folds" },
        { "zr", function() require('ufo').openFoldsExceptKinds() end, mode = "n", desc = "UFO: open folds except kinds" },
        { "zm", function() require('ufo').closeFoldsWith() end,       mode = "n", desc = "UFO: close folds with" },
        {
            "<leader>k",
            function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                if not winid then
                    if vim.g.enable_coc then
                        vim.fn.CocActionAsync('definitionHover') -- coc.nvim
                    end
                    if vim.g.enable_native_lsp then
                        vim.lsp.buf.hover()
                    end
                end
            end
            ,
            mode = { "n" },
            desc = "UFO: show all code or document"
        },
    },
    opts = {
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
    },
}
