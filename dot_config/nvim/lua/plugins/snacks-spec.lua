return {
	"folke/snacks.nvim",
	version = "*",
	event = "VeryLazy",
	opts = {
		animate = {},
		bufdelete = {},
		dim = {},
		input = {},
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
	},
	keys = {
		{
			"<leader>nz",
			function()
				Snacks.toggle.dim():toggle()
			end,
			mode = { "n" },
			desc = "Snacks: dim toggle",
		},
		{
			"<leader>ni",
			function()
				Snacks.lazygit.open()
			end,
			mode = { "n" },
			desc = "Snacks: lazygit open",
		},
		{
			"<leader>nn",
			function()
				Snacks.notifier.show_history()
			end,
			mode = { "n" },
			desc = "Snacks: show notifier history",
		},
		{
			"<leader>nt",
			function()
				Snacks.toggle.inlay_hints():toggle()
			end,
			mode = { "n" },
			desc = "Snacks: toggle inlay hints",
		},
		{
			"]]",
			function()
				Snacks.words.jump(1, true)
			end,
			mode = { "n" },
			desc = "Snacks: next reference",
		},
		{
			"[[",
			function()
				Snacks.words.jump(-1, true)
			end,
			mode = { "n" },
			desc = "Snacks: prev reference",
		},
		{
			"<F12>",
			function()
				Snacks.terminal.toggle()
			end,
			mode = { "n", "t" },
			desc = "Snacks: prev reference",
		},
	},
	config = function(_, opts)
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
					step = 20, -- ms per step
					total = 300, -- maximum duration
				},
			},
			-- what buffers to dim
			filter = function(buf)
				return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ""
			end,
		}
		local input_cfg = { enabled = true, icon = "" }
		opts.dim = dim_cfg
		opts.input = input_cfg

		vim.ui.input = function(data, on_confirm)
			Snacks.input(data, on_confirm)
		end

		vim.ui.select = function(items, opts, on_choice)
			Snacks.picker.select(items, opts, on_choice)
		end

		Snacks.setup(opts)
	end,
}
