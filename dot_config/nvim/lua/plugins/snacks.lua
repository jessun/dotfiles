local input_cfg = {
    enabled = true,
    icon = "",
}

local dim_cfg = {
    enabled = true,
    ---@type snacks.scope.Config
    scope = {
        min_size = 5,
        max_size = 20,
        siblings = true,
    },
    -- animate scopes. Enabled by default for Neovim >= 0.10
    -- Works on older versions but has to trigger redraws during animation.
    ---@type snacks.animate.Config|{enabled?: boolean}
    animate = {
        enabled = vim.fn.has("nvim-0.10") == 1,
        easing = "outQuad",
        duration = {
            step = 20,   -- ms per step
            total = 300, -- maximum duration
        },
    },
    -- what buffers to dim
    filter = function(buf)
        return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ""
    end,

}

local zen_cfg = {
    -- You can add any `Snacks.toggle` id here.
    -- Toggle state is restored when the window is closed.
    -- Toggle config options are NOT merged.
    ---@type table<string, boolean>
    toggles = {
        dim = true,
        git_signs = false,
        mini_diff_signs = false,
        -- diagnostics = false,
        -- inlay_hints = false,
    },
    center = true,          -- center the window
    show = {
        statusline = false, -- can only be shown when using the global statusline
        tabline = false,
    },
    ---@type snacks.win.Config
    win = { style = "zen" },
    --- Callback when the window is opened.
    ---@param win snacks.win
    on_open = function(win) end,
    --- Callback when the window is closed.
    ---@param win snacks.win
    on_close = function(win) end,
    --- Options for the `Snacks.zen.zoom()`
    ---@type snacks.zen.Config
    zoom = {
        toggles = {},
        center = false,
        show = { statusline = true, tabline = true },
        win = {
            backdrop = false,
            width = 0, -- full width
        },
    },
}

Snacks.setup {
    animate = {},
    bufdelete = {},
    dim = dim_cfg,
    input = input_cfg,
    lazygit = {},
    notifier = {},
    picker = {},
    quickfile = {},
    rename = {},
    scratch = {},
    scroll = {},
    terminal = {},
    toggle = {},
    words = {},
    zen = zen_cfg,
}

vim.ui.input = function(data, on_confirm)
    Snacks.input(data, on_confirm)
end

vim.ui.select = function(items, opts, on_choice)
    Snacks.picker.select(items, opts, on_choice)
end

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params
            .value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= "table" then
            return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
                p[i] = {
                    token = ev.data.params.token,
                    msg = ("[%3d%%] %s%s"):format(
                        value.kind == "end" and 100 or value.percentage or 100,
                        value.title or "",
                        value.message and (" **%s**"):format(value.message) or ""
                    ),
                    done = value.kind == "end",
                }
                break
            end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
                notif.icon = #progress[client.id] == 0 and " "
                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})


local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map({ "n" }, "<leader>z", function() Snacks.toggle.dim():toggle() end, opts)
map({ "n" }, "<leader>g", function() Snacks.lazygit.open() end, opts)
map({ "n" }, "<leader>n", function() Snacks.notifier.show_history() end, opts)
map({ "n" }, "<leader>h", function() Snacks.toggle.inlay_hints():toggle() end, opts)
map({ "n" }, "]]", function() Snacks.words.jump(1, true) end, { desc = "Next Reference (下一个引用)" })
map({ "n" }, "[[", function() Snacks.words.jump(-1, true) end, { desc = "Prev Reference (上一个引用)" })
map({ "n", "t" }, "<C-\\>", function() Snacks.terminal.toggle() end, opts)
