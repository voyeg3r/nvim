"       file: help.vim
"     author: Sergio Araujo
"    Created: set 05, 2019
"       date: jan 01, 2021 - 19:31

" wincmd L
vertical resize 78


let g:indentLine_enabled=0

nnoremap <silent><buffer> zl
  \ :call search('<Bar>[^ <Bar>]\+<Bar>\<Bar>''[A-Za-z0-9_-]\{2,}''')<cr>

nnoremap <silent><buffer> zh
 \ :call search('<Bar>[^ <Bar>]\+<Bar>\<Bar>''[A-Za-z0-9_-]\{2,}''','b')<cr>
