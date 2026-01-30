local map = vim.keymap.set
local opts = { silent = true, noremap = true }
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
        padding = { 1, 1, 1, 1 },

        -- 透明度 (0-100)，需要你的终端和配色支持
        -- winblend = 0,
        -- 窗口层级 (Z-Index)
        zindex = 1000,
    },
    icons = {
        -- 1. 🔴 核心：禁用自动图标规则
        -- which-key 默认会根据描述文字（如 "file", "git"）自动匹配图标，必须关掉
        rules = false,

        -- 2. 将层级分隔符改为普通字符
        breadcrumb = ">",  -- 顶部导航栏的分隔符
        separator = " - ", -- 键位与描述之间的分隔符

        -- 3. 组前缀（当一个键是文件夹时显示的符号）
        -- 默认可能是文件夹图标，改为普通的加号
        group = "+",

        -- 4. 特殊按键的纯文本化
        -- 默认 <Space> 会显示为 ␣，<CR> 会显示为 ↵ 等
        -- 在这里强制把它们改回英文单词
        keys = {
            Up = "Up ",
            Down = "Down ",
            Left = "Left ",
            Right = "Right ",
            C = "C-",
            M = "M-",
            D = "D-",
            S = "S-",
            CR = "Enter ",
            Esc = "Esc ",
            ScrollWheelDown = "ScrollDown ",
            ScrollWheelUp = "ScrollUp ",
            NL = "NL ",
            BS = "BS ",
            Space = "Space ",
            Tab = "Tab ",
            F1 = "F1",
            F2 = "F2",
            F3 = "F3",
            F4 = "F4",
            F5 = "F5",
            F6 = "F6",
            F7 = "F7",
            F8 = "F8",
            F9 = "F9",
            F10 = "F10",
            F11 = "F11",
            F12 = "F12",
        },
    },
})

map({ "n" }, "<leader>?",
    function()
        wk.show({ global = true })
    end,
    opts)
