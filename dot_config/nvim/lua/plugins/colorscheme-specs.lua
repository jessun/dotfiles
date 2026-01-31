return {
	-- { 'gbprod/nord.nvim' },
	-- { 'nordtheme/vim' },
	{ "AlexvZyl/nordic.nvim" },
	{ "rmehri01/onenord.nvim" },
	{ "fcancelinha/nordern.nvim" },
	{ "a/vim-trash-polka" },

	{ "tanvirtin/monokai.nvim" },
	{ "cocopon/iceberg.vim" },
	{ "rktjmp/lush.nvim" },
	{ "chriskempson/base16-vim" },
	{ "rebelot/kanagawa.nvim" },
	{ "vague-theme/vague.nvim" },
	{ "zenbones-theme/zenbones.nvim" },
	{ "kvrohit/rasmus.nvim" },
	{ "antonk52/lake.nvim" },
	-- no color
	{ "LuRsT/austere.vim" },
	{ "cideM/yui" },
	{ "pgdouyon/vim-yin-yang" },
	{ "kxzk/skull-vim" },
	{ "ntk148v/komau.vim" },
	{ "maxmx03/solarized.nvim" },
	{
		"shaunsingh/nord.nvim",
		lazy = false, -- 必须：确保它在启动时直接加载，不要懒加载
		priority = 1000, -- 必须：确保它比 Lualine/Bufferline 等 UI 插件先加载
		config = function()
			-- 你可以在这里配置主题特定的变量
			vim.g.nord_contrast = true
			vim.g.nord_borders = false

			-- 🔥 核心：在这里执行应用配色的命令
			vim.cmd.colorscheme("nord")
		end,
	},
}
