function penn#omni#_init()
	" completion mode
	" 0: NONE
	" 1: node labels
	" 2: covert expressions
	" 3: binding info
	let s:complete_mode = 0
	
	setlocal omnifunc=penn#omni#complete

	au User CmSetup call cm#register_source({'name' : 'penn',
			\ 'priority': 9, 
			\ 'scoping': 1,
			\ 'scopes': ['penn'],
			\ 'abbreviation': 'penn',
			\ 'cm_refresh_patterns':['[({*]'],
			\ 'cm_refresh': {'omnifunc': 'penn#omni#complete'},
			\ 'cm_refresh_min_word_len': 1,
			\ })
endfunction

function penn#omni#complete(findstart, base)
	if a:findstart
		return penn#omni#complete_find()
	else
		return penn#omni#complete_list(a:base)
	endif
endfunction

function penn#omni#complete_find()
	let line = getline('.')
	let start = col('.') - 1
	while start > 0
		if line[start - 1 ] == ")"
			let s:complete_mode = 0
			return -2
		elseif line[start - 1] == "("
			let s:complete_mode = 1
			return start
		elseif line[start - 1] == '*'
			let s:complete_mode = 2
			return start - 1
		elseif line[start - 2 : start - 1] == ";{"
			let s:complete_mode = 3
			return start
		endif
		let start -= 1
	endwhile
	return -2
endfunction

function penn#omni#complete_list(base)
	let res = []
	if s:complete_mode == 1
		" complete node labels
		for m in b:penn_tags
			if m[0] =~ '^' . a:base
				call add(res, m[0])
			endif
		endfor
	elseif s:complete_mode == 2
		" covert expressions
		for m in b:penn_traces
			if m =~ '^' . a:base
				call add(res, m)
			endif
		endfor
	endif
	return res
endfunction
