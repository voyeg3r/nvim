-- Filename: ~/.config/nvim/after/ftplugin/help.lua
-- Last Change: Wed, 09 Nov 2022 17:41:30

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local opts = { remap = true, buffer = 0 }

vim.keymap.set(
  'n',
  'q',
  '<cmd>close!<cr>',
  {
    desc = 'close help file using q',
    buffer = 0,
  }
)

vim.keymap.set(
  'n',
  '<cr>',
  '<c-]>',
  {
    desc = 'jump to tags using <cr>',
    buffer = 0,
  }
)

vim.keymap.set(
  'n',
  'gd',
  '<c-]>',
  {
    desc = 'jump to tags using <cr>',
    buffer = 0,
  }
)

vim.keymap.set(
  'n',
  '<BS>',
  '<C-T>',
  {
    buffer = 0,
    desc = 'Get back on help files',
    remap = true,
  }
)

augroup('equalwindow', { clear = true })
autocmd({ 'FileType' }, {
  pattern = 'help',
  group = 'equalwindow',
  callback = function(buffer)
    vim.schedule(function()
      vim.cmd('wincmd L', { buffer = buffer })
    end)
  end,
})
