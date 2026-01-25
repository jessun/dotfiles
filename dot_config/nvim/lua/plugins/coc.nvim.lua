--------------------------------------------------------------------------------
--  Coc.nvim config
--  Author:      jessun.pro@gmail.com
--  Description: coc.nvim config and keymaps
--  Location:    ~/.config/nvim/lua/plugins/coc.nvim.lua
--------------------------------------------------------------------------------

vim.filetype.add({
    pattern = {
        -- 匹配文件名
        ['coc-settings.json'] = 'jsonc',
    },
})

local keyset = vim.keymap.set
-- replace_keycodes = false is a critical setting recommended by coc.nvim official docs
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
local no_expr_opts = { silent = true, nowait = true }

-- ============================================================================
-- 1. Helper Functions
-- ============================================================================

-- Function to check if the cursor is at the beginning of the line or follows whitespace.
-- Must be defined as a global function (_G) to be called via v:lua in expr mappings.
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    -- Return true if column is 0 or the character before the cursor is a space
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- ============================================================================
-- 2. Language Specific Settings
-- ============================================================================

-- Go syntax highlighting settings (for vim-go or vim-polyglot)
vim.g.go_highlight_build_constraints = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_methods = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_structs = 1
vim.g.go_highlight_types = 1

-- ============================================================================
-- 3. Highlights & Colors
-- ============================================================================

local set_hl = vim.api.nvim_set_hl

-- SemanticTokens ==============================================================
-- Active Highlights
set_hl(0, "CocHighlightText", { bg = "#D08770", fg = "#2E3440" })
set_hl(0, "CocErrorHighlight", { bg = "#BF616A", fg = "#2E3440" })
set_hl(0, "CocWarnHighlight", { bg = "#EBCB8B", fg = "#2E3440" })
set_hl(0, "CocInfoHighlight", { bg = "#5E81AC", fg = "#2E3440" })
set_hl(0, "CocHintHighlight", { bg = "#4C566A", fg = "#2E3440" })

-- ============================================================================
-- 4. Advanced Functions (Grep & Cursors)
-- ============================================================================

-- Function to grep search from selected text (Visual or Motion)
function _G.coc_grep_from_selected(type)
    local saved_reg = vim.fn.getreg('"')
    if type == nil then
        vim.cmd("normal! gvy")
    elseif type == 'line' then
        vim.cmd("normal! '[V']y")
    else
        vim.cmd("normal! `[v`]y")
    end
    local text = vim.fn.getreg('"')
    vim.fn.setreg('"', saved_reg)

    if #text > 0 then
        text = text:gsub("\n", "") -- Remove newlines
        -- Call CocList grep
        vim.cmd("CocList grep " .. text)
    end
end

-- Grep from selection (Visual Mode)
keyset("x", "<leader>g", ":<C-u>lua _G.coc_grep_from_selected(nil)<CR>", opts)
-- Grep by motion (Normal Mode)
keyset("n", "<leader>g", function()
    vim.go.operatorfunc = "v:lua.coc_grep_from_selected"
    return "g@"
end, { expr = true, silent = true })

-- Smart Multi-Cursor (<C-x>)
keyset("n", "<C-x>", function()
    -- Check if coc-cursors is activated in current buffer
    local activated = vim.b.coc_cursors_activated or 0
    if activated == 0 then
        return "<Plug>(coc-cursors-word)"
    else
        return "*<Plug>(coc-cursors-word):nohlsearch<CR>"
    end
end, { silent = true, expr = true, replace_keycodes = true })
-- ============================================================================
-- 5. coc-spell-checker
-- ============================================================================
vim.api.nvim_create_user_command('CleanList', function(opts)
    local start_line = opts.line1
    local end_line = opts.line2

    vim.cmd(string.format('%d,%ds/^\\s*"\\([^"]*\\)",\\?\\s*$/\\1/e', start_line, end_line))
end, { range = true })
-- ============================================================================
-- 6. Key Mappings
-- ============================================================================

local opts_expr = { silent = true, expr = true, replace_keycodes = false }

-- Float Window Scrol
-- Normal
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
-- Insert
keyset("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>"kk : "<Right>"', opts)
keyset("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
-- Visual
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

-- Super TAB (Completion + Jump + Indent)
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#_select_confirm() : ' ..
    'coc#expandableOrJumpable() ? coc#rpc#request("doKeymap", ["snippets-expand-jump", ""]) : ' ..
    'v:lua.check_back_space() ? "<TAB>" : ' ..
    'coc#refresh()', opts_expr)


-- Diagnostic navigation [a / ]a
keyset("n", "[a", ":<C-u>CocPrev<CR>", opts)
keyset("n", "]a", ":<C-u>CocNext<CR>", opts)

-- --- Coc List Mappings ---
keyset("n", "<leader>ce", "<Cmd>CocCommand explorer<CR>", no_expr_opts)
keyset("n", "<leader>cd", ":<C-u>CocList --auto-preview diagnostics<cr>", no_expr_opts)
keyset("n", "<leader>cc", ":CocList commands<CR>", no_expr_opts)
keyset("n", "<leader>c/", ":<C-u>CocList --interactive --auto-preview grep<CR>", no_expr_opts)

-- General List Mappings (Normal + Visual)
keyset({ "n", "x" }, "<leader>cm", ":CocList maps<CR>", opts)
keyset({ "n", "x" }, "<leader>ck", ":CocList marks<CR>", opts)
keyset({ "n", "x" }, "<leader>cf", ":<C-u>CocList --auto-preview files<CR>", opts)
keyset({ "n", "x" }, "<leader>cb", ":CocList --auto-preview buffers<CR>", no_expr_opts)

-- Code Action Mappings
keyset({ "n", "x" }, "<leader>cs", "<Plug>(coc-codeaction-selected)", { silent = true })
keyset({ "n", "x" }, "<leader>ca", "<Plug>(coc-codeaction)", { silent = true })

-- --- Coc Snippets Mappings ---
keyset("i", "<C-l>", "<Plug>(coc-snippets-expand)", { silent = true })
keyset("v", "<C-j>", "<Plug>(coc-snippets-select)", { silent = true })

-- Use global variables to define jump triggers
vim.g.coc_snippet_next = '<c-n>'
vim.g.coc_snippet_prev = '<c-p>'

keyset("i", "<C-j>", "<Plug>(coc-snippets-expand-jump)", { silent = true })
keyset("x", "<leader>x", "<Plug>(coc-convert-snippet)", { silent = true })

-- --- Coc Git Mappings ---
keyset("n", "[h", "<Plug>(coc-git-prevchunk)", { silent = true })
keyset("n", "]h", "<Plug>(coc-git-nextchunk)", { silent = true })
keyset("n", "[c", "<Plug>(coc-git-prevconflict)", { silent = true })
keyset("n", "]c", "<Plug>(coc-git-nextconflict)", { silent = true })
keyset("n", "gs", "<Plug>(coc-git-chunkinfo)", { silent = true })
keyset("n", "gc", "<Plug>(coc-git-commit)", { silent = true })

-- Git Text Objects
keyset({ "o", "x" }, "ig", "<Plug>(coc-git-chunk-inner)", { silent = true })
keyset({ "o", "x" }, "ag", "<Plug>(coc-git-chunk-outer)", { silent = true })

-- Git Conflict Resolution
keyset({ "n", "o" }, "cb", "<Plug>(coc-git-keepboth)", { silent = true })
keyset({ "n", "o" }, "co", "<Plug>(coc-git-keepcurrent)", { silent = true })
keyset({ "n", "o" }, "ct", "<Plug>(coc-git-keepincoming)", { silent = true })

-- --- Coc Translator Mappings ---
keyset("n", "<Leader>ct", "<Plug>(coc-translator-p)", { silent = true })
keyset("v", "<Leader>ct", "<Plug>(coc-translator-pv)", { silent = true })

-- --- Quick Access Mappings ---
keyset("n", "<leader>e", "<Cmd>CocCommand explorer<CR>", { silent = true, nowait = true })
keyset("n", "<F3>", "<Cmd>CocCommand explorer<CR>", { silent = true, nowait = true })
-- keyset("n", "<leader>b", "<Cmd>CocList --auto-preview buffers<CR>", { silent = true, nowait = true })
-- keyset("n", "<leader>d", "<Cmd>CocList --auto-preview diagnostics<CR>", { silent = true, nowait = true })
-- keyset("n", "<leader><leader>", ":<C-u>CocList --auto-preview files<CR>", { silent = true, nowait = true })

-- <leader>W: Grep current word under cursor in project
-- keyset("n", "<leader>W", function()
--     local cword = vim.fn.expand('<cword>')
--     vim.cmd('CocList --interactive --auto-preview --normal --input=' .. cword .. ' grep --ignore-case --regexp')
-- end, { silent = true, nowait = true })

-- <leader>w: Search current word under cursor in current buffer (words)
-- keyset("n", "<leader>w", function()
--     local cword = vim.fn.expand('<cword>')
--     vim.cmd('CocList --interactive --auto-preview --normal --input=' .. cword .. ' words')
-- end, { silent = true, nowait = true })

-- <leader>/: Interactive Grep
-- keyset("n", "<leader>/", ":<C-u>CocList --interactive --auto-preview grep --ignore-case --regexp<CR>",
--     { silent = true, nowait = true })

-- <leader>y: Show Yank List
keyset("n", "<leader>y", ":<C-u>CocList --interactive yank<CR>", { silent = true, nowait = true })

-- ============================================================================
-- End of file
-- ============================================================================
