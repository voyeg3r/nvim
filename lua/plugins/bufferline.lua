-- File: ~/.config/nvim/lua/plugins/bufferline.lua
-- Last Change: Sat, Jan 2024/01/13 - 21:08:16

return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = "VeryLazy",
  opts = {
    options = {
      close_command = "bdelete! %d",
      right_mouse_command = "bdelete! %d",
      left_mouse_command = "buffer %d",
      middle_mouse_command = nil,
      numbers = "ordinal",
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      separator_style = "thin",
      always_show_bufferline = true,
      buffer_close_icon = '',
      modified_icon = '●',
      close_icon = '',
      left_trunc_marker = '',
      right_trunc_marker = '',
      truncate_names = true,
      color_icons = true,
      offsets = {
        {
          filetype = {"Neotree", "NvimTree" },
          text = "File Explorer",
          highlight = "Directory",
          separator = true,
        }
      },
    },
  }
}
