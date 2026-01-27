local wilder = require('wilder')

wilder.set_option('renderer', wilder.popupmenu_renderer(
    wilder.popupmenu_border_theme({
        highlights = { border = 'Normal', },
        border = 'single',
        right = { ' ', wilder.popupmenu_scrollbar(), },
    })
))
wilder.set_option('pipeline', {
    wilder.branch(
        wilder.cmdline_pipeline({
            fuzzy = 1,
            set_pcre2_pattern = 1,
        }),
        wilder.search_pipeline()
    ),
})

wilder.setup({
    modes = { ':', '/', '?' },
    next_key = '<C-n>',
    previous_key = '<C-p>',
})
