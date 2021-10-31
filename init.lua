-- ~/.config/nvim/init.lua

require('utils')
require('plugins')
require('settings')
require('mappings')
require('autocmd')

--[[
TODO:
Config wichkey-nvim plugin

utils - Some useful functions to squeeze blank lines,
        reload nvim settings, reinden current file and much more

plugins -  The init.lua has all plugins and the plugins folder
           contains all plugins settings.

settings - Most of 'set option' we use to have in tradicional vim but
           written in lua

mappings - Here you will customize your mappings

autocmd  - All autocommands are in this file

------
NOTES:
------
Befor installin this settings run -> :checkhealth
Setup: Run -> :PackerSync

If by any chance your snippets are not working try installing
some lsp-servers firts

--]]
