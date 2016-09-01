" Vim syntax file
" Language:     Penn Treebank
" Maintainer:   Tatsuya Hayashi <net@hayashi-lin.net> 
" Last Change:  2016 Sep 2

if !exists("g:penn_tags")
	let g:penn_tags = ['NP-SBJ', 'NP-OB1', 'NP-OB2', 'IP-MAT']
endif

for i in g:penn_tags
	exec "syntax match pennTag /" . i . "/ containedin=pennLabel contained contains=@NoSpell"
	unlet i
endfor

syntax case match
syntax region pennLabel start="("hs=e+1 end="\s"he=s-1
highlight link pennTag Type
