-- File: ~/.config/nvim/lua/plugins/treesj.lua
-- Last Change: Mon, Jan 2024/01/08 - 13:41:23

-- Purpose: Neovim plugin for splitting/joining blocks of code

local mapfile = 'treesj'

return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {
    use_default_keymaps = false,
    max_join_length = 150,
  },
  keys = {
    {
      '<leader>ct',
      '<cmd>lua require("treesj").toggle()<cr>',
      {
        desc = mapfile .. 'split/join code',
      },
    },

    {
      '<leader>cT',
      '<cmd>lua require("treesj").toggle({ split = { recursive = true } })<cr>',
      {
        desc = mapfile .. 'split/join code recursive',
      },
    },
  },
}
