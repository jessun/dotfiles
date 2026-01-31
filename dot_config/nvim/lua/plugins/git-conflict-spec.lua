return {
	"akinsho/git-conflict.nvim",
	version = "*", -- 建议锁定版本
	config = true, -- 让 lazy 自动调用 require("git-conflict").setup(opts)
	opts = {
		default_mappings = {
			ours = "co", -- 选择当前更改 (Current/Ours)
			theirs = "ct", -- 选择传入更改 (Incoming/Theirs)
			none = "c0", -- 都不选
			both = "cb", -- 都要
			next = "]c", -- 下一个冲突
			prev = "[c", -- 上一个冲突
		},
		disable_diagnostics = true, -- 在冲突区域禁用诊断信息（推荐，防止干扰）
	},
	-- 如果你确实想要那个通知功能，可以加上这个 init 或 config
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "GitConflictDetected",
			callback = function(event)
				-- 简单的通知，不依赖外部未定义的函数
				vim.notify("检测到 Git 冲突！", vim.log.levels.WARN, { title = "Git Conflict" })

				-- 可选：如果你想在检测到冲突时自动打开 Quickfix 列表
				-- vim.cmd("copen")
			end,
		})
	end,
}
