-- File: ~/.config/nvim/lua/plugins/zoxide.lua
-- Last Change: Sat, Apr 2024/04/20 - 20:19:52
-- Author: Sergio Arauj

return {
  -- You can also use the codeberg mirror if you want to use the plugin without relying on GitHub
  -- "https://codeberg.org/CodingThunder/zincoxide.git" -- for HTTPS
  -- "git@codeberg.org:CodingThunder/zincoxide.git"     -- for SSH
  -- NOTE: the username on both github and codeberg are different
  'thunder-coding/zincoxide',
  opts = {
    -- name of zoxide binary in your "$PATH" or path to the binary
    -- the command is executed using vim.fn.system()
    -- eg. "zoxide" or "/usr/bin/zoxide"
    zincoxide_cmd = 'zoxide',
    -- Kinda experimental as of now
    complete = true,
    -- Available options { "tabs", "window", "global" }
    behaviour = 'tabs',
  },
  cmd = { 'Z' },
}
