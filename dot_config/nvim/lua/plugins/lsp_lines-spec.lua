return {
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	init = function()
		vim.diagnostic.config({
			float = { border = "single" },
			virtual_text = true,
			virtual_lines = false,
		})
	end,
	opts = {},
	keys = {
		{
			"<F4>",
			function()
				require("lsp_lines").toggle()
			end,
			mode = { "n" },
			desc = "",
		},
	},
}
