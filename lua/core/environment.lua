-- File: ~/.config/nvim/lua/core/environment.lua
-- Last Change: Sat, Feb 2024/02/17 - 11:42:27

M = {}

M.os_name = function()
  return vim.loop.os_uname().sysname:lower()
end

M.is_linux = function()
  return vim.loop.os_uname().sysname == "Linux"
end

M.is_mac = function()
  return vim.loop.os_uname().sysname == "Darwin"
end

M.nvim_home = function()
  return vim.fn.stdpath('config')
end

M.myvimrc = function()
  return vim.env.MYVIMRC
end

M.zsh_home = function()
  return vim.env.ZDOTDIR or vim.env.HOME
end

return M
