-- lua/utils/lsp.lua
local M = {}

--- 获取通用的 LSP Capabilities
--- 自动检测是 Blink 还是 CMP，实现真正的解耦
function M.get_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- 1. 优先尝试 Blink (高性能)
    -- 使用 pcall 安全调用，如果没装 blink 不会报错
    local has_blink, blink = pcall(require, 'blink.cmp')
    if has_blink then
        return blink.get_lsp_capabilities(capabilities)
    end

    -- 2. 其次尝试 Nvim-CMP (旧习惯)
    local has_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
    if has_cmp then
        return cmp_lsp.default_capabilities(capabilities)
    end

    -- 3. 保底返回默认
    return capabilities
end

return M
