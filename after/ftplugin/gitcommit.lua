-- File: ~/.config/nvim/after/ftplugin/gitcommit.lua
-- Last Change: Wed, Feb 2024/02/07 - 23:46:24

local opts = { noremap = true, silent = true }
vim.opt_local.spell = true
vim.opt_local.wrap = true
vim.api.nvim_buf_set_keymap(0, 'n', 'j', 'gj', opts)
vim.api.nvim_buf_set_keymap(0, 'n', 'k', 'gk', opts)
