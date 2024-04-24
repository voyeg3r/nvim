-- File: ~/.config/nvim/lua/plugins/surround.lua
-- Last Change: Sun, Dec 2023/12/31 - 07:34:23

return {
  "echasnovski/mini.surround",
  version = false,
  keys = {
    {
      mode = { 'n', 'v' },
      'gsa',
      '<cmd>lua MiniSurround.add()<CR>',
      { desc = 'Add surround' },
    },
    {
      mode = { 'n', 'v' },
      'gsd',
      '<cmd>lua MiniSurround.delete()<CR>',
      { desc = 'Delete surround' },
    },
    {
      mode = { 'n', 'v' },
      'gsr',
      '<cmd>lua MiniSurround.replace()<CR>',
      { desc = 'Replace surround' },
    },
  },
  opts = {
    mappings = {
      add = 'gsa', -- Add surrounding in Normal and Visual modes
      delete = 'gsd', -- Delete surrounding
      replace = 'gsr', -- Replace surrounding
      -- find = 'sf', -- Find surrounding (to the right)
      -- find_left = 'sF', -- Find surrounding (to the left)
      -- highlight = 'sh', -- Highlight surrounding
      -- update_n_lines = 'sn', -- Update `n_lines`

      -- suffix_last = 'l', -- Suffix to search with "prev" method
      -- suffix_next = 'n', -- Suffix to search with "next" method
    },
  }
}
