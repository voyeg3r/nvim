-- Filename: /home/sergio/.config/nvim/after/ftplugin/sh.lua
-- Last Change: Mon, 14 Nov 2022 - 21:39:38
-- references: https://www.reddit.com/r/neovim/comments/od82rk/comment/h43x7jc/

-- vim.opt_local.iskeyword:append("$")
vim.opt_local.iskeyword:append("_")
vim.opt_local.formatoptions:remove({ 'a', 't', 'o', '2', 'l' })
vim.opt_local.keywordprg = ":Man"
vim.opt_local.spell = false
vim.opt_local.list = true
vim.opt_local.commentstring = "#%s"

