-- File: ~/.config/nvim/lua/plugins/narrow-region.lua
-- Last Change: Fri, Nov 2023/11/24 - 12:15:01

return {
  'bagohart/minimal-narrow-region.nvim',
  keys = {
    { mode = 'x', '<F2>',   '<Plug>(minimal-narrow-region-open)' },
    { mode = 'n', '<F3>', '<Plug>(minimal-narrow-region-close)' },
  },
}
