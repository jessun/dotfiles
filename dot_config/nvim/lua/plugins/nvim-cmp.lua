local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = {
            border = "none",
            scrollbar = true,
            winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None",
        },
        documentation = {
            border = "none",
            scrollbar = true,
            winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder,CursorLine:CmpSel,Search:None",
        },
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- 文档向上翻页
        ['<C-f>'] = cmp.mapping.scroll_docs(4),  -- 文档向下翻页
        ['<C-Space>'] = cmp.mapping.complete(),  -- 手动触发补全
        ['<C-e>'] = cmp.mapping.abort(),         -- 关闭补全窗口

        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                -- 这里也要加上 behavior = cmp.SelectBehavior.Select
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            elseif require('luasnip').expand_or_jumpable() then
                require('luasnip').expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            elseif require('luasnip').jumpable(-1) then
                require('luasnip').jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),

    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp',                priority = 1000 }, -- 最高优先级：LSP 建议
        { name = 'nvim_lsp_signature_help', priority = 900 },
        { name = 'path',                    priority = 700 },  -- 路径
        { name = 'buffer',                  priority = 600 },  -- Buffer 内单词
        { name = "lazydev",                 priority = 500 },
        { name = 'luasnip',                 priority = 300 },  -- 代码片段
    }, {
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
                exact_match = true,
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
        },
    }
})

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

-- ============================================================================
-- End of file
-- ============================================================================
