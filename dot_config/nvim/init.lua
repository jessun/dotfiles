-- -----------------------------------------------------------------------------
--  Neovim Configuration (init.lua)
--  Author:   jessun.pro@gmail.com
--  Github:   https://github.com/jessun
--  Location: ~/.config/nvim/init.lua
-- -----------------------------------------------------------------------------
--  Dependencies:
--  - System Tools (macOS):
--    $ brew install fzf bat fd ripgrep the_silver_searcher perl universal-ctags gnu-sed
--  Documentation:
--  - Internal:      :help <topic>
--  - Local (Linux): /usr/share/nvim/runtime/doc/*
--  - Local (macOS): /opt/homebrew/share/nvim/runtime/doc/*
--  - Online:        https://neovim.io/doc/user/
--                   https://github.com/neovim/neovim/blob/master/runtime/doc/options.txt
-- -----------------------------------------------------------------------------

-- ============================================================================
-- 1. Bootstrap & Core Settings
-- ============================================================================

-- Set <Space> as the leader key.
-- IMPORTANT: This must be set before loading any plugins.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Disable the built-in file explorer (Netrw).
-- This is recommended when using modern file explorers like coc-explorer.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- ============================================================================
-- 2. Load Configuration Modules
-- ============================================================================
-- Neovim automatically looks for lua files inside the 'lua/' directory.
-- The following lines load specific files from ~/.config/nvim/lua/...

-- 2.1 General Options
-- Handles indentation, UI settings, and XDG path isolation.
-- Source: lua/options.lua
require("options")

-- 2.2 Key Mappings
-- Defines keyboard shortcuts.
-- Source: lua/keymaps.lua
require("keymaps")

-- 2.3 Auto Commands
-- Handles automatic events (like auto-save or resizing splits).
-- Source: lua/autocmds.lua
require("autocmds")

-- 2.4 Theme & Visuals
-- Themes, fonts, and Neovide specific configurations.
-- Source: lua/theme.lua
require("theme")

-- 2.5 Plugins
-- Plugins and plugin settings
-- Source: plugins/
require("plugins")

-- ============================================================================
-- End of file
-- ============================================================================
