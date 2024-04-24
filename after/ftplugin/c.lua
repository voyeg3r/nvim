-- Filename: ~/.config/nvim/after/ftplugin/c.lua
-- Last Change: Sun, 06 Nov 2022 15:49:26
-- reference: r/neovim/comments/pl0p5v/comment/hvn0kff/
-- vim:set ft=c nolist softtabstop=4 shiftwidth=4 tabstop=4 expandtab:

-- local opt_local = vim.opt_local
-- vim.opt_local.includeexpr , _ = vim.v.fname:gsub('%.', '/')
vim.opt_local.spell = false
vim.opt_local.list = true

vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.textwidth = 78
vim.bo.expandtab = true
vim.bo.autoindent = true
