"       file: zsh.vim
"     author: Sergio Araujo
"    Created: dez 01, 2019
"Last Change: out 06, 2020 - 20:01

" if exists("b:did_ftplugin")
"   finish
" endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

let b:undo_ftplugin = "setl com< cms< fo<"

" augroup zsh_chmod
"     au!
"     au BufWritePost *.zsh :silent !chmod a+x <afile>
" augroup END

setlocal comments=:# commentstring=#\ %s formatoptions-=t formatoptions+=croql

let b:match_words = ',\<if\>:\<elif\>:\<else\>:\<fi\>'
      \ . ',\<case\>:^\s*([^)]*):\<esac\>'
      \ . ',\<\%(select\|while\|until\|repeat\|for\%(each\)\=\)\>:\<done\>'
let b:match_skip = 's:comment\|string\|heredoc\|subst'

let &cpo = s:cpo_save
unlet s:cpo_save

