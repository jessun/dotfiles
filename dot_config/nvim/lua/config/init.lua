vim.g.enable_coc = true
vim.g.enable_native_lsp = true
vim.g.enable_blink = false
vim.g.enable_nvim_cmp = true

local env_coc = os.getenv("COC")
vim.g.enable_coc = (env_coc == "true" or env_coc == "1")

if vim.g.enable_coc then
	vim.g.enable_native_lsp = false
	vim.g.enable_blink = false
	vim.g.enable_nvim_cmp = false
end

if vim.g.enable_blink then
	vim.g.enable_nvim_cmp = false
end

require("config.lazy")
