-- File: ~/.config/nvim/lua/core/bootstrap.lua
-- Last Change: Thu, Feb 2024/02/08 - 18:03:17

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local nvim_home = vim.fn.stdpath("config")

local opts = {
  git = { log = { "--since=3 days ago" } },
  ui = {
    custom_keys = { false },
    border = "single",
    size = {
      width = 0.8,
      height = 0.8,
    },
  },
  -- install = { colorscheme = { 'ayu-dark' } },
  performance = {
    cache = {
      enabled = true,
      -- disable_events = {},
    },
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "getscript",
        "getscriptPlugin",
        "loaded_remote_plugins",
        "loaded_tutor_mode_plugin",
        "logipat",
        "netrwFileHandlers",
        "rrhelper",
        "editorconfig",
        "gzip",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "rrhelper",
        -- 'matchparen',
        -- 'matchit',
      },
    },
  },
  checker = { enabled = false },
  reload_on_compiled = true,
  reload_on_config_change = {
    nvim_home .. "/init.lua",
  },
}

-- Load the plugins and options
require("lazy").setup("plugins", opts)
