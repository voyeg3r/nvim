-- File: /data/data/com.termux/files/home/.config/nvim/after/ftplugin/vim.lua
-- Last Change: Tue, Dec 2023/12/05 - 20:05:16

vim.opt_local.keywordprg = ":help"

-- https://github.com/sam4llis/nvim-lua-gf/blob/main/after/ftplugin/vim.lua
-- Options to add `gf` functionality inside `.vim (Lua heredoc)` files.
vim.opt_local.include = [[\v<((do|load)file|require)[^''"]*[''"]\zs[^''"]+]]
vim.opt_local.includeexpr = "substitute(v:fname,'\\.','/','g')"

for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
  vim.opt_local.path:append(path .. '/lua')
end

vim.opt_local.suffixesadd:prepend('.lua')
