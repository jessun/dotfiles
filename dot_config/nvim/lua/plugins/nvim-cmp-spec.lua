local function cmp_theme()
	local set_hl = vim.api.nvim_set_hl
	local nord = require("utils.nord")
	-- CmpNormal: 补全菜单的背景
	set_hl(0, "CmpNormal", { bg = nord.base.comment, fg = nord.base.fg })
	-- CmpBorder: 边框颜色
	set_hl(0, "CmpBorder", { bg = nord.accents.blue })
	-- CmpSel: 被选中的条目
	set_hl(0, "CmpSel", { bg = nord.accents.orange, fg = nord.base.fg_highlight, bold = true })
	-- 列表文字
	set_hl(0, "CmpItemAbbr", { fg = nord.base.fg })
	set_hl(0, "CmpItemAbbrDeprecated", { fg = nord.base.comment, strikethrough = true })
	-- 幽灵文字
	set_hl(0, "CmpGhostText", { fg = nord.base.comment, italic = true })
	-- 匹配与来源
	set_hl(0, "CmpItemAbbrMatch", { fg = nord.accents.cyan, bold = true })
	set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = nord.accents.cyan, bold = true })
	set_hl(0, "CmpItemMenu", { fg = nord.accents.blue, italic = true })

	-- (可选) 文档悬浮窗的颜色，可以稍微浅一点区分
	set_hl(0, "CmpDoc", { bg = nord.nord3, fg = nord.base.fg })
	set_hl(0, "CmpDocBorder", { bg = nord.accents.blue })
	-- 灰白色系：文本、变量
	set_hl(0, "CmpItemKindVariable", { fg = nord.base.fg })
	set_hl(0, "CmpItemKindText", { fg = nord.base.fg })

	-- 蓝色系：函数、方法
	set_hl(0, "CmpItemKindFunction", { fg = nord.accents.cyan })
	set_hl(0, "CmpItemKindMethod", { fg = nord.accents.cyan })

	-- 绿色系：字符串、类
	set_hl(0, "CmpItemKindKeyword", { fg = nord.accents.blue })
	set_hl(0, "CmpItemKindProperty", { fg = nord.accents.blue })
	set_hl(0, "CmpItemKindUnit", { fg = nord.accents.blue })

	-- 黄橙色系：类、结构体
	set_hl(0, "CmpItemKindClass", { fg = nord.accents.yellow })
	set_hl(0, "CmpItemKindStruct", { fg = nord.accents.yellow })
	set_hl(0, "CmpItemKindInterface", { fg = nord.accents.yellow })

	-- 红色系：片段 (Snippet)
	set_hl(0, "CmpItemKindSnippet", { fg = nord.accents.red })
end

return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	cond = vim.g.enable_nvim_cmp,
	dependencies = {
		"hrsh7th/cmp-buffer", -- 来源：当前 Buffer 内容
		"hrsh7th/cmp-cmdline", -- 来源：命令行
		"hrsh7th/cmp-nvim-lsp", -- 来源：LSP
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-nvim-lsp-document-symbol",
		"hrsh7th/cmp-path", -- 来源：文件路径
		"lukas-reineke/cmp-under-comparator",
		"quangnguyen30192/cmp-nvim-tags",
		"saadparwaiz1/cmp_luasnip", -- 桥接：LuaSnip 到 CMP
		{ "L3MON4D3/LuaSnip", ft = "lua", dependencies = { "rafamadriz/friendly-snippets" } },
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
		},
		{
			"uga-rosa/cmp-dictionary",
			opts = {
				paths = {
					"/usr/share/dict/words",
					"~/.config/nvim/dicts/personal",
				},
				exact_length = 4,
				first_case_insensitive = true,
			},
		},
	},
	opts = {},
	config = function(_, opts)
		local luasnip = require("luasnip")
		local cmp = require("cmp")

		opts.snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		}
		opts.window = {
			completion = {
				border = "none",
				scrollbar = true,
				winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None",
			},
			documentation = {
				border = "none",
				scrollbar = true,
				winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder,CursorLine:CmpSel,Search:None",
			},
		}
		opts.sources = cmp.config.sources({
			{ name = "nvim_lsp", priority = 1000 }, -- 最高优先级：LSP 建议
			{ name = "nvim_lsp_signature_help", priority = 900 },
			{ name = "path", priority = 700 }, -- 路径
			{ name = "buffer", priority = 600 }, -- Buffer 内单词
			{ name = "lazydev", priority = 500 },
			{ name = "luasnip", priority = 300 }, -- 代码片段
		}, {
			{ name = "dictionary", keyword_length = 2 },
			{
				name = "tags",
				option = {
					-- this is the default options, change them if you want.
					-- Delayed time after user input, in milliseconds.
					complete_defer = 100,
					-- Max items when searching `taglist`.
					max_items = 10,
					-- The number of characters that need to be typed to trigger
					-- auto-completion.
					keyword_length = 4,
					-- Use exact word match when searching `taglist`, for better searching
					-- performance.
					exact_match = true,
					-- Prioritize searching result for current buffer.
					current_buffer_only = false,
				},
			},
		})
		opts.mapping = cmp.mapping.preset.insert({
			["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
			["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
			["<C-b>"] = cmp.mapping.scroll_docs(-4), -- 文档向上翻页
			["<C-f>"] = cmp.mapping.scroll_docs(4), -- 文档向下翻页
			["<C-Space>"] = cmp.mapping.complete(), -- 手动触发补全
			["<C-e>"] = cmp.mapping.abort(), -- 关闭补全窗口

			["<C-y>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				elseif require("luasnip").expand_or_jumpable() then
					require("luasnip").expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
				elseif require("luasnip").jumpable(-1) then
					require("luasnip").jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		})
		opts.formatting = {
			format = function(entry, vim_item)
				local max_width = 40

				local label = vim_item.abbr
				local truncated_label = vim.fn.strcharpart(label, 0, max_width)

				if truncated_label ~= label then
					vim_item.abbr = truncated_label .. "..."
				end
				return vim_item
			end,
			sorting = {
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					require("cmp-under-comparator").under,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
		}
		cmp.setup(opts)
		-- `/` cmdline setup.
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "nvim_lsp_document_symbol" },
			}, {
				{ name = "buffer" },
			}),
		})
		-- `:` cmdline setup.
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})

		cmp_theme()
	end,
}
