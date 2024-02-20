if not vim.g.vscode then
    require("base").init()
    -- require("plugins").init()
end

vim.cmd([[
hi CocNord guifg='#D8DEE9' guibg='#3B4252'
]])
