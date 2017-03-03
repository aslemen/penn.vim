function! penn#syntax#_init()
	if !exists("b:penn_tags_terminal")
		let b:penn_tags_terminal = g:penn_tags_terminal
	endif

	if !exists("b:penn_tags_nonterminal")
		let b:penn_tags_nonterminal = g:penn_tags_nonterminal
	endif

	" Define syntax
	syntax case match
	set syntax iskeyword+=-

	" Terminal tags
	for i in b:penn_tags_terminal
		exec 'syntax match pennTagTerminal /\<' . i . '\(\s\|(\|)\)/ containedin=pennLabel contained contains=@NoSpell keepend'
		unlet i
	endfor

	" Non-terminal tags
	for i in b:penn_tags_nonterminal
		exec 'syntax match pennTagNonTerminal /\<' . i . '\(\s\|(\|)\)/ containedin=pennLabel contained contains=@NoSpell keepend'
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
endfunction
