-- File: ~/.config/nvim/lua/plugins/neoscroll.lua
-- Last Change: Wed, Jan 2024/01/10 - 21:23:11

return {
  "karb94/neoscroll.nvim",
  -- commit = "d7601c26c8a183fa8994ed339e70c2d841253e93",
  enabled = true,
  keys = {
    {
      '<C-d>',
      '<cmd>lua require("neoscroll").scroll(vim.wo.scroll, true, 300)<cr>',
      desc = 'scroll down',
    },
    {
      '<C-u>',
      '<cmd>lua require("neoscroll").scroll(-10, true, 300)<CR>',
      desc = 'scroll up',
    },
    {
      '<C-f>',
      '<cmd>lua require("neoscroll").scroll(vim.api.nvim_win_get_height(0), true, 7)<CR>',
      desc = 'page down',
    },
    {
      '<C-b>',
      '<cmd>lua require("neoscroll").scroll(-vim.api.nvim_win_get_height(0), true, 7)<CR>',
      desc = 'page down',
    },
    {
      'zz',
      '<cmd>lua require("neoscroll").zz(40)<cr>',
      desc = 'middle of screen',
    },
    {
      'zt',
      '<cmd>lua require("neoscroll").zt(40)<cr>',
      desc = 'top of screen',
    },
    {
      'zb',
      '<cmd>lua require("neoscroll").zb(40)<cr>',
      desc = 'bottom of screen',
    },
    -- { 'n', '<cmd>n:lua require("neoscroll").zz(300)<cr>', desc = "n with smoth scroll"},
    -- { 'N', '<cmd>N:lua require("neoscroll").zz(300)<cr>', desc = "N with smoth scroll"},
  },

  opts = {
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
    hide_cursor = false,         -- Hide cursor while scrolling
    stop_eof = true,             -- Stop at <EOF> when scrolling downwards
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil,       -- No easing function
    pre_hook = nil,              -- Function to run before the scrolling animation starts
    post_hook = nil,             -- Function to run after the scrolling animation ends
    performance_mode = false,    -- Disable "Performance Mode" on all buffers.

  }

}
