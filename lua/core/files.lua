-- File: ~/.config/nvim/lua/core/files.lua
-- Last Change: Sat, Jan 2024/01/27 - 22:39:45
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
-- https://youtu.be/Ua8FkgTL-94

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local M = {}

-- copied from https://github.com/nvim-telescope/telescope.nvim/wiki/Gallery
-- :Telescope find_files previewer=true theme=get_dropdown
local dropdown_theme = require('telescope.themes').get_dropdown({
  results_height = 20,
  -- winblend = 20;
  width = 0.7,
  prompt_title = '',
  prompt_prefix = 'Files> ',
  previewer = true,
  borderchars = {
    { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
  },
})

-- searches files on ~/.config
M.xdg_config = function()
  require("telescope.builtin").find_files({
    prompt_title = "XDG-CONFIG",
    find_command = { 'fd', '--no-ignore-vcs' },
    sorting_strategy = "ascending",
    file_ignore_patterns = { "lua-language-server", "chromium" },
    cwd = "~/.config",
    layout_config = { height = 0.3 },
    layout_config = { width = 0.7 },
    results_height = 20,
    hidden = true,
    previewer = true,
    borderchars = {
      { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    },
  })
end

-- searches files on ~/.config
M.wiki = function()
  require("telescope.builtin").find_files({
    prompt_title = "Search wiki",
    previewer = true,
    find_command = { 'fd', '--no-ignore-vcs' },
    sorting_strategy = "ascending",
    -- file_ignore_patterns = { "lua-language-server", "chromium" },
    cwd = "~/.dotfiles/wiki/",
    layout_config = { height = 0.3 },
    layout_config = { width = 0.7 },
    results_height = 20,
    hidden = true,
    borderchars = {
      { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    },
  })
end
-- mapped Leader n f

-- searches opened buffers
M.buffers = function()
  require("telescope.builtin").buffers({
    prompt_title = "BUFFERS",
    sorting_strategy = "ascending",
    file_ignore_patterns = { "lua-language-server", "chromium" },
    -- cwd = "~/.config",
    previewer = true,
    layout_config = { height = 0.3 },
    layout_config = { width = 0.7 },
    hidden = true,
    ignore_current_buffer = true,
    sort_mru = true,
  })
end
-- mapped to <leader>b

M.nvim_files = function()
  local NVIMHOME = vim.env.NVIM_APPNAME or "nvim"
  require("telescope.builtin").find_files({
    prompt_title = "NVIM FILES",
    previewer = true,
    find_command = { 'fd', '--no-ignore-vcs' },
    sorting_strategy = "ascending",
    file_ignore_patterns = { ".git" },
    cwd = "~/.config/" .. NVIMHOME,
    hidden = true,
  })
end

M.nvim_plugins = function()
  local NVIMHOME = vim.env.NVIM_APPNAME or "nvim"
  require("telescope.builtin").find_files({
    prompt_title = "NVIM PLUGINS",
    previewer = true,
    find_command = { 'fd', '--no-ignore-vcs' },
    sorting_strategy = "ascending",
    file_ignore_patterns = { ".git" },
    cwd = "~/.config/" .. NVIMHOME .. "/lua/plugins",
    hidden = true,
  })
end

M.nvim_core = function()
  local NVIMHOME = vim.env.NVIM_APPNAME or "nvim"
  require("telescope.builtin").find_files({
    prompt_title = "NVIM CORE",
    previewer = true,
    find_command = { 'fd', '--no-ignore-vcs' },
    sorting_strategy = "ascending",
    file_ignore_patterns = { ".git" },
    cwd = "~/.config/" .. NVIMHOME .. "/lua/core",
    hidden = true,
  })
end

M.nvim_zshfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "NVIM ZSHFILES",
    previewer = true,
    hidden = true,
    find_command = { 'fd', '--no-ignore-vcs' },
    sorting_strategy = "ascending",
    file_ignore_patterns = { ".git" },
    cwd = vim.env.ZDOTDIR,
  })
end

M.search_dotfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "DOTFILES",
    find_command = { 'fd', '--no-ignore-vcs' },
    shorten_path = true,
    previewer = true,
    hidden = true,
    sorting_strategy = "ascending",
    -- cwd = vim.env.DOTFILES,
    search_dirs = { "~/.config", "~/.dotfiles" },
    layout_config = { height = 0.3 },
    layout_config = { width = 0.7 },
  })
end
-- mapped to Ctrl-p

M.search_oldfiles = function()
  require("telescope.builtin").oldfiles({
    prompt_title = "OLDFILES",
    previewer = true,
    shorten_path = true,
    hidden = true,
    sorting_strategy = "ascending",
    layout_config = { height = 0.3 },
    layout_config = { width = 0.8 },
  })
end
-- mapped to Alt-o

-- searches on ~/.dotfiles
M.grep_dotfiles = function()
  require("telescope.builtin").live_grep({
    prompt_title = "GREP DOTFILES",
    shorten_path = true,
    hidden = true,
    sorting_strategy = "ascending",
    cwd = vim.env.DOTFILES,
  })
end
-- mapped to Ctrl-p

M.grep_wiki = function()
  local opts = {}
  opts.hidden = true
  opts.search_dirs = {
    "~/.dotfiles/wiki",
  }
  opts.prompt_prefix = ">"
  opts.prompt_title = "Grep Wiki"
  opts.path_display = { "smart" }
  require("telescope.builtin").live_grep(opts)
end

return M
