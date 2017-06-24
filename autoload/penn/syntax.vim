function! penn#syntax#_init()
	if !exists("b:penn_tags")
		let b:penn_tags = g:penn_tags
	endif

	if !exists("b:penn_traces")
		let b:penn_traces = g:penn_traces
	endif

	if !exists("b:penn_traces_in_tags")
		let b:penn_traces_in_tags = g:penn_traces_in_tags
	endif
	

	" sort b:penn_tags
	" YET TO BE IMPLEMENTED

	" Define syntax
	syntax case match
	syntax iskeyword a-z,A-Z,48-57,-,*,_

	" Node Labels
	" match: pennNodeLabelError
	" alternavites: pennNodeLabel (overwritten by this)
	syntax match pennNodeLabelError
	\	'\((\_s*\)\([^[:blank:])(]\|{\_.\{-}\)\+\(\_s\+[^[:blank:])]\)\@='hs=s+1 
	\	contains=NONE
	" Set highlights
	highlight link pennNodeLabelError Error

	" match: pennNodeLabel
	" successors: pennNodeTerminal, pennNodeTerminalBracket
	" NOTE: We don't need to match { ... } in the most strict way that
	" the levels of recursion are respected. This will be done by
	" the pennNodeAdditional region.
	for i in b:penn_tags
		exec 'syntax match pennNodeLabel '
		\	. '"(\_s*' . i[0]
		\	. '\(-\d\+\)\?\(;{\_.\{-}}\)\?\ze\_s*[^[:blank:])]" '
		\	. 'nextgroup=pennNodeTerminal,pennNodeTerminalBracket '
		\	. 'skipwhite skipempty'
	endfor

	" match: pennTagTerminal, pennTagNonTerminal
	" successors: pennNodeICHNum, pennNodeTerminals
	for i in b:penn_tags
		" check whether i is terminal node
		if i[1]
			let l:labelmatch = "pennTagTerminal"
		else
			let l:labelmatch = "pennTagNonTerminal"
		endif

		exec 'syntax match '
			\ . l:labelmatch . ' "(\_s*\zs'
			\ . i[0]
			\ . '" nextgroup=pennNodeICHNum,pennNodeLabelAdditional containedin=pennNodeLabel'
	endfor
	" Set highlights
	highlight link pennTagNonTerminal Label
	highlight link pennTagTerminal Constant


	" match: pennNodeICHNum
	syntax match pennNodeICHNum "-\d\+" containedin=NONE nextgroup=pennNodeLabelAdditional
	" Set highlights
	highlight link pennNodeICHNum Identifier

	" region: pennNodeLabelAdditional
	syntax region pennNodeLabelAdditional start=";{" skip='\\.' end="}" containedin=NONE contains=NONE
	" Set highlights
	highlight link pennNodeLabelAdditional Special

		
	" Traces
	" match: pennTrace
	" spell check enabled
	for i in b:penn_traces
		exec "syntax match pennTrace '" . i . "' containedin=pennNodeTerminals"
	endfor
	" Set highlights
	highlight link pennTrace Special

	" Terminal Nodes
	" match: pennNodeTerminal
	" spell check enabled
	syntax match pennNodeTerminal
	\	'[^[:blank:]()]\+' 
	\	containedin=NONE contains=@Spell
	\	nextgroup=pennNodeTerminal,pennNodeTerminalBracket
	\	skipwhite skipempty
	" Set highlights
	" NONE
	
	" Comments
	" match: pennComment
	syntax match pennComment
	\	'(\_s*COMMENT'hs=s+1
	\	nextgroup=pennCommentBracket
	\	skipwhite skipempty 
	syntax region pennCommentBracket
	\	start='{' skip='\\.' end='}'
	\	containedin=NONE contains=NONE,@Spell 
	" Set highlights
	highlight link pennComment Comment
	highlight link pennCommentBracket Comment

	syntax region pennNodeTerminalBracket
	\	start='{' skip='\\.' end='}' 
	\	containedin=NONE contains=@Spell
	\	nextgroup=pennNodeTerminal,pennNodeTerminalBracket
	\	skipwhite skipempty
	
	" Set highlights
	" NONE
endfunction
