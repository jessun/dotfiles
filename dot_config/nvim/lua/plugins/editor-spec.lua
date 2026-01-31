return {
	{ "junegunn/vim-peekaboo" },
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {},
	},
	{
		"hedyhli/outline.nvim",
		cond = not vim.g.enable_coc,
		cmd = { "Outline", "OutlineOpen" },
		opts = {},
		keys = { -- Example mapping to toggle outline
			{ "<leader>o", "<cmd>Outline<CR>", desc = "Outline: toggle" },
			{ "<F3>", "<cmd>Outline<CR>", desc = "Outline: toggle" },
		},
	},
}
