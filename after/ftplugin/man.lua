-- Filename: /home/sergio/.config/nvim/after/ftplugin/man.lua
-- Last Change: Wed, 09 Nov 2022 17:40:52
-- vim:set softtabstop=2 shiftwidth=2 tabstop=2 expandtab ft=lua:

vim.opt.termguicolors = true
vim.bo.buflisted = false

vim.keymap.set(
  "n",
  "<leader>q",
  "<cmd>close<cr>",
  { desc = "man ft: close help file using <leader>q" }
)
