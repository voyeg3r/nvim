-- File: ~/.config/nvim/init.lua
-- Last Change: Sun, Apr 2024/04/14 - 16:06:01

-- local Utils = require("core.utils")
-- local safeRequire = Utils.safeRequire

-- vim.loader.enable()

require("core.options")
require("core.filetype")
require("core.keymaps")
require("core.autocommands")
require("core.bootstrap")
require("core.commands")
require("core.theme")
