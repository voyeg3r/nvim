-- Filename: qf.lua
-- Last Change: Sat, 29 Oct 2022 14:01:57
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local map = require('core.utils').map

vim.wo.relativenumber = false
vim.wo.signcolumn = 'no'
vim.wo.scrolloff = 0
vim.opt_local.spell = false
vim.opt_local.buflisted = false
vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close!<cr>", {noremap = true, silent = true})

-- quickfix mappings
map('n', '[q', ':cprevious<CR>')
map('n', ']q', ':cnext<CR>')
map('n', ']Q', ':clast<CR>')
map('n', '[Q', ':cfirst<CR>')

-- quickfix mappings
map('n', '<m-left>', ':cprevious<CR>')
map('n', '<m-right>', ':cnext<CR>')
map('n', '<m-end>', ':clast<CR>')
map('n', '<m-home>', ':cfirst<CR>')
