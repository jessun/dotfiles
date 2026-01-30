return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		opts = {
			install_dir = vim.fn.stdpath('data') .. '/site',
		},
		config = function(_, opts)
			require('nvim-treesitter').setup(opts)
			vim.api.nvim_create_autocmd('FileType', {
				pattern = { '<filetype>' },
				callback = function() vim.treesitter.start() end,
			})
		end
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
		opts = {
			enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
			multiwindow = true, -- Enable multiwindow support.
			max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			line_numbers = true,
			multiline_threshold = 20, -- Maximum number of lines to show for a single context
			trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			separator = nil,
			zindex = 20, -- The Z-index of the context window
			on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
		}
	},
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		event = { "BufReadPost", "BufNewFile" },
		branch = "main",
		init = function()
			vim.g.no_plugin_maps = true
		end,
		opts = {
			select = {
				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,
				-- You can choose the select mode (default is charwise 'v')
				--
				-- Can also be a function which gets passed a table with the keys
				-- * query_string: eg '@function.inner'
				-- * method: eg 'v' or 'o'
				-- and should return the mode ('v', 'V', or '<c-v>') or a table
				-- mapping query_strings to modes.
				selection_modes = {
					['@parameter.outer'] = 'v', -- charwise
					['@function.outer'] = 'V', -- linewise
					-- ['@class.outer'] = '<c-v>', -- blockwise
				},
				-- If you set this to `true` (default is `false`) then any textobject is
				-- extended to include preceding or succeeding whitespace. Succeeding
				-- whitespace has priority in order to act similarly to eg the built-in
				-- `ap`.
				--
				-- Can also be a function which gets passed a table with the keys
				-- * query_string: eg '@function.inner'
				-- * selection_mode: eg 'v'
				-- and should return true of false
				include_surrounding_whitespace = false,
			},
			move = {
				-- whether to set jumps in the jumplist
				set_jumps = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter-textobjects").setup(opts)

			-- -----------------------------------------------------------
			-- 按键映射逻辑
			-- -----------------------------------------------------------
			local map = vim.keymap.set

			-- 提前引用模块，避免重复 require
			local select = require("nvim-treesitter-textobjects.select")
			local swap = require("nvim-treesitter-textobjects.swap")
			local move = require("nvim-treesitter-textobjects.move")
			local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

			-- 1. Select Text Objects (Visual/Operator Pending)
			-- 例如: dam (删除函数), vim (选中函数内部)
			local function map_select(lhs, query, group)
				map({ "x", "o" }, lhs, function() select.select_textobject(query, group) end)
			end

			map_select("am", "@function.outer", "textobjects")
			map_select("im", "@function.inner", "textobjects")
			map_select("ac", "@class.outer", "textobjects")
			map_select("ic", "@class.inner", "textobjects")
			-- 使用 locals.scm 中的定义
			map_select("as", "@local.scope", "locals")


			-- 2. Swap (交换参数)
			map("n", "<leader>a", function() swap.swap_next("@parameter.inner") end)
			map("n", "<leader>A", function() swap.swap_previous("@parameter.outer") end)


			-- 3. Move (跳转到下一个/上一个对象)
			local function map_move(lhs, query, group, method)
				map({ "n", "x", "o" }, lhs, function() move[method](query, group) end)
			end

			-- 跳转到开始
			map_move("]m", "@function.outer", "textobjects", "goto_next_start")
			map_move("]o", { "@loop.inner", "@loop.outer" }, "textobjects", "goto_next_start")
			map_move("]s", "@local.scope", "locals", "goto_next_start")
			map_move("]z", "@fold", "folds", "goto_next_start")
			map_move("[m", "@function.outer", "textobjects", "goto_previous_start")

			-- 跳转到结束
			map_move("]M", "@function.outer", "textobjects", "goto_next_end")
			map_move("][", "@class.outer", "textobjects", "goto_next_end")
			map_move("[M", "@function.outer", "textobjects", "goto_previous_end")
			map_move("[]", "@class.outer", "textobjects", "goto_previous_end")

			-- 颗粒度移动 (start or end)
			map_move("]d", "@conditional.outer", "textobjects", "goto_next")
			map_move("[d", "@conditional.outer", "textobjects", "goto_previous")


			-- 4. Repeatable Move (增强 ; 和 , 以及 f/t)
			-- 确保 ; 永远是向后，, 永远是向前 (忽略上次搜索方向)
			map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
			map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

			-- 让原生的 f, F, t, T 也支持用 ; 和 , 重复
			map({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
			map({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
			map({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
			map({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
		end
	},
}
