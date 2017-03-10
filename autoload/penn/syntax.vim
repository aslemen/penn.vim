function! penn#syntax#_init()
	if !exists("b:penn_tags_terminal")
		let b:penn_tags_terminal = g:penn_tags_terminal
	endif

	if !exists("b:penn_tags_nonterminal")
		let b:penn_tags_nonterminal = g:penn_tags_nonterminal
	endif

	if !exists("b:penn_traces")
		let b:penn_traces = g:penn_traces
	endif

	if !exists("b:penn_traces_in_tags")
		let b:penn_traces_in_tags = g:penn_traces_in_tags
	endif

	" Define syntax
	syntax case match
	set syntax iskeyword+=-
	set syntax iskeyword+=*

	" Terminal tags
	for i in b:penn_tags_terminal
		exec 'syntax match pennTagTerminal /\<' . i . '\>/ containedin=pennLabelFilterFirst contained contains=@NoSpell keepend'
		unlet i
	endfor

	" Non-terminal tags
	for i in b:penn_tags_nonterminal
		exec 'syntax match pennTagNonTerminal /\<' . i . '\>/ nextgroup=pennTraceInLabelFilterFirst containedin=pennLabelFilterFirst contained contains=@NoSpell keepend'
		unlet i
	endfor
	
	" Traces
	for i in b:penn_traces
		exec 'syntax keyword pennTrace ' . i . " containedin=ALLBUT,pennLabelFilterFirst"
		unlet i
	endfor

	for i in b:penn_traces_in_tags
		exec 'syntax keyword pennTraceInLabel ' . i . " containedin=pennTraceInLabelFilterFirst" 
		unlet i
	endfor
	
	syntax match pennLabelFilterFirst /(.\{-}\(\s\|(\|)\)/hs=s+1,he=e-1 contains=@NoSpell

	"syntax region pennTraceInLabelFilterFirst start=";" matchgroup=pennTraceInLabel end="\>" transparent contained
	syntax match pennTraceInLabelFilterFirst ";" nextgroup=pennTraceInLabelFilterSecond contained
	syntax region pennTraceInLabelFilterSecond start="" matchgroup=pennTraceInLabel end="\>" contained

	" Comments
	syntax region pennComment start="(COMMENT\s\{1,}{"hs=e+1 end="}"he=e-1 contains=@Spell

	" Set highlights
	highlight default link pennLabelFilterFirst Error
	highlight default link pennTraceInLabelFilterFirst Normal
	"highlight default link pennTraceInLabelFilterFirst Error
	highlight default link pennTraceInLabelFilterSecond Error

	highlight link pennTagNonTerminal Label
	highlight link pennTagTerminal Constant
	highlight link pennComment Comment
	highlight link pennTraceInLabel Special
	highlight link pennTrace Special
endfunction
