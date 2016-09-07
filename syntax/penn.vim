" Vim syntax file
" Language:     Penn Treebank
" Maintainer:   Tatsuya Hayashi <net@hayashi-lin.net> 
" Last Change:  2016 Sep 2

if exists("b:current_syntax")
  finish
endif
let b:current_syntax=1

" Set default tags
" Terminal tags
if !exists("g:penn_tags_terminal")
	let g:penn_tags_terminal = [
		\'PRP$', 
		\'NNPS', 
		\'WP$', 
		\'WDT', 
		\'VBZ', 
		\'VBP', 
		\'VBN', 
		\'VBG', 
		\'VBD', 
		\'SYM', 
		\'RBS', 
		\'RBR', 
		\'PRP', 
		\'POS', 
		\'PDT', 
		\'NNS', 
		\'NNP', 
		\'JJS', 
		\'JJR', 
		\'WRB',
		\'WP', 
		\'VB', 
		\'UH', 
		\'TO', 
		\'RP', 
		\'RB', 
		\'NN', 
		\'MD', 
		\'LS', 
		\'JJ', 
		\'IN', 
		\'FW', 
		\'EX', 
		\'DT', 
		\'CD', 
		\'CC'] 
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
	exec 'syntax match pennTagTerminal /\<' . i . '\(\s\|(\|)\)/ containedin=pennLabel contained contains=@NoSpell keepend'
	unlet i
endfor

" Non-terminal tags
for i in b:penn_tags_nonterminal
	exec 'syntax match pennTagNonTerminal /\<' . i . '\(\s\|(\|)\)/ containedin=pennLabel contained contains=@NoSpell'
	unlet i
endfor

syntax match pennLabel /(.\{-}\(\s\|(\|)\)/hs=s+1,he=e-1 contains=@NoSpell

" Comments
syntax region pennComment start="(COMMENT\s\{1,}{"hs=e+1 end="}"he=e-1 contains=@Spell

" Set highlights
highlight default link pennLabel Error
highlight link pennTagNonTerminal Label
highlight link pennTagTerminal Constant
highlight link pennComment Comment
