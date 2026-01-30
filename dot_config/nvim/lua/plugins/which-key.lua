local map = vim.keymap.set
local wk = require('which-key')
wk.setup({
    -- "classic" : 经典风格 (默认)
    -- "modern"  : 现代风格 (带边框和圆角，类似 Telescope)
    -- "helix"   : 类似 Helix 编辑器的风格 (无边框，紧凑)
    preset = "helix",
    win = {
        -- 边框样式: "none", "single", "double", "rounded", "shadow", "solid"
        border = "none",

        -- 是否显示标题 (e.g. "Which Key")
        title = false,
        title_pos = "center",
        -- 窗口内边距 {上, 右, 下, 左}
        padding = { 2, 2, 2, 2 },

        -- 透明度 (0-100)，需要你的终端和配色支持
        -- winblend = 0,
        -- 窗口层级 (Z-Index)
        zindex = 1000,
    },
})

map({ "n" }, "<leader>?",
    function()
        wk.show({ global = true })
    end,
    opts)
