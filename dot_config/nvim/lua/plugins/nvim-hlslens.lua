require("hlslens").setup({})

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
map({ "n" }, "n", "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>", opts)
map({ "n" }, "N", "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>", opts)
map({ "n" }, "*", "*<Cmd>lua require('hlslens').start()<CR>", opts)
map({ "n" }, "#", "#<Cmd>lua require('hlslens').start()<CR>", opts)
map({ "n" }, "g*", "g*<Cmd>lua require('hlslens').start()<CR>", opts)
map({ "n" }, "g#", "g#<Cmd>lua require('hlslens').start()<CR>", opts)
