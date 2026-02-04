return {
	"nvim-neo-tree/neo-tree.nvim",
	cond = not vim.g.enable_coc,
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		{
			"s1n7ax/nvim-window-picker",
			opts = { hint = "floating-big-letter" },
		},
	},
	keys = {
		{ "<leader>ce", "<cmd>Neotree toggle<cr>", mode = { "n" }, desc = "Neotree: toggle" },
		{ "<F2>", "<cmd>Neotree toggle<cr>", mode = { "n" }, desc = "Neotree: toggle" },
	},
	opts = {
		filesystem = {
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = false,
			},
		},
		use_popups_for_input = false,
		close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
		default_component_configs = {
			icon = {
				folder_closed = "+",
				folder_open = "-",
				folder_empty = "+",
				folder_empty_open = "-",
				default = "",
			},
			git_status = {
				symbols = {
					-- Change type
					added = "+", -- NOTE: you can set any of these to an empty string to not show them
					deleted = "-",
					modified = "~",
					renamed = "->",
					-- Status type
					untracked = "?",
					ignored = "!",
					unstaged = "?",
					staged = ".",
					conflict = "x",
				},
			},
		},
	},
	window = {},
	config = function(_, opts)
		local events = require("neo-tree.events")
		local function on_move(data)
			-- 1. 检查全局变量 Snacks 是否存在
			-- 2. 检查 rename 模块是否已加载
			-- 3. 检查方法是否存在
			Snacks.rename.on_rename_file(data.source, data.destination)
		end

		opts.event_handlers = {
			{ event = events.FILE_MOVED, handler = on_move },
			{ event = events.FILE_RENAMED, handler = on_move },
		}

		require("neo-tree").setup(opts)
	end,
}
