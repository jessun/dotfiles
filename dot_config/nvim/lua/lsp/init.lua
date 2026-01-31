local M = {}

function M.get_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local has_blink, blink = pcall(require, 'blink.cmp')
    if has_blink then
        return blink.get_lsp_capabilities(capabilities)
    end

    local has_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
    if has_cmp then
        return cmp_lsp.default_capabilities(capabilities)
    end

    -- 3. 保底返回默认
    return capabilities
end

return M
