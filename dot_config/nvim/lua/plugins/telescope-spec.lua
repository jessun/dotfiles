return {
	"nvim-telescope/telescope.nvim",
	cond = not vim.g.enable_coc,
	cmd = "Telescope",
	version = false, -- 使用 master 分支，或者用 tag = '0.1.8'
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- 推荐安装 fzf-native 以获得更好的性能 (需要系统安装 make 和 gcc)
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
	},
	-- opts 会自动传递给 require("telescope").setup(opts)
	opts = {
		defaults = {
			sorting_strategy = "ascending",
			layout_config = {
				width = 0.999,
				height = 0.999,
				preview_width = 0.6, -- 预览窗口占 60% 宽度
				preview_cutoff = 0, -- ⚠️ 重要：设置为 0 意味着永远不隐藏预览窗口（即使屏幕很小）
				prompt_position = "top", -- 个人推荐：把搜索框放在顶部
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")

		-- 1. 初始化 Telescope
		telescope.setup(opts)

		-- 2. 加载 fzf 扩展 (必须在 setup 之后)
		-- 使用 pcall 防止因为编译失败导致整个 telescope 崩溃
		local ok, _ = pcall(telescope.load_extension, "fzf")
		if not ok then
			vim.notify(
				"FZF extension failed to load. Try running ':Lazy build telescope-fzf-native.nvim'",
				vim.log.levels.WARN
			)
		end
	end,

	keys = {
		-- ==========================================
		-- 常用快捷键 (Quick Access)
		-- ==========================================
		{ "<leader><leader>", "<cmd>Telescope find_files<cr>", desc = "Telescope: Find Files (Root)" },
		{ "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Telescope: Live Grep (Root)" },
		{ "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Telescope: Buffers" },
		{ "<leader>m", "<cmd>Telescope keymaps<cr>", desc = "Telescope: Keymaps" },
		{ "<leader>d", "<cmd>Telescope diagnostics<cr>", desc = "Telescope: Diagnostics" },

		-- ==========================================
		-- 以 t 开头的分组 (Telescope Prefix)
		-- ==========================================
		{ "<leader>t/", "<cmd>Telescope live_grep<cr>", desc = "Telescope: Live Grep" },
		{ "<leader>tb", "<cmd>Telescope buffers<cr>", desc = "Telescope: Buffers" },
		{ "<leader>tc", "<cmd>Telescope commands<cr>", desc = "Telescope: Commands" },
		{ "<leader>tf", "<cmd>Telescope find_files<cr>", desc = "Telescope: Find Files" },
		{ "<leader>th", "<cmd>Telescope help_tags<cr>", desc = "Telescope: Help Tags" },
		{ "<leader>tk", "<cmd>Telescope marks<cr>", desc = "Telescope: Marks" },
		{ "<leader>tm", "<cmd>Telescope keymaps<cr>", desc = "Telescope: Keymaps" },
		{ "<leader>td", "<cmd>Telescope diagnostics<cr>", desc = "Telescope: Diagnostics" },
		{ "<leader>tr", "<cmd>Telescope registers<cr>", desc = "Telescope: Registers" },

		-- 选择配色方案 (带预览)
		{
			"<leader>to",
			function()
				require("telescope.builtin").colorscheme({ enable_preview = true })
			end,
			desc = "Telescope: Colorscheme with Preview",
		},

		-- ==========================================
		-- 高级搜索 (当前单词)
		-- ==========================================
		-- <leader>w: 在当前 Buffer 中搜索当前光标下的单词
		{
			"<leader>w",
			function()
				require("telescope.builtin").current_buffer_fuzzy_find({
					default_text = vim.fn.expand("<cword>"),
				})
			end,
			desc = "Telescope: Fuzzy Find Word (Current Buffer)",
		},
		-- <leader>W: 在当前 Workspace (项目) 中搜索当前光标下的单词
		{
			"<leader>W",
			function()
				require("telescope.builtin").live_grep({
					default_text = vim.fn.expand("<cword>"),
				})
			end,
			desc = "Telescope: Live Grep Word (Workspace)",
		},
		{
			"gd",
			function()
				require("telescope.builtin").lsp_definitions()
			end,
			mode = { "n" },
			desc = "",
		},
		{
			"gi",
			function()
				require("telescope.builtin").lsp_implementations()
			end,
			mode = { "n" },
			desc = "",
		},
		{
			"gr",
			function()
				require("telescope.builtin").lsp_references()
			end,
			mode = { "n" },
			desc = "",
		},
		{
			"gt",
			function()
				require("telescope.builtin").lsp_type_definitions()
			end,
			mode = { "n" },
			desc = "",
		},
		{
			"gw",
			function()
				require("telescope.builtin").lsp_workspace_symbols()
			end,
			mode = { "n" },
			desc = "",
		},
	},
}
