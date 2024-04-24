-- Filename: /home/sergio/.config/nvim/after/ftplugin/conf.lua
-- Last Change: Mon, 14 Nov 2022 - 21:39:38
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:
-- references: https://www.reddit.com/r/neovim/comments/od82rk/comment/h43x7jc/

-- vim.opt_local.iskeyword:append("$")
vim.opt_local.iskeyword:append("_")
vim.opt_local.formatoptions:remove({ 'r', 'o' })
vim.opt_local.spell = false
vim.opt_local.list = true
vim.opt_local.commentstring = '#%s'
-- vim.bo.comments = ':#'
