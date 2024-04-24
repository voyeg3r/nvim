-- File: ~/.config/nvim/lua/plugins/thanks.lua
-- Last Change: Fri, Mar 2024/03/29 - 05:12:40

return {
  'jsongerber/thanks.nvim',
  config = function()
    require('thanks').setup({
      plugin_manager = "lazy",
    })
  end,
}
