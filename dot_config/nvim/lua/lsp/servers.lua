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
            validate = { enable = true },
            schemas = {
                {
                    -- custom json schema
                    -- fileMatch = { "package.json" },
                    -- url = "https://json.schemastore.org/package.json"
                }
            }
        }
    }
}
local has_schemastore, schemastore = pcall(require, 'schemastore')
if has_schemastore then
    local store_schemas = schemastore.json.schemas()
    if jsonls_cfg.settings.json.schemas then
        vim.list_extend(jsonls_cfg.settings.json.schemas, store_schemas)
    else
        jsonls_cfg.settings.json.schemas = store_schemas
    end
    jsonls_cfg.settings.json.schemas = schemastore.json.schemas()
end

local yamlls_cfg = {
    settings = {
        yaml = {
            schemaStore = {
                -- 默认开启内置支持。
                -- 逻辑：如果没装插件，让 LSP 自己去下载 schema，总比没有好。
                enable = true,
                url = "",
            },
            -- 初始化为空表 (或者放入你自己私有的 schema 配置)
            schemas = {},
        },
    },
}
local has_schemastore, schemastore = pcall(require, 'schemastore')
if has_schemastore then
    -- 🟢 场景 A: 插件加载成功

    -- 1. 必须关闭内置的 schemaStore 支持，防止与插件冲突
    yamlls_cfg.settings.yaml.schemaStore.enable = false

    -- 2. 注入插件提供的 schemas
    -- 使用 vim.tbl_deep_extend 进行深度合并
    -- 这样如果你在上面 `schemas = {}` 里定义了自己的 schema，也不会被覆盖
    yamlls_cfg.settings.yaml.schemas = vim.tbl_deep_extend(
        "force",
        yamlls_cfg.settings.yaml.schemas,
        schemastore.yaml.schemas()
    )
else
    -- 🔴 场景 B: 插件未找到
    -- 保持 yamlls_cfg.settings.yaml.schemaStore.enable = true
    -- 这样 LSP 会回退到使用它内置的 schema 列表
end

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
