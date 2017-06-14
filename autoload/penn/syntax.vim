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
	syntax iskeyword a-z,A-Z,48-57,-,*,_

	" Nodes
	" region: pennNode
	syntax region pennNode start="(\s*\([^[:blank:]()]\|{.*}\)\+\ze\s*\S\+" skip="\\." end="\s*)" contains=pennNodeLabel,pennNodeLabelError containedin=TOP,pennNode transparent
		" Node Labels
		" match: pennNodeLabelError
		" contained in: pennNode
		" successors: pennNodeSubordinations, pennNodeTerminals
		" alternavites: pennNodeLabel (overwritten by this)
		syntax match pennNodeLabelError "(\s*\zs\([^[:blank:]()]\|{.*}\)\+\ze\s*\S\+" contains=NONE containedin=pennNode nextgroup=pennNodeSubordinations,pennNodeTerminals skipwhite skipempty

		" match: pennNodeLabel
		" contained in: pennNode
		" contains: pennNodeLabelCore (->pennNodeICHNum ->pennNodeLabelAdditional)
		" successors: pennNodeSubordinations, pennNodeTerminals
		" alternatives: pennNodeLabelError
		for i in b:penn_tags_terminal
			exec 'syntax match pennNodeLabel "(\s*\zs' . i . '\(-\d\+\)\?\(;{.*}\)\?" contains=pennNodeLabelCore containedin=pennNode nextgroup=pennNodeTerminals,pennNodeSubordinations skipwhite skipempty transparent'
		endfor
		for i in b:penn_tags_nonterminal
			exec 'syntax match pennNodeLabel "(\s*\zs' . i . '\(-\d\+\)\?\(;{.*}\)\?" contains=pennNodeLabelCore containedin=pennNode nextgroup=pennNodeTerminals,pennNodeSubordinations skipwhite skipempty transparent'
		endfor

			" match: pennNodeLabelCore
			" successors: pennNodeICHNum, pennNodeTerminals
			for i in b:penn_tags_terminal
				exec 'syntax match pennNodeLabelCore "' . i . '" nextgroup=pennNodeICHNum,pennNodeLabelAdditional contains=pennTagTerminal,pennTagNonTerminal containedin=pennNodeLabel'
			endfor
			for i in b:penn_tags_nonterminal
				exec 'syntax match pennNodeLabelCore "' . i . '" nextgroup=pennNodeICHNum,pennNodeLabelAdditional contains=pennTagTerminal,pennTagNonTerminal containedin=pennNodeLabel'
			endfor
"
			hi link pennNodeLabelCore Error
			"match: pennNodeICHNum
			syntax match pennNodeICHNum "-\d\+" contained contains=pennNodeICHNumCore nextgroup=pennNodeLabelAdditional
			highlight link pennNodeICHNum Error
			syntax match pennNodeICHNumCore "\d\+" contained

			" region: pennNodeLabelAdditional
"			syntax region pennNodeLabelAdditional start=";{" end="}" contained contains=pennNodeLabelAdditionalCore transparent
"			syntax region pennNodeLabelAdditionalCore start="{" end="}" containedin=pennNodeLabelAdditional

		" match: pennNodeSubordinations
		"syntax match pennNodeTerminals excludenl keepend ".*" skipempty contained contains=NONE,@Spell

	" Terminal tags
	" match: pennTagTerminal
	for i in b:penn_tags_terminal
		exec 'syntax keyword pennTagTerminal ' . i  . ' contained'
	endfor

	" Non-terminal tags
	" match: pennTagNonTerminal
	for i in b:penn_tags_nonterminal
		exec 'syntax keyword pennTagNonTerminal ' . i . ' contained'
		unlet i
	endfor
	
	" Traces
	" match: pennTrace
	for i in b:penn_traces
		exec 'syntax keyword pennTrace ' . i . ' containedin=pennNodeTerminals'
		unlet i
	endfor

	" Set highlights
	highlight link pennNodeLabel Comment
	highlight link pennNodeSubordinations IncSearch
	highlight link pennNodeTerminals Search
	highlight link pennNodeLabelError Error

	highlight link pennNodeICHNumCore Identifier
	highlight link pennNodeLabelAdditionalCore Identifier
	highlight link pennTagNonTerminal Label
	highlight link pennTagTerminal Constant

	highlight link pennComment Comment
	highlight link pennTrace Special

" obsolete----
"	for i in b:penn_traces_in_tags
"		exec 'syntax keyword pennTraceInLabel ' . i . " containedin=pennTraceInLabelFilterSecond" 
"		unlet i
"	endfor
"	
"	syntax match pennLabelFilter /(.\{-}\(\s\|(\|)\)/hs=s+1,he=e-1 contains=@NoSpell
"	highlight link pennNodeICHNum Identifier
"
"	"syntax region pennTraceInLabelFilterFirst start=";" matchgroup=pennTraceInLabel end="\>" transparent contained
"	syntax match pennTraceInLabelFilterFirst ";" nextgroup=pennTraceInLabelFilterSecond contained
"	syntax region pennTraceInLabelFilterSecond start="" matchgroup=pennTraceInLabel end="\>" contained
"
"	" Comments
"	syntax region pennComment start="(COMMENT\s\{1,}{"hs=e+1 end="}"he=e-1 contains=@Spell
"
"	" Set highlights
"	highlight default link pennLabelFilter Error
"	highlight default link pennTraceInLabelFilterFirst Normal
"	"highlight default link pennTraceInLabelFilterFirst Error
"	highlight default link pennTraceInLabelFilterSecond Error
"
"	highlight link pennTagNonTerminal Label
"	highlight link pennTagTerminal Constant
"	highlight link pennComment Comment
"	highlight link pennTraceInLabel Special
"	highlight link pennTrace Special
endfunction
