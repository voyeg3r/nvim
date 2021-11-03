"  reference: https://vim.fandom.com/wiki/Keep_your_vimrc_file_clean"
"       file: ~/.dotfiles/nvim/ftplugin/html.vim
"     author: Sergio Araujo
"    Created: ago 28, 2019
"       date: fev 15, 2021 - 15:20

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" augroup html_autocommands
"   au!
"   autocmd BufRead,BufWritePre *.html call Preserve('exec "normal! gg=G"')
" augroup END

setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
setlocal matchpairs+=<:>

inoreab &ldquo; “
inoreab &rdquo; ”
inoreab ldq “
inoreab rdq ”
inoreab &emdash; —
inoreab &reg; ®

" exchange < and > to &lt; and &gt; :)
" https://www.bobbywlindsey.com/2017/07/30/vim-functions/
if !exists('*FixHtml')
    function! FixHtmlFunction() range
        silent execute a:firstline . "," . a:lastline . "s/&/\\&amp;/eg"
        silent execute a:firstline . "," . a:lastline . "s/</\\&lt;/eg"
        silent execute a:firstline . "," . a:lastline . "s/>/\\&gt;/eg"
    endfunction
endif
command! -range=% FixHtml <line1>,<line2> call FixHtmlFunction()

" vim: sw=2 ts=2 et
