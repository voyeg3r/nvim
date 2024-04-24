-- Filename: ~/.config/nvim/after/ftplugin/lua.lua
-- Last Change: Mon, 07 Nov 2022 15:49:51
-- reference: r/neovim/comments/pl0p5v/comment/hvn0kff/

-- https://vi.stackexchange.com/a/36891/7339
local user_cmd = vim.api.nvim_create_user_command

user_cmd('LspSignature', 'lua vim.lsp.buf.signature_help()', { nargs = '+' })
user_cmd('LspHover', 'lua vim.lsp.buf.hover()', { nargs = "+" })
-- vim.opt_local.keywordprg = ":LspHover"
-- vim.opt_local.keywordprg = ":LspSignatre"

-- https://github.com/sam4llis/nvim-lua-gf
-- Options to add `gf` functionality inside `.lua` files.
vim.opt_local.include = [[\v<((do|load)file|require)[^''"]*[''"]\zs[^''"]+]]
vim.opt_local.includeexpr = "substitute(v:fname,'\\.','/','g')"

for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
  vim.opt_local.path:append(path .. '/lua')
end

vim.opt_local.suffixesadd:prepend('.lua')
-- lua gf end

-- -- local opt_local = vim.opt_local
-- -- vim.opt_local.includeexpr , _ = vim.v.fname:gsub('%.', '/')
-- vim.cmd [[ setlocal includeexpr=substitute(v:fname,'\\.','/','g') ]]
-- vim.opt_local.suffixesadd:prepend '.lua'
-- -- vim.bo.path = vim.o.path .. ',' .. vim.fn.stdpath('config')..'/lua'
-- vim.bo.path = vim.bo.path .. ',' .. vim.fn.stdpath('config') .. '/lua'

vim.opt_local.list = true
vim.opt_local.spell = true
vim.opt_local.cursorline = true
vim.opt_local.formatoptions:remove({ 'a', 't', 'o', '2', 'l' })
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.textwidth = 78
vim.bo.expandtab = true
vim.bo.autoindent = true

