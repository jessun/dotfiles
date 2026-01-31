return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs                        = {
            add          = { text = '┃' },
            change       = { text = '┃' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        signs_staged                 = {
            add          = { text = '┃' },
            change       = { text = '┃' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        signs_staged_enable          = true,
        signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir                 = {
            follow_files = true
        },
        auto_attach                  = true,
        attach_to_untracked          = false,
        current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
            virt_text_priority = 100,
            use_focus = true,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority                = 6,
        update_debounce              = 100,
        status_formatter             = nil,   -- Use default
        max_file_length              = 40000, -- Disable if file is longer than this (in lines)
        preview_config               = {
            -- Options passed to nvim_open_win
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
        },
        on_attach                    = function(bufnr)
            local gitsigns = require('gitsigns')

            local function keyset(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            keyset('n', ']h', function()
                if vim.wo.diff then
                    vim.cmd.normal({ ']c', bang = true })
                else
                    gitsigns.nav_hunk('next')
                end
            end)

            keyset('n', '[h', function()
                if vim.wo.diff then
                    vim.cmd.normal({ '[c', bang = true })
                else
                    gitsigns.nav_hunk('prev')
                end
            end)

            -- Actions
            keyset('n', '<leader>hs', gitsigns.stage_hunk)
            keyset('n', '<leader>hr', gitsigns.reset_hunk)

            keyset('v', '<leader>hs', function()
                gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end)

            keyset('v', '<leader>hr', function()
                gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end)

            keyset('n', '<leader>hS', gitsigns.stage_buffer)
            keyset('n', '<leader>hR', gitsigns.reset_buffer)
            keyset('n', '<leader>hp', gitsigns.preview_hunk)
            keyset('n', '<leader>hi', gitsigns.preview_hunk_inline)

            -- map('n', '<leader>hb', function()
            --     gitsigns.blame_line({ full = true })
            -- end)
            keyset('n', '<leader>hb', function()
                gitsigns.blame({ full = true })
            end)

            keyset('n', '<leader>hd', gitsigns.diffthis)

            keyset('n', '<leader>hD', function()
                gitsigns.diffthis('~')
            end)

            keyset('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
            keyset('n', '<leader>hq', gitsigns.setqflist)

            -- Toggles
            -- map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
            keyset('n', '<leader>tw', gitsigns.toggle_word_diff)

            -- Text object
            keyset({ 'o', 'x' }, 'ig', gitsigns.select_hunk)
            keyset({ 'o', 'x' }, 'ag', gitsigns.select_hunk)
        end

    }
}
