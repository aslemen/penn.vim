" Vim indent file
" Language:	Penn Treebank
" Maintainer:    Tatsuya Hayashi <net@hayashi-lin.net>
" Last Change:	2016 Sep 4

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

if !exists("g:penn_equalprg")
	let g:penn_equalprg=""
endif

if !exists("b:equalprg")
	let b:equalprg=g:penn_equalprg
endif

execute "setlocal equalprg=" . b:equalprg

" setlocal lisp

setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

setlocal ai nosi

let b:undo_indent = "setl ai< si< expandtab< tabstop< softtabstop< shiftwidth< equalprg<"
