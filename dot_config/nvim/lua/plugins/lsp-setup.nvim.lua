-- "solid", "double", "rounded", "solid", "shadow"
require('lspconfig.ui.windows').default_options.border = "solid"
vim.diagnostic.config({
    float = { border = "solid" },
    virtual_text = false,
    virtual_lines = nil,
})

local harper_ls_cfg = {
    settings = {
        ["harper-ls"] = {
            linters = {
                SpellCheck = true,             -- 拼写检查
                SpelledNumbers = false,        -- 检查数字拼写 (如 "one" vs "1")，建议关闭
                AnA = true,                    -- 检查 a/an 的用法
                SentenceCapitalization = true, -- 检查句子首字母大写
                UnclosedQuotes = true,         -- 检查未闭合的引号
                WrongQuotes = false,           -- 检查引号类型 (通常代码里不需要)
                LongSentences = false,         -- 检查长难句 (写代码注释时建议关闭)
                RepeatedWords = true,          -- 检查重复单词 (如 "the the")
                Spaces = true,                 -- 检查空格问题
                Matcher = true,                -- 模糊匹配检查
            },
            codeActions = {
                forceStable = true,
            }
        }
    }
}

require('lsp-setup').setup({
    default_mappings = true,
    -- Custom mappings, will overwrite the default mappings for the same key
    -- Example mappings for telescope pickers:
    mappings = {
        gD = { cmd = vim.lsp.buf.declaration, opts = { desc = 'Go To Declaration' } },
        gd = { cmd = vim.lsp.buf.definition, opts = { desc = 'Go To Definition' } },
        gi = { cmd = vim.lsp.buf.implementation, opts = { desc = 'Go To Implementation' } },
        gr = { cmd = vim.lsp.buf.references, opts = { desc = 'Go To References' } },
        K = { cmd = vim.lsp.buf.hover, opts = { desc = 'Hover' } },
        ['<C-k>'] = { cmd = vim.lsp.buf.signature_help, opts = { desc = 'Show Signature Help' } },
        ['<space>rn'] = { cmd = vim.lsp.buf.rename, opts = { desc = 'Rename' } },
        ['<space>ca'] = { cmd = vim.lsp.buf.code_action, opts = { desc = 'Code Action' } },
        -- ['<space>f'] = { cmd = vim.lsp.buf.formatting, opts = { desc = 'Format' } },
        ['<space>e'] = { cmd = vim.diagnostic.open_float, opts = { desc = 'Show Diagnostics' } },
        ['[d'] = { cmd = function() vim.diagnostic.jump({ count = -1, float = true }) end, opts = { desc = 'Prev Diagnostic' } },
        [']d'] = { cmd = function() vim.diagnostic.jump({ count = 1, float = true }) end, opts = { desc = 'Next Diagnostic' } },
        tgd = 'lua require"telescope.builtin".lsp_definitions()',
        tgi = 'lua require"telescope.builtin".lsp_implementations()',
        tgr = 'lua require"telescope.builtin".lsp_references()',
    },
    -- Global on_attach
    on_attach = function(client, bufnr)
        -- Support custom the on_attach function for global
        -- Formatting on save as default
        require('lsp-setup.utils').format_on_save(client)
    end,
    -- Global capabilities
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    -- Configuration of LSP servers
    servers = {
        typos_lsp = {
            init_options = {
                diagnosticSeverity = "Hint",
            },
        },
        jsonls = {
            settings = {
                json = {
                    -- 这里调用 schemastore 获取所有流行 JSON 文件的 schema
                    schemas = require("schemastore").json.schemas(),
                    validate = { enable = true },
                },
            },
        },
        yamlls = {
            settings = {
                yaml = {
                    schemaStore = {
                        -- 必须关闭内置的 schemaStore 支持，防止冲突
                        enable = false,
                        url = "",
                    },
                    -- 使用 SchemaStore 提供的 yaml schemas
                    schemas = require("schemastore").yaml.schemas(),
                },
            },
        },
        harper_ls = harper_ls_cfg,
        lua_ls = {
            format = { enable = true },
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file('', true),
                    },
                },
            },
        },
    },
    -- Configuration of LSP inlay hints
    inlay_hints = {
        enabled = true,
        highlight = 'Comment',
    }
})
