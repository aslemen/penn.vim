" Vim syntax file
" Language:     Penn Treebank
" Maintainer:   Tatsuya Hayashi <net@hayashi-lin.net> 
" Last Change:  2016 Sep 2

" Set default tags
" Terminal tags
if !exists("g:penn_tags_terminal")
	let g:penn_tags_terminal = [
		\'CC', 
		\'CD', 
		\'DT', 
		\'EX', 
		\'FW', 
		\'IN', 
		\'JJ', 
		\'JJR', 
		\'JJS', 
		\'LS', 
		\'MD', 
		\'NN', 
		\'NNS', 
		\'NNP', 
		\'NNPS', 
		\'PDT', 
		\'POS', 
		\'PRP', 
		\'PRP$', 
		\'RB', 
		\'RBR', 
		\'RBS', 
		\'RP', 
		\'SYM', 
		\'TO', 
		\'UH', 
		\'VB', 
		\'VBD', 
		\'VBG', 
		\'VBN', 
		\'VBP', 
		\'VBZ', 
		\'WDT', 
		\'WP', 
		\'WP$', 
		\'WRB']
endif

if !exists("b:penn_tags_terminal")
	let b:penn_tags_terminal = g:penn_tags_terminal
endif

if exists("b:penn_tags_terminal_additional")
	let b:penn_tags_terminal += b:penn_tags_terminal_additional
endif

if !exists("g:penn_tags_nonterminal")
	let g:penn_tags_nonterminal = []
endif

if !exists("b:penn_tags_nonterminal")
	let b:penn_tags_nonterminal = g:penn_tags_nonterminal
endif

if exists("b:penn_tags_nonterminal_additional")
	let b:penn_tags_nonterminal += b:penn_tags_nonterminal_additional
endif

" Define syntax
syntax case match

" Terminal tags
for i in b:penn_tags_terminal
	exec "syntax match pennTagTerminal /" . i . "/ containedin=pennLabel contained contains=@NoSpell"
	unlet i
endfor

" Non-terminal tags
for i in b:penn_tags_nonterminal
	exec "syntax match pennTagNonTerminal /" . i . "/ containedin=pennLabel contained contains=@NoSpell"
	unlet i
endfor

syntax 
syntax region pennLabel start="("hs=e+1 end="\s"he=s-1 contains=@NoSpell

highlight default link pennLabel Error
highlight link pennTagNonTerminal Constant 
highlight link pennTagTerminal Label
