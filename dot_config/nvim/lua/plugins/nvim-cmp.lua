local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = {
            border = "solid",
            scrollbar = true,
            winhighlight = "FloatBorder:CmpBorder",
        },
        documentation = {
            border = "solid",
            scrollbar = true,
            winhighlight = "FloatBorder:CmpBorder",
        },
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(), -- 上一个
        ['<C-n>'] = cmp.mapping.select_next_item(), -- 下一个
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),    -- 文档向上翻页
        ['<C-f>'] = cmp.mapping.scroll_docs(4),     -- 文档向下翻页
        ['<C-Space>'] = cmp.mapping.complete(),     -- 手动触发补全
        ['<C-e>'] = cmp.mapping.abort(),            -- 关闭补全窗口

        -- 回车确认：支持自动导入
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        -- Super Tab 模式：Tab 选择下一个，或者跳转代码片段
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' }, -- 最高优先级：LSP 建议
        { name = 'path' },     -- 路径
        { name = "lazydev" },
    }, {
        { name = 'buffer' },  -- Buffer 内单词
        { name = 'luasnip' }, -- 代码片段
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua' },
        {
            name = "dictionary",
            keyword_length = 2,
        },
        {
            name = 'tags',
            option = {
                -- this is the default options, change them if you want.
                -- Delayed time after user input, in milliseconds.
                complete_defer = 100,
                -- Max items when searching `taglist`.
                max_items = 10,
                -- The number of characters that need to be typed to trigger
                -- auto-completion.
                keyword_length = 4,
                -- Use exact word match when searching `taglist`, for better searching
                -- performance.
                exact_match = false,
                -- Prioritize searching result for current buffer.
                current_buffer_only = false,
            },
        },
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
        }),
        sorting = {
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.score,
                require "cmp-under-comparator".under,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        }, }
}

-- `/` cmdline setup.
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'nvim_lsp_document_symbol' }
    }, {
        { name = 'buffer' }
    })
})
-- `:` cmdline setup.
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        {
            name = 'cmdline',
            option = {
                ignore_cmds = { 'Man', '!' }
            }
        }
    })
})

require("cmp_dictionary").setup({
    paths = {
        "/usr/share/dict/words",
        "~/.config/nvim/dicts/personal"
    },
    exact_length = 2,
})
-- ============================================================================
-- End of file
-- ============================================================================
