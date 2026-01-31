local capabilities = require('lsp').get_capabilities()
local server_data = require('lsp.servers')

return {
    'junnplus/lsp-setup.nvim',
    cond = vim.g.enable_native_lsp,
    dependencies = {
        'neovim/nvim-lspconfig',
    },
    opts = {
        -- Default mappings
        -- gD = { cmd = vim.lsp.buf.declaration, opts = { desc = 'Go To Declaration' } },
        -- gd = { cmd = vim.lsp.buf.definition, opts = { desc = 'Go To Definition' } },
        -- gi = { cmd = vim.lsp.buf.implementation, opts = { desc = 'Go To Implementation' } },
        -- gr = { cmd = vim.lsp.buf.references, opts = { desc = 'Go To References' } },
        -- K = { cmd = vim.lsp.buf.hover, opts = { desc = 'Hover' } },
        -- ['<C-k>'] = { cmd = vim.lsp.buf.signature_help, opts = { desc = 'Show Signature Help' } },
        -- ['<space>rn'] = { cmd = vim.lsp.buf.rename, opts = { desc = 'Rename' } },
        -- ['<space>ca'] = { cmd = vim.lsp.buf.code_action, opts = { desc = 'Code Action' } },
        -- ['<space>f'] = { cmd = vim.lsp.buf.formatting, opts = { desc = 'Format' } },
        -- ['<space>e'] = { cmd = vim.diagnostic.open_float, opts = { desc = 'Show Diagnostics' } },
        -- ['[d'] = { cmd = function() vim.diagnostic.jump({ count = -1, float = true }) end, opts = { desc = 'Prev Diagnostic' } },
        -- [']d'] = { cmd = function() vim.diagnostic.jump({ count = 1, float = true }) end, opts = { desc = 'Next Diagnostic' } },
        default_mappings = true,
        -- Custom mappings, will overwrite the default mappings for the same key
        -- Example mappings for telescope pickers:
        -- gd = 'lua require"telescope.builtin".lsp_definitions()',
        -- gi = 'lua require"telescope.builtin".lsp_implementations()',
        -- gr = 'lua require"telescope.builtin".lsp_references()',
        mappings = {},
        -- Global on_attach
        on_attach = function(client, bufnr)
            -- Support custom the on_attach function for global
            -- Formatting on save as default
            require('lsp-setup.utils').format_on_save(client)
        end,
        -- Global capabilities
        capabilities = capabilities,
        -- Configuration of LSP servers
        servers = server_data,
        -- Configuration of LSP inlay hints
        inlay_hints = {
            enabled = true,
            highlight = 'Comment',
        }
    },
}
