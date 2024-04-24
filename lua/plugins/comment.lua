-- File: ~/.config/nvim/lua/plugins/comment.lua
-- Last Change: Tue, Jan 2024/01/09 - 00:36:59

return {
  "numToStr/Comment.nvim",
  event = { "BufRead", "BufNewFile" },
  lazy = true,
  opts = {
    sticky = true,
    toggler = {
      line = 'gcc',
      block = 'gbc',
    },
    opleader = {
      line = 'gc',
      block = 'gb',
    },
  }
}

--[[ usage:

gbap .... toggle comment blockwise
gcap .... toggle comment linewise
gcc ..... toggle comment line
gcap .... linewise comnent block 

]]
