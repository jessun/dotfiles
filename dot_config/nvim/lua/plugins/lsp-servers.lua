local gopls_cfg = {}
local vtsls_cfg = {
    -- 这里是一些推荐的微调配置，让它更像 VS Code
    settings = {
        typescript = {
            updateImportsOnFileMove = { enabled = "always" }, -- 移动文件自动更新引用
            inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
            },
        },
        javascript = {
            updateImportsOnFileMove = { enabled = "always" },
            inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
            },
        },
        vtsls = {
            -- 如果你项目特别大，可以开启这一项来减少内存占用，但可能会稍微慢一点点
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true, -- 自动使用工作区的 TS 版本
            experimental = {
                completion = {
                    enableServerSideFuzzyMatch = true, -- 开启服务端模糊匹配
                },
            },
        },
    },
}
local eslint_cfg = {
    settings = {
        -- 帮助 eslint 找到工作区配置
        workingDirectory = { mode = 'location' },
    },
    -- 2. 设置保存时自动修复 (强烈推荐)
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
    end,
}
local typos_lsp_cfg = {
    init_options = {
        diagnosticSeverity = "Hint",
    },
}
local jsonls_cfg = {
    settings = {
        json = {
            -- 这里调用 schemastore 获取所有流行 JSON 文件的 schema
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    },
}
local yamlls_cfg = {
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
}
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
local lus_ls_cfg = {
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
}

return {
    gopls = gopls_cfg,
    vtsls = vtsls_cfg,
    eslint = eslint_cfg,
    typos_lsp = typos_lsp_cfg,
    jsonls = jsonls_cfg,
    yamlls = yamlls_cfg,
    harper_ls = harper_ls_cfg,
    lua_ls = lus_ls_cfg,
}
