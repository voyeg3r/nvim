-- File: ~/.config/nvim/lua/plugins/lazigit.lua
-- Last Change: Thu, Feb 2024/02/01 - 18:30:00

local mapfile = ' '

return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      '<leader>gg',
      '<cmd>LazyGit<cr>',
      desc = mapfile .. 'Start lazygit',
    },
    {
      '<leader>gc',
      '<cmd>LazyGitCurrentFile<cr>',
      desc = mapfile .. 'LazyGit current file',
    },
  },
}
