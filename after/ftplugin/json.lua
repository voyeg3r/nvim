-- File: ~/.config/nvim/after/ftplugin/json.lua
-- Last Change: Tue, Dec 2023/12/19 - 08:54:20

vim.opt_local.commentstring = "//%s"

vim.keymap.set(
  'n',
  'o',
  function()
    local should_add_comma = vim.api.nvim_get_current_line():find('[^,{[]$')
    return (should_add_comma and 'A,<cr>' or 'o')
  end,
  {
    buffer = true,
    expr = true,
    desc = 'json ft: add comma or not'
  })
