-- https://github.com/nvim-tree/nvim-tree.lua

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
  vim.keymap.set('n', 'l',     api.node.open.edit,                  opts('Open'))
end

require("nvim-tree").setup({
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        debounce_delay = 50,
        icons = {
            hint = "·",
            info = "·",
            warning = "!",
            error = "x",
        },
    },
    filters = {
        dotfiles = false,
    },
    git = {
        ignore = false,
    },
  on_attach = my_on_attach,
})

vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true }) 
