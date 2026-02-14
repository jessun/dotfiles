local function blink_theme()
	local set_hl = vim.api.nvim_set_hl
	local nord = require("utils.nord")
	-- 菜单与文档背景
	set_hl(0, "BlinkCmpMenu", { fg = nord.base.fg, bg = nord.nord3 })
	set_hl(0, "BlinkCmpDoc", { fg = nord.base.fg, bg = nord.nord3 })
	set_hl(0, "BlinkCmpSource", { fg = nord.base.fg, bg = nord.nord3 })
	set_hl(0, "BlinkCmpLabelDetail", { fg = nord.base.fg, bg = nord.nord3 })
	set_hl(0, "BlinkCmpLabelDescription", { fg = nord.base.fg, bg = nord.nord3 })

	-- 选中项 (橙色高亮)
	set_hl(0, "BlinkCmpMenuSelection", {
		fg = nord.base.fg_highlight,
		bg = nord.accents.orange,
		bold = true,
	})

	-- 细节元素
	set_hl(0, "BlinkCmpLabelMatch", { fg = nord.accents.cyan, bold = true }) -- 匹配字
	set_hl(0, "BlinkCmpGhostText", { fg = nord.base.comment, italic = true }) -- 幽灵文字
	set_hl(0, "BlinkCmpDocBorder", { fg = nord.accents.blue, bg = nord.nord3 }) -- 边框

	-- 滚动条
	set_hl(0, "BlinkCmpScrollBarThumb", { bg = nord.nord4 })
	set_hl(0, "BlinkCmpScrollBarGutter", { bg = nord.nord3 })

	local kind_colors = {
		-- 代码逻辑类 (Cyan / Blue)
		Function = nord.accents.cyan, -- Nord8 (冰蓝)
		Method = nord.accents.cyan, -- Nord8
		Constructor = nord.accents.blue, -- Nord9 (天蓝)

		-- 数据结构类 (Teal / Yellow)
		Class = nord.accents.teal, -- Nord7 (蓝绿)
		Interface = nord.accents.teal,
		Struct = nord.accents.teal,
		Enum = nord.accents.yellow, -- Nord13 (黄)
		EnumMember = nord.accents.yellow,

		-- 变量与常量 (White / Orange)
		Variable = nord.base.fg, -- Nord4 (白/普通)
		Field = nord.base.fg,
		Property = nord.base.fg,
		Constant = nord.accents.orange, -- Nord12 (橙)

		-- 关键字与操作符 (Purple)
		Keyword = nord.accents.purple, -- Nord15 (紫)
		Operator = nord.accents.purple,
		TypeParameter = nord.accents.purple,

		-- 文本与文件 (Gray / Blue)
		Text = nord.base.comment, -- Nord3 (灰)
		File = nord.accents.blue,
		Folder = nord.accents.blue,

		-- 片段 (Green)
		Snippet = nord.accents.green, -- Nord14 (绿)

		-- 其他
		Event = nord.accents.yellow,
		Module = nord.accents.blue,
		Unit = nord.accents.orange,
	}

	-- 2. 循环自动生成高亮组
	--    生成格式: BlinkCmpKindFunction, BlinkCmpKindMethod ...
	for kind, color in pairs(kind_colors) do
		set_hl(0, "BlinkCmpKind" .. kind, { fg = color, bg = "NONE" })
	end
end

return {
	"saghen/blink.cmp",
	cond = vim.g.enable_blink,
	build = "cargo build --release",
	dependencies = {
		"Kaiser-Yang/blink-cmp-avante",
		"Kaiser-Yang/blink-cmp-dictionary",
		"Kaiser-Yang/blink-cmp-git",
		"bydlw98/blink-cmp-env",
		"disrupted/blink-cmp-conventional-commits",
		"erooke/blink-cmp-latex",
		"hrsh7th/cmp-nvim-lsp-document-symbol",
		"mgalliou/blink-cmp-tmux",
		"mikavilpas/blink-ripgrep.nvim",
		"quangnguyen30192/cmp-nvim-tags",
		"saghen/blink.compat",
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
		},
	},
	config = function(_, opts)
		opts = {
			keymap = {
				preset = "default",
				["<Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
				["<CR>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = { "snippet_backward", "fallback" },
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "normal",
			},

			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap

			-- (Default) Only show the documentation popup when manually triggered
			completion = {
				menu = {
					border = "",
					draw = {
						-- 定义列：图标、标签(文字)、来源名称
						columns = {
							{ "label", gap = 1 },
							-- { "label_description", gap = 1 },
							-- { "kind_icon" },
							{ "kind" },
							{ "source_name" },
						},
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200, -- 可选：稍微增加延迟，避免快速移动光标时窗口乱闪
					window = {
						border = "", -- 关键：设置为 "single", "rounded" 或 "padded"
						-- 确保边框有宽度，这样 Blink 才能正确计算两个窗口的间距
					},
				},
			},
			signature = {
				enabled = true,
				-- window = { border = "single" },
			},
			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer", -- default
					"lazydev",
					"avante",
					"git",
					"conventional_commits",
					"dictionary",
					"env",
					"tmux",
					"latex",
					"tags",
					"ripgrep",
				},
				providers = {
					lsp = {
						fallbacks = {},
						score_offset = 100,
					},
					snippets = {
						score_offset = -10,
					},
					dictionary = {
						module = "blink-cmp-dictionary",
						name = "Dict",
						-- Make sure this is at least 2.
						-- 3 is recommended
						min_keyword_length = 4,
						opts = {
							-- options for blink-cmp-dictionary
							dictionary_files = {
								vim.fn.expand("~/.config/nvim/dicts/personal"),
								vim.fn.expand("/usr/share/dict/words"),
							},
							dictionary_directories = {},
						},
						score_offset = -1000, -- 提高搜索时的优先级
					},
					nvim_lsp_document_symbol = {
						name = "nvim_lsp_document_symbol",
						module = "blink.compat.source",
						score_offset = -3, -- 提高搜索时的优先级
					},
					latex = {
						name = "Latex",
						module = "blink-cmp-latex",
						opts = {
							-- set to true to insert the latex command instead of the symbol
							insert_command = false,
						},
					},
					tmux = {
						module = "blink-cmp-tmux",
						name = "tmux",
						-- default options
						opts = {
							all_panes = false,
							capture_history = false,
							-- only suggest completions from `tmux` if the `trigger_chars` are
							-- used
							triggered_only = false,
							trigger_chars = { "." },
						},
					},
					env = {
						name = "Env",
						module = "blink-cmp-env",
						--- @type blink-cmp-env.Options
						opts = {
							item_kind = require("blink.cmp.types").CompletionItemKind.Variable,
							show_braces = false,
							show_documentation_window = true,
						},
					},
					conventional_commits = {
						name = "Conventional Commits",
						module = "blink-cmp-conventional-commits",
						enabled = function()
							return vim.bo.filetype == "gitcommit"
						end,
						---@module 'blink-cmp-conventional-commits'
						---@type blink-cmp-conventional-commits.Options
						opts = {}, -- none so far
						score_offset = -10,
					},
					lazydev = {
						name = "lazydev",
						module = "lazydev.integrations.blink", -- 使用原生模块
					},
					tags = {
						name = "tags",
						module = "blink.compat.source",
						score_offset = -3,
						enabled = false,
					},
					avante = {
						module = "blink-cmp-avante",
						name = "Avante",
						opts = { -- options for blink-cmp-avante
						},
					},
					git = {
						module = "blink-cmp-git",
						name = "Git",
						opts = { -- options for the blink-cmp-git
						},
						score_offset = -3,
					},
					ripgrep = {
						score_offset = -1,
						module = "blink-ripgrep",
						name = "Ripgrep",
						-- see the full configuration below for all available options
						---@module "blink-ripgrep"
						---@type blink-ripgrep.Options
						opts = {
							backend = {
								use = "gitgrep-or-ripgrep",
							},
						},
					},
				},
				per_filetype = {
					lua = { "lsp", "path", "snippets", "buffer", "lazydev" },
					gitcommit = { "git", "conventional_commits", "buffer" },
					rust = { "lsp", "path", "snippets", "buffer", "env", "dictionary", "tmux", "ripgrep" },
					go = { "lsp", "path", "snippets", "buffer", "env", "dictionary", "tmux" },
					toml = { "path", "buffer", "ripgrep" },
				},
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = {
				implementation = "prefer_rust_with_warning",
				sorts = {
					"score", -- Primary sort: by fuzzy matching score
					"sort_text", -- Secondary sort: by sortText field if scores are equal
					"label", -- Tertiary sort: by label if still tied
				},
			},
			cmdline = {
				enabled = true, -- 确保启用

				-- 在这里定义源
				sources = function()
					local type = vim.fn.getcmdtype()

					-- 搜索模式 (/ 或 ?) -> 启用 buffer 和 symbol
					if type == "/" or type == "?" then
						return { "buffer", "nvim_lsp_document_symbol" }
					end

					-- 命令模式 (:) -> 启用 cmdline
					if type == ":" then
						return { "cmdline" }
					end

					return {}
				end,

				keymap = {
					preset = "super-tab", -- 命令行里通常习惯用 Tab 选词
					["<Tab>"] = { "show_and_insert_or_accept_single", "select_next" },
					["<S-Tab>"] = { "show_and_insert_or_accept_single", "select_prev" },

					["<C-space>"] = { "show", "fallback" },

					["<C-n>"] = { "select_next", "fallback" },
					["<C-p>"] = { "select_prev", "fallback" },
					["<Right>"] = { "select_next", "fallback" },
					["<Left>"] = { "select_prev", "fallback" },

					["<C-y>"] = { "select_and_accept", "fallback" },
					["<C-e>"] = { "cancel", "fallback" },
				},
				completion = {
					menu = { auto_show = true },
					ghost_text = { enabled = true },
				},
			},
		}
		require("blink.cmp").setup(opts)
		blink_theme()
	end,
}
