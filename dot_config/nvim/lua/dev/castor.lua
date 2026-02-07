local M = {}

-- 辅助函数：获取选中的文本
local function get_visual_selection()
	-- 获取可视模式选区的起始和结束位置
	local _, srow, scol, _ = unpack(vim.fn.getpos("v"))
	local _, erow, ecol, _ = unpack(vim.fn.getpos("."))

	-- 修正方向（如果你是从下往上选的，要交换一下）
	if srow > erow or (srow == erow and scol > ecol) then
		srow, erow = erow, srow
		scol, ecol = ecol, scol
	end

	-- 获取行内容
	local lines = vim.api.nvim_buf_get_lines(0, srow - 1, erow, false)
	if #lines == 0 then
		return ""
	end

	-- 处理行内选区（掐头去尾）
	-- 注意：vim 列是 1-based，API 是 0-based，且包含多字节字符处理
	-- 这里做一个简化的处理，适用于行选模式 (Visual Line) 最为稳健
	-- 如果是字符选择，逻辑会复杂一些，建议主要配合 Visual Line Mode (V) 使用
	return table.concat(lines, "\n")
end

-- 核心函数
function M.ask_castor(opts)
	local mode = vim.api.nvim_get_mode().mode
	local bufnr = vim.api.nvim_get_current_buf()
	local input_text = ""
	local insert_line = -1 -- -1 表示在文件末尾追加

	-- 1. 确定输入内容和插入位置
	if opts.range == 2 then
		-- 如果是通过选区调用的 (:InVisualMode)
		input_text = get_visual_selection()
		-- 插入位置设为选区结束的下一行
		local _, erow, _, _ = unpack(vim.fn.getpos("'>"))
		insert_line = erow
	else
		-- 普通模式：全文件
		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		input_text = table.concat(lines, "\n")
		insert_line = -1
	end

	-- 2. 只有在文本不为空时才发送
	if input_text == "" then
		vim.notify("Castor: No text selected or empty buffer.", vim.log.levels.WARN)
		return
	end

	-- 3. 在编辑器中插入 "## Model" 标记，让用户知道 AI 开始说话了
	-- 这里的逻辑是：如果是全文件，加在最后；如果是选区，加在选区下面
	vim.schedule(function()
		local header = { "", "## Model", "" }
		if insert_line == -1 then
			vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, header)
		else
			vim.api.nvim_buf_set_lines(bufnr, insert_line, insert_line, false, header)
			insert_line = insert_line + #header -- 更新写入位置，跳过标题
		end
	end)

	-- 4. 异步调用 Rust CLI
	vim.system({ "castor" }, {
		stdin = input_text,
		stdout = function(err, data)
			if data then
				vim.schedule(function()
					if not vim.api.nvim_buf_is_valid(bufnr) then
						return
					end

					-- 将收到的数据按行分割
					local chunks = vim.split(data, "\n", { plain = true })

					-- 这里有一个简化的流式追加逻辑
					-- 真正的流式处理需要处理“半行”数据，但为了代码清晰，
					-- 我们假设 castor 每次 flush 都在合理的边界，或者简单地追加到最后一行

					if insert_line == -1 then
						-- 追加到文件末尾 (Append Mode)
						local last_row = vim.api.nvim_buf_line_count(bufnr)
						local last_line_content = vim.api.nvim_buf_get_lines(bufnr, last_row - 1, last_row, false)[1]

						-- 拼接第一块到当前最后一行
						vim.api.nvim_buf_set_lines(
							bufnr,
							last_row - 1,
							last_row,
							false,
							{ last_line_content .. chunks[1] }
						)

						-- 如果有更多行，直接追加
						if #chunks > 1 then
							local extra = {}
							for i = 2, #chunks do
								table.insert(extra, chunks[i])
							end
							vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, extra)
						end
					else
						-- 插入到指定行 (Insert Mode)
						-- 注意：插入模式下的流式更新比较复杂，
						-- 简单起见，我们这里暂且将选区模式的输出也追加到文件最末尾，
						-- 或者你也可以在此处实现复杂的插入光标逻辑。
						-- 为了演示稳定性，这里演示“追加到文件末尾”是体验最好的。
						-- 如果一定要插在中间，需要维护一个动态的 current_row 变量。

						local last_row = vim.api.nvim_buf_line_count(bufnr)
						local last_line_content = vim.api.nvim_buf_get_lines(bufnr, last_row - 1, last_row, false)[1]
						vim.api.nvim_buf_set_lines(
							bufnr,
							last_row - 1,
							last_row,
							false,
							{ last_line_content .. chunks[1] }
						)
						if #chunks > 1 then
							local extra = {}
							for i = 2, #chunks do
								table.insert(extra, chunks[i])
							end
							vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, extra)
						end
					end
				end)
			end
		end,
		stderr = function(err, data)
			if data and data ~= "" then
				vim.schedule(function()
					vim.notify("Castor Error: " .. data, vim.log.levels.ERROR)
				end)
			end
		end,
	}, function(obj)
		vim.schedule(function()
			if obj.code == 0 then
				vim.notify("Castor finished.", vim.log.levels.INFO)
			end
		end)
	end)
end

-- 创建用户命令 :Castor
-- -range=2 允许它接受选区
vim.api.nvim_create_user_command("Castor", M.ask_castor, { range = 2 })

-- 设置快捷键
-- Normal 模式：发送全文件
vim.keymap.set("n", "<leader>cc", ":Castor<CR>", { desc = "Castor Chat (File)" })
-- Visual 模式：发送选区
vim.keymap.set("v", "<leader>cc", ":Castor<CR>", { desc = "Castor Chat (Selection)" })

return M
