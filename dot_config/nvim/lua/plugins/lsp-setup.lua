local lsp_utils = require('utils.lsp')
local capabilities = lsp_utils.get_capabilities()
local servers_data = require('plugins.lsp-servers')

require('lsp-setup').setup({
    default_mappings = true,
    -- Custom mappings, will overwrite the default mappings for the same key
    -- Example mappings for telescope pickers:
    mappings = {
        gD = { cmd = vim.lsp.buf.declaration, opts = { desc = 'Go To Declaration' } },
        lgd = { cmd = vim.lsp.buf.definition, opts = { desc = 'Go To Definition' } },
        lgi = { cmd = vim.lsp.buf.implementation, opts = { desc = 'Go To Implementation' } },
        lgr = { cmd = vim.lsp.buf.references, opts = { desc = 'Go To References' } },
        K = { cmd = vim.lsp.buf.hover, opts = { desc = 'Hover' } },
        ['<C-k>'] = { cmd = vim.lsp.buf.signature_help, opts = { desc = 'Show Signature Help' } },
        ['<space>rn'] = { cmd = vim.lsp.buf.rename, opts = { desc = 'Rename' } },
        ['<space>ca'] = { cmd = vim.lsp.buf.code_action, opts = { desc = 'Code Action' } },
        -- ['<space>f'] = { cmd = vim.lsp.buf.formatting, opts = { desc = 'Format' } },
        ['<space>e'] = { cmd = vim.diagnostic.open_float, opts = { desc = 'Show Diagnostics' } },
        ['[d'] = { cmd = function() vim.diagnostic.jump({ count = -1, float = true }) end, opts = { desc = 'Prev Diagnostic' } },
        [']d'] = { cmd = function() vim.diagnostic.jump({ count = 1, float = true }) end, opts = { desc = 'Next Diagnostic' } },
        gd = 'lua require"telescope.builtin".lsp_definitions()',
        gi = 'lua require"telescope.builtin".lsp_implementations()',
        gr = 'lua require"telescope.builtin".lsp_references()',
    },
    -- Global on_attach
    on_attach = function(client, bufnr)
        -- Support custom the on_attach function for global
        -- Formatting on save as default
        -- require('lsp-setup.utils').format_on_save(client)
    end,
    -- Global capabilities
    capabilities = capabilities,
    -- Configuration of LSP servers
    servers = servers_data,
    -- Configuration of LSP inlay hints
    inlay_hints = {
        enabled = true,
        highlight = 'Comment',
    }
})
