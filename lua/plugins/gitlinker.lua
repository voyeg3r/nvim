-- File: ~/.config/nvim/lua/plugins/gitlinker.lua
-- Last Change: Sat, Mar 2024/03/30 - 19:16:44

-- Purpose: copy links to GitHub of the current file.
local mapfile = ' '

return {
  "linrongbin16/gitlinker.nvim",
  cmd = "GitLink",
  opts = {},
  keys = {
    {
      "<leader>gy",
      "<cmd>GitLink<cr>",
      mode = { "n", "v" },
      desc = mapfile .. "Yank git link",
    },
    {
      "<leader>gY",
      "<cmd>GitLink!<cr>",
      mode = { "n", "v" },
      desc = mapfile .. "Open git link",
    },
  },
}
