return {
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	init = function()
		vim.diagnostic.config({
			virtual_text = true,
			virtual_lines = false,
			severity_sort = true,
		})
	end,
	opts = {},
	keys = {
		{
			"<F4>",
			function()
				vim.notify("LSP lines toggle")
				require("lsp_lines").toggle()
			end,
			mode = { "n" },
			desc = "lsp_lines: toggle",
		},
	},
}
