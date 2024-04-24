-- File: ~/.config/nvim/lua/plugins/telescope-headings.lua
-- Last Change: Thu, Feb 2024/02/08 - 15:03:17

return {
  'crispgm/telescope-heading.nvim',
  ft = 'markdown',
  config = function()
    local telescope = require('telescope')
    telescope.setup({
      -- ...
      extensions = {
        heading = {
          treesitter = true,
        },
      },
      telescope.load_extension('heading')
      -- vim.keymap.set(
      --   'n',
      --   '<c-right>',
      --   'lua require('telescope').load_extension('heading')<cr>',
      --   { buffer = 0, noremap = true, desc = 'Markdown headings' }
      -- )
    })
  end
}
