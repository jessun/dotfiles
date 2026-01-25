--------------------------------------------------------------------------------
--  Theme & Visuals
--  Author:      jessun.pro@gmail.com
--  Description: Colors, fonts, and UI appearance logic (including Neovide).
--  Location:    ~/.config/nvim/lua/theme.lua
--------------------------------------------------------------------------------

local opt = vim.opt
local g = vim.g

-- ============================================================================
-- 01. Basic Appearance
-- ============================================================================
-- Enable 24-bit RGB color (True Color). Required for themes like Nord.
if vim.fn.has("termguicolors") == 1 then
    opt.termguicolors = true
end

-- Set default background tone.
opt.background = "dark"

-- Ensure syntax highlighting is enabled.
vim.cmd([[syntax on]])
g.markdown_fenced_languages = { 'vim', 'help', 'json', 'python', 'bash', 'go', 'rust' }

-- ============================================================================
-- 02. Font Configuration (GUI / Neovide)
-- ============================================================================
-- Logic: Iterate through the preferred fonts list and apply the first one found.
-- Note: Neovide uses the standard 'guifont' option.

if g.neovide or vim.fn.has("gui_running") == 1 then
    local font_list = {
        "JetBrainsMono Nerd Font",          -- Priority 1
        "BerkeleyMonoTrial Nerd Font Mono", -- Priority 2
        "Menlo",                            -- macOS Default
        "Consolas",                         -- Windows Default (Fallback)
    }
    local font_size = 22

    for _, font in ipairs(font_list) do
        -- Escape spaces in font name (e.g., "Font Name" -> "Font\ Name")
        local escaped_font = string.gsub(font, " ", "\\ ")

        -- Try setting the font.
        -- Use pcall to prevent errors if the font is missing.
        local status, _ = pcall(function()
            opt.guifont = escaped_font .. ":h" .. font_size
        end)

        if status then
            -- Stop searching once a valid font is loaded.
            break
        end
    end
end

-- ============================================================================
-- 03. Neovide Specific Configuration
-- ============================================================================
-- Settings specifically for the Neovide client.
-- Docs: https://neovide.dev/configuration.html

if g.neovide then
    -- --- [ Visuals ] ---
    -- g.neovide_transparency = 0.95         -- 0.0 (Transparent) - 1.0 (Opaque)
    g.neovide_floating_blur_amount_x = 2.0 -- Horizontal blur for floating windows
    g.neovide_floating_blur_amount_y = 2.0 -- Vertical blur for floating windows
    g.neovide_theme = 'auto'               -- Auto-switch based on system theme

    -- --- [ Window Behavior ] ---
    g.neovide_hide_mouse_when_typing = true -- Hide mouse cursor when typing
    g.neovide_fullscreen = true             -- Start in fullscreen mode
    g.neovide_confirm_quit = true           -- Confirm quit if unsaved changes exist
    g.neovide_remember_window_size = true   -- Restore previous window dimensions

    -- --- [ Animations & Smoothness ] ---
    g.neovide_scroll_animation_length = 0.3 -- Scroll animation duration (seconds)

    -- Cursor Animations
    g.neovide_cursor_animation_length = 0.01 -- Cursor movement duration (fast)
    g.neovide_cursor_trail_size = 0.2        -- Length of the cursor trail

    -- Cursor VFX (Visual Effects)
    -- Options: "railgun", "torpedo", "pixiedust", "sonicboom", "ripple", "wireframe"
    -- Set to "" to disable VFX.
    g.neovide_cursor_vfx_mode = ""
    g.neovide_cursor_vfx_particle_lifetime = 1.2

    -- --- [ Performance ] ---
    g.neovide_refresh_rate = 60 -- Target refresh rate (e.g., 60, 120)

    -- --- [ Input ] ---
    g.neovide_input_use_logo = true -- Enable Super/Command key

    -- --- [ Zoom Shortcuts ] ---
    -- Use Command + / - / 0 to scale the UI.
    g.neovide_scale_factor = 1.0

    -- Zoom In (Command + =)
    vim.keymap.set("n", "<D-=>", function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
        print("Zoom: " .. string.format("%.2f", g.neovide_scale_factor))
    end)

    -- Zoom Out (Command + -)
    vim.keymap.set("n", "<D-->", function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 0.9
        print("Zoom: " .. string.format("%.2f", g.neovide_scale_factor))
    end)

    -- Reset Zoom (Command + 0)
    vim.keymap.set("n", "<D-0>", function()
        vim.g.neovide_scale_factor = 1.0
        print("Zoom: 1.00")
    end)

    vim.keymap.set('i', '<D-v>', '<C-r>+', { noremap = true, silent = true })
    vim.keymap.set('c', '<D-v>', '<C-r>+', { noremap = true, silent = true })
    vim.keymap.set('n', '<D-v>', '"+p', { noremap = true, silent = true })
    vim.keymap.set('t', '<D-v>', '<C-\\><C-n>"+pi', { noremap = true, silent = true })
end

-- ============================================================================
-- 04. Colorscheme Loading Strategy
-- ============================================================================
-- Logic: Attempt to load themes in order of preference.
-- If the preferred theme (e.g., plugin not installed) fails, fallback gracefully.

local preferred_schemes = { "nord", "habamax", "slate", "default" }

for _, scheme in ipairs(preferred_schemes) do
    -- pcall returns status (true/false) and potential errors.
    local status, _ = pcall(vim.cmd, "colorscheme " .. scheme)
    if status then
        -- Stop once a scheme is successfully loaded.
        break
    end
end
-- ============================================================================
-- End of file
-- ============================================================================
