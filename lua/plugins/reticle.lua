-- File: ~/.config/nvim/lua/plugins/reticle.lua
-- Last Change: Mon, Apr 2024/04/08 - 20:41:17

-- Cursorline only on active window

return {
  'tummetott/reticle.nvim',
  event = 'VeryLazy', -- optionally lazy load the plugin
  opts = {
    on_startup = {
      cursorline = true,
      cursorcolumn = false,
    },
  },
}
