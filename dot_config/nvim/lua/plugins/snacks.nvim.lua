require("snacks").setup({
    -- dashboard = { enabled = true },
    -- explorer = { enabled = true },
    -- indent = { enabled = true },
    -- input = { enabled = true },
    -- notifier = {
    --     enabled = true,
    --     timeout = 3000,
    -- },
    -- picker = { enabled = true },
    -- quickfile = { enabled = false },
    -- scope = { enabled = true },
    scroll = { enabled = true },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },
    -- styles = {
    --     notification = {
    --         -- wo = { wrap = true } -- Wrap notifications
    --     }
    -- }
    bigfile = {
        enabled = true,
        notify = true,            -- show notification when big file detected
        size = 1.5 * 1024 * 1024, -- 1.5MB
        line_length = 1000,       -- average line length (useful for minified files)
        -- Enable or disable features when big file detected
        ---@param ctx {buf: number, ft:string}
        setup = function(ctx)
            -- 1. 关闭 Indent Blankline (indent_blankline)
            -- 针对 ibl v3+
            vim.b[ctx.buf].ibl_enabled = false
            -- 针对旧版 indent_blankline
            vim.b[ctx.buf].indent_blankline_enabled = false

            -- 2. 关闭 Illuminate (illuminate)
            vim.b[ctx.buf].illuminate_disable = true

            -- 3. 关闭 LSP (lsp)
            -- 禁用当前 buffer 的诊断
            vim.diagnostic.enable(false, { bufnr = ctx.buf })
            -- 阻止 LSP 附加通常由 filetype="" 实现，但如果已附加，可以在此尝试停止
            -- (通常 snacks 在 LSP 启动前运行，所以下面的 syntax/filetype 设置更关键)

            -- 4. 关闭 Treesitter (treesitter)
            -- 停止当前 buffer 的 treesitter 高亮
            pcall(vim.treesitter.stop, ctx.buf)
            -- 禁用 fold (如果是基于 treesitter 的)
            vim.opt_local.foldmethod = "manual"

            -- 5. 关闭 Syntax (syntax)
            vim.cmd("syntax off")
            vim.bo[ctx.buf].syntax = ""

            -- 6. 关闭 MatchParen (matchparen)
            -- 清空匹配对，使 % 跳转和高亮失效
            vim.opt_local.matchpairs = ""

            -- 7. 关闭 Vimopts (vimopts - 性能相关选项)
            vim.opt_local.swapfile = false
            vim.opt_local.undofile = false
            vim.opt_local.cursorline = false
            vim.opt_local.cursorcolumn = false
            vim.opt_local.colorcolumn = ""
            vim.opt_local.list = false -- 关闭隐藏字符显示
            vim.opt_local.wrap = false -- (可选) 关闭自动换行通常能显著提升性能

            -- 8. 关闭 Filetype (filetype)
            -- 将文件类型设为空，这会阻止绝大多数基于 ft 的插件 (如 LSP, formatters, linters) 启动
            vim.bo[ctx.buf].filetype = ""
        end,

    },
})
