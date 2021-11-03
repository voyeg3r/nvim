"      source: https://vim.fandom.com/wiki/Keep_your_vimrc_file_clean
"        file: css.vim
"      author: Sergio Araujo
"     Created: ago 28, 2019
" Last Change: dez 06 2019 08:10

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

"runtime! ftplugin/css.vim

setlocal tabstop=6 softtabstop=6 shiftwidth=6 noexpandtab
setlocal ft=css
setlocal iskeyword+=-

" vim: sw=2 ts=2 et
