local blink = require('blink.cmp')
blink.setup({
    keymap = { preset = 'default' },

    appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
    },

    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = true } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
        default = {
            'lsp', 'path', 'snippets', 'buffer', -- default
            'tags',
            'lazydev',
            'avante',
            'git',
            'conventional_commits',
            'env',
            "tmux",
            'latex',
            -- 'dictionary',
        },
        providers = {
            nvim_lsp_document_symbol = {
                name = 'nvim_lsp_document_symbol',
                module = 'blink.compat.source',
                score_offset = 3, -- 提高搜索时的优先级
            },
            latex = {
                name = "Latex",
                module = "blink-cmp-latex",
                opts = {
                    -- set to true to insert the latex command instead of the symbol
                    insert_command = false
                },
            },
            tmux = {
                module = "blink-cmp-tmux",
                name = "tmux",
                -- default options
                opts = {
                    all_panes = false,
                    capture_history = false,
                    -- only suggest completions from `tmux` if the `trigger_chars` are
                    -- used
                    triggered_only = false,
                    trigger_chars = { "." }
                },
            },
            env = {
                name = "Env",
                module = "blink-cmp-env",
                --- @type blink-cmp-env.Options
                opts = {
                    item_kind = require("blink.cmp.types").CompletionItemKind.Variable,
                    show_braces = false,
                    show_documentation_window = true,
                },
            },
            conventional_commits = {
                name = 'Conventional Commits',
                module = 'blink-cmp-conventional-commits',
                enabled = function()
                    return vim.bo.filetype == 'gitcommit'
                end,
                ---@module 'blink-cmp-conventional-commits'
                ---@type blink-cmp-conventional-commits.Options
                opts = {}, -- none so far
            },
            nvim_lsp_document_symbol = {
                -- 插件注册的源名称 (必须完全匹配)
                name = 'nvim_lsp_document_symbol',
                -- 使用兼容层加载
                module = 'blink.compat.source',
                -- (可选) 调高优先级，让它在搜索时排在前面
                score_offset = 3,
            },
            lazydev = {
                name = 'lazydev',
                module = 'blink.compat.source',
            },
            dictionary = {
                name = 'dictionary',
                module = 'blink.compat.source',
                -- (可选) 调低优先级，防止它干扰 LSP 补全
                score_offset = -3,
            },
            tags = {
                name = 'tags',
                module = 'blink.compat.source',
                score_offset = -3,
            },
            avante = {
                module = 'blink-cmp-avante',
                name = 'Avante',
                opts = { -- options for blink-cmp-avante
                }
            },
            git = {
                module = 'blink-cmp-git',
                name = 'Git',
                opts = { -- options for the blink-cmp-git
                },
            },
        },
    },
    signature = { enabled = true },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },
    cmdline = {
        enabled = true, -- 确保启用

        -- 在这里定义源
        sources = function()
            local type = vim.fn.getcmdtype()

            -- 搜索模式 (/ 或 ?) -> 启用 buffer 和 symbol
            if type == '/' or type == '?' then
                return { 'buffer', 'nvim_lsp_document_symbol' }
            end

            -- 命令模式 (:) -> 启用 cmdline
            if type == ':' then
                return { 'cmdline' }
            end

            return {}
        end,

        -- (可选) 可以在这里单独定义命令行的快捷键
        keymap = {
            preset = 'super-tab', -- 命令行里通常习惯用 Tab 选词
            ['<Tab>'] = { 'show_and_insert_or_accept_single', 'select_next' },
            ['<S-Tab>'] = { 'show_and_insert_or_accept_single', 'select_prev' },

            ['<C-space>'] = { 'show', 'fallback' },

            ['<C-n>'] = { 'select_next', 'fallback' },
            ['<C-p>'] = { 'select_prev', 'fallback' },
            ['<Right>'] = { 'select_next', 'fallback' },
            ['<Left>'] = { 'select_prev', 'fallback' },

            ['<C-y>'] = { 'select_and_accept', 'fallback' },
            ['<C-e>'] = { 'cancel', 'fallback' },
        },
        completion = {
            menu = { auto_show = true },
            ghost_text = { enabled = true }
        },
    },
})
