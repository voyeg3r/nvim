-- ~/.config/nvim/lua/core/theme.lua
-- Last Change: Fri, Apr 2024/04/12 - 05:52:25

-- Why do I need to change the theme based on hour?
-- Because sometimes I am outdoor and black screens bother me

function isDaytime()
  local currentTime = os.date("*t")
  local currentHour = currentTime.hour

  local startDaytimeHour = 6
  local endDaytimeHour = 18

  return currentHour >= startDaytimeHour and currentHour < endDaytimeHour
end

local colorscheme
if isDaytime() then
  vim.opt.background = "light"
  colorscheme = "gruvbox"
else
  vim.opt.background = "dark"
  colorscheme = "shin"
end

-- Attempt to set colorscheme in a protected call
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
