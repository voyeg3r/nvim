-----------------------------------------------------------
-- File: ~/.config/nvim/lua/core/colors.lua
-- Color schemes changer file
-- vim:set ft=lua softtabstop=2 shiftwidth=2 tabstop=2 expandtab:
-- Last Change: Wed, 09 Nov 2022 08:37:33
-----------------------------------------------------------

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local M = {}

-- Theme: OneDark
--- See: https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/colors.lua
M.onedark = {
  bg = '#282c34',
  fg = '#abb2bf',
  pink = '#c678dd',
  green = '#98c379',
  cyan = '#56b6c2',
  yellow = '#e5c07b',
  orange = '#d19a66',
  purple = '#8a3fa0',
  red = '#e86671',
}

-- Theme: Monokai (classic)
--- See: https://github.com/tanvirtin/monokai.nvim/blob/master/lua/monokai.lua
M.monokai = {
  bg = '#202328', --default: #272a30
  fg = '#f8f8f0',
  pink = '#f92672',
  green = '#a6e22e',
  cyan = '#66d9ef',
  yellow = '#e6db74',
  orange = '#fd971f',
  purple = '#ae81ff',
  red = '#e95678',
}

-- Theme: Rosé Pine (main)
--- See: https://github.com/rose-pine/neovim/blob/main/lua/rose-pine/palette.lua
--- color names are adapted to the format above
M.rose_pine = {
  bg = '#111019', --default: #191724
  fg = '#e0def4',
  gray = '#908caa',
  pink = '#eb6f92',
  green = '#9ccfd8',
  cyan = '#31748f',
  yellow = '#f6c177',
  orange = '#2a2837',
  purple = '#c4a7e7',
  red = '#ebbcba',
}

M.choose_colors = function()
  local actions = require "telescope.actions"
  local actions_state = require "telescope.actions.state"
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local sorters = require "telescope.sorters"
  local dropdown = require "telescope.themes".get_dropdown()

  function enter(prompt_bufnr)
    local selected = actions_state.get_selected_entry()
    local cmd = 'colorscheme ' .. selected[1]
    vim.cmd(cmd)
    actions.close(prompt_bufnr)
  end

  function next_color(prompt_bufnr)
    actions.move_selection_next(prompt_bufnr)
    local selected = actions_state.get_selected_entry()
    local cmd = 'colorscheme ' .. selected[1]
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.cmd(cmd)
  end

  function prev_color(prompt_bufnr)
    actions.move_selection_previous(prompt_bufnr)
    local selected = actions_state.get_selected_entry()
    local cmd = 'colorscheme ' .. selected[1]
    vim.cmd(cmd)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end

  -- local colors = vim.fn.getcompletion("", "color")

  local opts = {

    finder = finders.new_table { "nightfox", "terafox", "gruvbox", "dawnfox", "ayu-dark", "catppuccin", "material", "rose-pine", "nordfox", "monokai", "tokyonight", "kanagawa-dragon"},
    -- finder = finders.new_table(colors),
    sorter = sorters.get_generic_fuzzy_sorter({}),

    attach_mappings = function(prompt_bufnr, map)
      map("i", "<CR>", enter)
      map("i", "<C-j>", next_color)
      map("i", "<C-k>", prev_color)
      map("i", "<C-n>", next_color)
      map("i", "<C-p>", prev_color)
      return true
    end,

  }

  local colors = pickers.new(dropdown, opts)

  colors:find()
end

return M
