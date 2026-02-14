local function coc_init()
	vim.g.coc_config_home = vim.fn.stdpath("config")
	vim.g.coc_data_home = vim.fn.stdpath("data") .. "/coc"

	-- Global extension list
	vim.g.coc_global_extensions = {
		"coc-dictionary",
		"coc-emoji",
		"coc-explorer",
		"coc-extension-codemod",
		"coc-git",
		"coc-go",
		"coc-highlight",
		"coc-json",
		"coc-lists",
		"coc-lua",
		"coc-marketplace",
		"coc-rust-analyzer",
		"coc-snippets",
		"coc-spell-checker",
		"coc-syntax",
		"coc-tag",
		"coc-translator",
		"coc-vimlsp",
		"coc-word",
		"coc-yank",
	}
end

-- 这是一个精简后的 config 函数，只保留了核心逻辑和极少数无法简单迁移的映射
local function coc_cfg()
	vim.filetype.add({
		pattern = { ["coc-settings.json"] = "jsonc" },
	})

	-- 1. Helper Functions (Global)
	function _G.check_back_space()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
	end

	function _G.coc_grep_from_selected(type)
		local saved_reg = vim.fn.getreg('"')
		if type == nil then
			vim.cmd("normal! gvy")
		elseif type == "line" then
			vim.cmd("normal! '[V']y")
		else
			vim.cmd("normal! `[v`]y")
		end
		local text = vim.fn.getreg('"')
		vim.fn.setreg('"', saved_reg)
		if #text > 0 then
			text = text:gsub("\n", "")
			vim.cmd("CocList grep " .. text)
		end
	end

	-- 2. Go syntax settings
	-- vim.g.go_highlight_build_constraints = 1
	-- vim.g.go_highlight_fields = 1
	-- vim.g.go_highlight_functions = 1
	-- vim.g.go_highlight_methods = 1
	-- vim.g.go_highlight_operators = 1
	-- vim.g.go_highlight_structs = 1
	-- vim.g.go_highlight_types = 1

	local set_hl = vim.api.nvim_set_hl
	local nord = require("utils.nord")
	set_hl(0, "CocHighlightText", { bg = nord.accents.orange, fg = nord.base.bg })
	set_hl(0, "CocErrorHighlight", { bg = nord.diagnostic.error, fg = nord.base.bg })
	set_hl(0, "CocWarnHighlight", { bg = nord.diagnostic.warn, fg = nord.base.bg })
	set_hl(0, "CocInfoHighlight", { bg = nord.diagnostic.info, fg = nord.base.bg })
	set_hl(0, "CocHintHighlight", { bg = nord.diagnostic.hint, fg = nord.base.bg })

	set_hl(0, "CocFloating", { bg = nord.nord2, fg = nord.base.fg })
	set_hl(0, "CocSearch", { bg = nord.nord2, fg = nord.nord8 })
	set_hl(0, "CocMenuSel", { bg = nord.accents.orange, fg = nord.base.fg })

	-- 3. Spell Checker Command
	vim.api.nvim_create_user_command("CleanList", function(opts)
		local start_line = opts.line1
		local end_line = opts.line2
		vim.cmd(string.format('%d,%ds/^\\s*"\\([^"]*\\)",\\?\\s*$/\\1/e', start_line, end_line))
	end, { range = true })

	-- 4. Snippet Jump Variables
	vim.g.coc_snippet_next = "<c-n>"
	vim.g.coc_snippet_prev = "<c-p>"

	-- ⚠️ Super TAB (Complex expr mapping)
	-- Lazy keys handle expr mappings okay, but for critical completion logic,
	-- keeping it in config is safer and cleaner than a giant string in table.
	local opts_expr = { silent = true, expr = true, replace_keycodes = false }
	vim.keymap.set(
		"i",
		"<TAB>",
		"coc#pum#visible() ? coc#_select_confirm() : "
			.. 'coc#expandableOrJumpable() ? coc#rpc#request("doKeymap", ["snippets-expand-jump", ""]) : '
			.. 'v:lua.check_back_space() ? "<TAB>" : '
			.. "coc#refresh()",
		opts_expr
	)

	-- Grep by motion (Operator pending) - Hard to lazy load purely via keys
	vim.keymap.set("n", "<leader>g", function()
		vim.go.operatorfunc = "v:lua.coc_grep_from_selected"
		return "g@"
	end, { expr = true, silent = true, desc = "Coc Grep Motion" })
end

local keys_cfg = {
	-- --- Advanced Functions ---
	{
		"<leader>g",
		":<C-u>lua _G.coc_grep_from_selected(nil)<CR>",
		mode = "x",
		desc = "Coc Grep Selection",
	},

	-- Smart Multi-Cursor (<C-x>)
	{
		"<C-x>",
		function()
			local activated = vim.b.coc_cursors_activated or 0
			if activated == 0 then
				return vim.api.nvim_replace_termcodes("<Plug>(coc-cursors-word)", true, true, true)
			else
				return vim.api.nvim_replace_termcodes("*<Plug>(coc-cursors-word):nohlsearch<CR>", true, true, true)
			end
		end,
		mode = "n",
		expr = true,
		desc = "Coc Smart Cursors",
	},

	-- --- Diagnostic ---
	{
		"[a",
		":<C-u>CocPrev<CR>",
		desc = "Prev Diagnostic",
	},
	{
		"]a",
		":<C-u>CocNext<CR>",
		desc = "Next Diagnostic",
	},

	-- --- Coc List ---
	{
		"<leader>ce",
		"<Cmd>CocCommand explorer<CR>",
		desc = "Coc Explorer",
	},
	{
		"<leader>cd",
		":<C-u>CocList --auto-preview diagnostics<cr>",
		desc = "Coc Diagnostics List",
	},
	{
		"<leader>cc",
		":CocList commands<CR>",
		desc = "Coc Commands",
	},
	{
		"<leader>c/",
		":<C-u>CocList --interactive --auto-preview grep<CR>",
		desc = "Coc Interactive Grep",
	},

	{
		"<leader>cm",
		":CocList maps<CR>",
		mode = { "n", "x" },
		desc = "Coc Maps",
	},
	{
		"<leader>ck",
		":CocList marks<CR>",
		mode = { "n", "x" },
		desc = "Coc Marks",
	},
	{
		"<leader>cf",
		":<C-u>CocList --auto-preview files<CR>",
		mode = { "n", "x" },
		desc = "Coc Files",
	},
	{
		"<leader>cb",
		":CocList --auto-preview buffers<CR>",
		mode = { "n", "x" },
		desc = "Coc Buffers",
	},
	{
		"<leader>co",
		"<cmd>CocOutline<CR>",
		mode = { "n", "x" },
		desc = "Coc Outline",
	},

	-- --- Code Action ---
	{
		"<leader>cs",
		"<Plug>(coc-codeaction-selected)",
		mode = { "n", "x" },
		desc = "Code Action Selected",
	},
	{
		"<leader>ca",
		"<Plug>(coc-codeaction)",
		mode = { "n", "x" },
		desc = "Code Action",
	},

	-- --- Snippets ---
	{
		"<C-l>",
		"<Plug>(coc-snippets-expand)",
		mode = "i",
		desc = "Snippet Expand",
	},
	{
		"<C-j>",
		"<Plug>(coc-snippets-select)",
		mode = "v",
		desc = "Snippet Select",
	},
	{
		"<C-j>",
		"<Plug>(coc-snippets-expand-jump)",
		mode = "i",
		desc = "Snippet Expand/Jump",
	},
	{
		"<leader>x",
		"<Plug>(coc-convert-snippet)",
		mode = "x",
		desc = "Convert Snippet",
	},

	-- --- Git ---
	{
		"[h",
		"<Plug>(coc-git-prevchunk)",
		desc = "Git Prev Chunk",
	},
	{
		"]h",
		"<Plug>(coc-git-nextchunk)",
		desc = "Git Next Chunk",
	},
	{
		"[c",
		"<Plug>(coc-git-prevconflict)",
		desc = "Git Prev Conflict",
	},
	{
		"]c",
		"<Plug>(coc-git-nextconflict)",
		desc = "Git Next Conflict",
	},
	{
		"gs",
		"<Plug>(coc-git-chunkinfo)",
		desc = "Git Chunk Info",
	},
	{
		"gc",
		"<Plug>(coc-git-commit)",
		desc = "Git Commit",
	},
	{
		"ig",
		"<Plug>(coc-git-chunk-inner)",
		mode = { "o", "x" },
		desc = "Git Chunk Inner",
	},
	{
		"ag",
		"<Plug>(coc-git-chunk-outer)",
		mode = { "o", "x" },
		desc = "Git Chunk Outer",
	},
	{
		"cb",
		"<Plug>(coc-git-keepboth)",
		mode = { "n", "o" },
		desc = "Git Keep Both",
	},
	{
		"co",
		"<Plug>(coc-git-keepcurrent)",
		mode = { "n", "o" },
		desc = "Git Keep Current",
	},
	{
		"ct",
		"<Plug>(coc-git-keepincoming)",
		mode = { "n", "o" },
		desc = "Git Keep Incoming",
	},

	-- --- Translator ---
	{
		"<Leader>ct",
		"<Plug>(coc-translator-p)",
		desc = "Translate",
	},
	{
		"<Leader>ct",
		"<Plug>(coc-translator-pv)",
		mode = "v",
		desc = "Translate Selection",
	},

	-- --- Quick Access ---
	{
		"<F2>",
		"<Cmd>CocCommand explorer<CR>",
		desc = "Explorer (F2)",
	},
	{
		"<leader><leader>",
		":<C-u>CocList --auto-preview files<CR>",
		desc = "Find Files",
	},
	{
		"<leader>b",
		"<Cmd>CocList --auto-preview buffers<CR>",
		desc = "Buffers",
	},
	{
		"<leader>d",
		"<Cmd>CocList --auto-preview diagnostics<CR>",
		desc = "Diagnostics",
	},
	{
		"<leader>e",
		"<Cmd>CocCommand explorer<CR>",
		desc = "Explorer",
	},
	{ "<leader>m", "<Cmd>CocList maps<CR>", desc = "Maps" },
	{
		"<leader>o",
		"<cmd>CocOutline<CR>",
		mode = { "n", "x" },
		desc = "Outline",
	},
	{
		"<leader>/",
		":<C-u>CocList --interactive --auto-preview grep --ignore-case --regexp<CR>",
		desc = "Interactive Grep",
	},
	-- { "<leader>y",        ":<C-u>CocList yank<CR>",                                                     desc = "Yank List" },
	{
		"<leader><F3>",
		function()
			-- 1. 定义 Outline 窗口的文件类型 (CocOutline 默认通常是 coctree)
			local outline_ft = "coctree"

			-- 2. 遍历所有窗口，查找是否存在该文件类型的窗口
			local wins = vim.api.nvim_list_wins()
			for _, win in ipairs(wins) do
				local buf = vim.api.nvim_win_get_buf(win)
				local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })

				if ft == outline_ft then
					-- A. 如果找到了，说明已经打开，直接关闭该窗口
					vim.api.nvim_win_close(win, true)
					return
				end
			end

			-- B. 如果循环结束还没找到，说明没打开，执行打开命令
			vim.cmd("CocOutline")
		end,

		mode = { "n", "x" },
		desc = "Outline",
	},

	-- Complex Function Wrappers
	{
		"<leader>W",
		function()
			local cword = vim.fn.expand("<cword>")
			vim.cmd("CocList --interactive --auto-preview --normal --input=" .. cword .. " grep --ignore-case --regexp")
		end,
		desc = "Grep Word (Project)",
	},
	{
		"<leader>w",
		function()
			local cword = vim.fn.expand("<cword>")
			vim.cmd("CocList --interactive --auto-preview --normal --input=" .. cword .. " words")
		end,
		desc = "Search Word (Buffer)",
	},
}

return {
	"neoclide/coc.nvim",
	build = "pnpm i --frozen-lockfile",
	init = coc_init,
	cond = vim.g.enable_coc,
	event = "VeryLazy",
	cmd = { "CocList", "CocCommand", "CocOutline", "CocEnable" },
	keys = keys_cfg,
	config = function(_, opts)
		local utils = require("utils")
		utils.load_data_config("/lazy/coc.nvim/doc/coc-example-config.lua")
		coc_cfg()
	end,
}
