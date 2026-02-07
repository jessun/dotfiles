return {
	"L3MON4D3/LuaSnip",
	dependencies = { "rafamadriz/friendly-snippets" },
	opts = {},
	keys = {
		{
			"<c-k>",
			function()
				require("luasnip").expand()
			end,
			mode = { "i" },
			desc = "Luasnip: expand",
		},
		{
			"<c-l>",
			function()
				require("luasnip").jump(1)
			end,
			mode = { "i", "s" },
			desc = "Luasni: jump next",
		},
		{
			"<c-j>",
			function()
				require("luasnip").jump(-1)
			end,
			mode = { "i", "s" },
			desc = "Luasni: jump next",
		},
		{
			"<c-e>",
			function()
				local ls = require("luasnip")
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end,
			mode = { "i", "s" },
			desc = "Luasni: abort",
		},
	},
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load({
			paths = { vim.fn.expand("~/.config/nvim/snippets") },
		})
	end,
}
