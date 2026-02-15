return {
	"kevinhwang91/nvim-hlslens",
	opts = {},
	keys = {
		{ "/", mode = "n" },
		{ "?", mode = "n" },
		{
			"n",
			"<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>",
			mode = { "n" },
			desc = "Hlslens next",
		},
		{
			"N",
			"<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>",
			mode = { "n" },
			desc = "Hlslens prev",
		},
		{
			"*",
			"*<Cmd>lua require('hlslens').start()<CR>",
			mode = { "n" },
			desc = "Hlslens *",
		},
		{
			"#",
			"#<Cmd>lua require('hlslens').start()<CR>",
			mode = { "n" },
			desc = "Hlslens #",
		},
		{
			"g*",
			"g*<Cmd>lua require('hlslens').start()<CR>",
			mode = { "n" },
			desc = "Hlslens g*",
		},
		{
			"g#",
			"g#<Cmd>lua require('hlslens').start()<CR>",
			mode = { "n" },
			desc = "Hlslens g#",
		},
	},
}
