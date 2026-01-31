-- lua/utils.lua
local M = {}

--- 使用 dofile 安全加载指定路径的文件 (保留这个以兼容你的 Coc 配置)
--- 适用于加载任意路径的文件，例如 safe_dofile("/abs/path/to/file.lua")
--- @param path string 文件的绝对路径
function M.safe_dofile(path)
    if vim.fn.filereadable(path) == 1 then
        local status, err = pcall(dofile, path)
        if not status then
            vim.notify(
                "加载文件失败 [" .. path .. "]:\n" .. err,
                vim.log.levels.ERROR
            )
        end
    else
        vim.notify("文件不存在: " .. path, vim.log.levels.WARN)
    end
end

--- 加载 data 目录下的配置文件
--- @param filepath string 相对路径，例如 "lazy/coc.nvim/doc/coc-example-config.lua"
function M.load_data_config(filepath)
    --vim.fn.stdpath("data"): ~/.local/share/nvim/
    local path = vim.fs.joinpath(vim.fn.stdpath("data"), filepath)
    -- 注意：这里必须用 safe_dofile，因为 filepath 生成的是绝对路径，
    -- 且该文件通常不在 lua 的 require 搜索路径中，require 无法加载它。
    M.safe_dofile(path)
end

return M
