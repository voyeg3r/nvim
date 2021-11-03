"       file: qf.vim
"     author: Sergio Araujo
"    Created: set 07, 2019
"Last Change: abr 05, 2020 - 09:20

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
   finish
endif
let b:did_ftplugin = 1

nnoremap <buffer> [f :colder<CR>
nnoremap <buffer> ]f :cnewer<CR>

" wincmd p " go to original window
setlocal cursorline
setlocal cursorcolumn
setlocal norelativenumber
" wincmd p " back to quickfix window
