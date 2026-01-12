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
set_hl(0, "CocHighlightText", { bg = "#B48EAD", fg = "#2E3440" })
set_hl(0, "CocErrorHighlight", { bg = "#BF616A", fg = "#d8dee9" })
set_hl(0, "CocWarnHighlight", { bg = "#EBCB8B", fg = "#d8dee9" })
set_hl(0, "CocSemLifetime", { fg = "#EBCB8B" })

-- Temporarily disabled semantic highlights
-- set_hl(0, "CocSemAbstract", { fg = "#D08770" })
-- set_hl(0, "CocSemAsync", { fg = "#EBCB8B" })
-- set_hl(0, "CocSemClass", { fg = "#81A1C1" })
-- set_hl(0, "CocSemComment", { fg = "#434C5E" })
-- set_hl(0, "CocSemDeclaration", { fg = "#8FBCBB" })
-- set_hl(0, "CocSemDecorator", { fg = "#88C0D0" })
-- set_hl(0, "CocSemDefaultLibrary", { fg = "#88C0D0" })
-- set_hl(0, "CocSemDefinition", { fg = "#81A1C1" })
-- set_hl(0, "CocSemDeprecated", { fg = "#BF616A" })
-- set_hl(0, "CocSemDocumentation", { fg = "#B48EAD" })
-- set_hl(0, "CocSemEnum", { fg = "#81A1C1" })
-- set_hl(0, "CocSemEnumMember", {})
-- set_hl(0, "CocSemEvent", {})
-- set_hl(0, "CocSemFunction", { fg = "#81A1C1" })
-- set_hl(0, "CocSemFunction", { fg = "#81A1C1" })
-- set_hl(0, "CocSemInterface", { fg = "#81A1C1" })
-- set_hl(0, "CocSemKeyword", { fg = "#88C0D0" })
-- set_hl(0, "CocSemMacro", { fg = "#81A1C1" })
-- set_hl(0, "CocSemMethod", { fg = "#8FBCBB" })
-- set_hl(0, "CocSemModification", { fg = "#88C0D0" })
-- set_hl(0, "CocSemModifier", { fg = "#88C0D0" })
-- set_hl(0, "CocSemNamespace", { fg = "#EBCB8B" })
-- set_hl(0, "CocSemNumber", { fg = "#B48EAD" })
-- set_hl(0, "CocSemOperator", { fg = "#81A1C1" })
-- set_hl(0, "CocSemParameter", { fg = "#5E81AC" })
-- set_hl(0, "CocSemProperty", { fg = "#5E81AC" })
-- set_hl(0, "CocSemReadonly", { fg = "#81A1C1" })
-- set_hl(0, "CocSemRegexp", { fg = "#8FBCBB" })
-- set_hl(0, "CocSemStatic", { fg = "#BF616A" })
-- set_hl(0, "CocSemString", { fg = "#A3BE8C" })
-- set_hl(0, "CocSemStruct", { fg = "#81A1C1" })
-- set_hl(0, "CocSemType", { fg = "#81A1C1" })
-- set_hl(0, "CocSemTypeParameter", { fg = "#81A1C1" })
-- set_hl(0, "CocSemVariable", { fg = "#d8dee9" })

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
-- 5. Key Mappings
-- ============================================================================

local opts_expr = { silent = true, expr = true, replace_keycodes = false }

-- Super TAB (Completion + Jump + Indent)
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#_select_confirm() : ' ..
    'coc#expandableOrJumpable() ? coc#rpc#request("doKeymap", ["snippets-expand-jump", ""]) : ' ..
    'v:lua.check_back_space() ? "<TAB>" : ' ..
    'coc#refresh()', opts_expr)


-- Diagnostic navigation [a / ]a
keyset("n", "[a", ":<C-u>CocPrev<CR>", opts)
keyset("n", "]a", ":<C-u>CocNext<CR>", opts)

-- --- Coc List Mappings ---
keyset("n", "<leader>ce", "<Cmd>CocCommand explorer<CR>", { silent = true, nowait = true })
keyset("n", "<leader>cd", ":<C-u>CocList --auto-preview diagnostics<cr>", { silent = true, nowait = true })
keyset("n", "<leader>cc", ":CocList commands<CR>", { silent = true, nowait = true })
keyset("n", "<leader>c/", ":<C-u>CocList --interactive --auto-preview grep<CR>", { silent = true, nowait = true })

-- General List Mappings (Normal + Visual)
keyset({ "n", "x" }, "<leader>cm", ":CocList maps<CR>", opts)
keyset({ "n", "x" }, "<leader>ck", ":CocList marks<CR>", opts)
keyset({ "n", "x" }, "<leader>cf", ":<C-u>CocList --auto-preview files<CR>", opts)
keyset({ "n", "x" }, "<leader>cb", ":CocList --auto-preview buffers<CR>", opts)
keyset({ "n", "x" }, "<leader>co", ":CocList --auto-preview outline<CR>", opts)

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
