require("conform").setup({
    formatters_by_ft = {
        -- lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        -- python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        json = { "prettier" },
        jsonc = { "prettier" }, -- Prettier 原生支持带注释的 JSON
        -- Conform will run the first available formatter
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 999999999,
        lsp_fallback = true,
        lsp_format = "fallback",
    },
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
    require("conform").format({
        lsp_fallback = true, -- 如果没有专门的 formatter，回退到 LSP
        async = false,       -- 同步执行（通常更稳）
        timeout_ms = 9999999,
    })
end, { desc = "Format file or range (in visual mode)" })

vim.api.nvim_create_user_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
        }
    end
    require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })
