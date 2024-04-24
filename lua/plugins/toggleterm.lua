-- Filename: ~/.config/nvim/lua/plugins/toggleterm.lua
-- Last Change: Thu, 19 Oct 2023 - 06:49

return {
  'akinsho/toggleterm.nvim',
  opts = {
    direction = "horizontal",
    start_in_insert = true,
    winbar = {
      enabled = false,
      name_formatter = function(term) --  term: Terminal
        return term.name
      end
    },
  },
  keys = {
    {
      "<m-t>",
      "<cmd>ToggleTerm<cr>",
      desc = "new terminal",
    },
    -- {
    --   "<m-t>",
    --   "<cmd>ToggleTerm direction=float<cr>",
    --   desc = "float terminal",
    -- },
    -- {
    --   "<m-p>",
    --   "<cmd>ToggleTerm direction=float cmd='python'<cr>",
    --   desc = "float terminal",
    -- },
  }
}
