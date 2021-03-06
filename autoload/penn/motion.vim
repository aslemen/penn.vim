" define <plug>
function! penn#motion#_init()
	map <silent><buffer> <plug>penn_motion_sentence_all <SID>penn_motion_sentence_all
	map <silent><buffer> <plug>penn_motion_sentence_inner <SID>penn_motion_sentence_inner
	map <silent><buffer> <plug>penn_text_obj_sentence_all <SID>penn_text_obj_sentence_all
	map <silent><buffer> <plug>penn_text_obj_sentence_inner <SID>penn_text_obj_sentence_inner

	map <silent><buffer> <plug>penn_motion_node_all <SID>penn_motion_node_all
	map <silent><buffer> <plug>penn_motion_node_inner <SID>penn_motion_node_inner
	map <silent><buffer> <plug>penn_text_obj_node_all <SID>penn_text_obj_node_all
	map <silent><buffer> <plug>penn_text_obj_node_inner <SID>penn_text_obj_node_inner

	map <silent><buffer> <plug>penn_motion_adjacentnode_forward  <SID>penn_motion_adjacentnode_forward
	map <silent><buffer> <plug>penn_motion_adjacentnode_backward  <SID>penn_motion_adjacentnode_backward
	map <silent><buffer> <plug>penn_text_obj_adjacentnode_forward  <SID>penn_text_obj_adjacentnode_forward
	map <silent><buffer> <plug>penn_text_obj_adjacentnode_backward  <SID>penn_text_obj_adjacentnode_backward

" define <SID>
	noremap <silent><buffer> <SID>penn_motion_sentence_all :<c-u>call penn#motion#sentence(1, 1)<cr>
	noremap <silent><buffer> <SID>penn_motion_sentence_inner :<c-u>call penn#motion#sentence(0, 1)<cr>
	noremap <silent><buffer> <SID>penn_text_obj_sentence_all :<c-u>call penn#motion#sentence(1, 0)<cr>
	noremap <silent><buffer> <SID>penn_text_obj_sentence_inner :<c-u>call penn#motion#sentence(0, 0)<cr>

	noremap <silent><buffer> <SID>penn_motion_node_all :<c-u>call penn#motion#node(1, 1)<cr>
	noremap <silent><buffer> <SID>penn_motion_node_inner :<c-u>call penn#motion#node(0, 1)<cr>
	noremap <silent><buffer> <SID>penn_text_obj_node_all :<c-u>call penn#motion#node(1, 0)<cr>
	noremap <silent><buffer> <SID>penn_text_obj_node_inner :<c-u>call penn#motion#node(0, 0)<cr>

	noremap <silent><buffer> <SID>penn_motion_adjacentnode_forward  :<c-u>call penn#motion#adjacentnode(0, 1)<cr>
	noremap <silent><buffer> <SID>penn_motion_adjacentnode_backward  :<c-u>call penn#motion#adjacentnode(1, 1)<cr>
	noremap <silent><buffer> <SID>penn_text_obj_adjacentnode_forward  :<c-u>call penn#motion#adjacentnode(0, 0)<cr>
	noremap <silent><buffer> <SID>penn_text_obj_adjacentnode_backward  :<c-u>call penn#motion#adjacentnode(1, 0)<cr>
endfunction

function! penn#motion#sentence(isall, visual)
	if a:visual == 0
		"normal mode
		silent! normal! v
	elseif a:visual == 1
		"visual mode
		silent! normal! gv
	end
	" no changing mode when called internally

	let l:prev_pos=getpos(".") +  getpos("v")

	silent! call penn#motion#node(a:isall, 2)

	let l:pres_pos=getpos(".") +  getpos("v")

	while l:prev_pos != l:pres_pos
		silent! call penn#motion#node(a:isall, 2)

		let l:prev_pos= l:pres_pos
		let l:pres_pos= getpos(".") + getpos("v")
	endwhile
endfunction

function! penn#motion#newnode(ispartial, isall, isvisual)
	"if a:isvisual
		"" visual mode
		"" recall last selected area
		"silent! normal! gv
	"else
		"" normal mode
		"silent! normal! v
	"endif
	
	let l:init_pos_start = getpos(".")
	let l:init_pos_end = getpos("v")

	"reordering?
	
	" set parameters
	let l:par_start = '(.\{-}\s'
	let l:par_end = ')'
	let l:search_bwd_flag = 'bW'
	let l:search_fwd_flag = 'W'
	if a:ispartial
		" the mother node is to be excluded
		let l:search_bwd_flag += 'e'
	endif
	if a:isall
		" match all the sentence
		let l:search_bwd_flag += 'r'
		let l:search_fwd_flag += 'r'
	endif

	" begin search 	
	setpos(".", l:init_pos_start)
	let l:target_pos_start = searchpairpos(l:par_start, '', l:par_end, l:search_bwd_flag)
	setpos(".", l:init_pos_end)
	let l:target_pos_end = searchpairpos(l:par_start, '', l:par_end, l:search_fwd_flag)

	" grab the area
	setpos(".", l:target_pos_start)
	silent! normal! v
	setpos(".", l:target_pos_end)
endfunction

function! penn#motion#node(isall, visual)
	if a:visual == 0
		"normal mode
		silent! normal! v
	elseif a:visual == 1
		"visual mode
		silent! normal! gv
	endif
	
	if !a:isall
	" check if the selected range is already 'vis'
		let l:prev_pos=getpos(".") +  getpos("v")

		silent! normal! a(
				
		if match(@*, "^\s$") == -1
			silent! normal! hoW
		endif

		let l:pres_pos1=getpos(".") +  getpos("v")
		let l:pres_pos2=getpos("v") +  getpos(".")

		if l:prev_pos == l:pres_pos1 || l:prev_pos == l:pres_pos2
			" exactly vis
			" extend it to 'vas'
			silent! normal! a(
		endif
	endif

	silent! normal! a(
	if !a:isall
		if match(@*, "^\s$") == -1
			silent! normal! hoW
		endif
	endif
endfunction

"bug on back
function! penn#motion#adjacentnode(back, visual)
	if a:visual == 0
		silent! normal! v
	else
		silent! normal! gv
	endif

	let l:pres_pos_start = getpos("v")
	let l:pres_pos_end = getpos(".")

	if (l:pres_pos_start[1] > l:pres_pos_end[1]) || (l:pres_pos_start[1] == l:pres_pos_end[1] && l:pres_pos_start[2] > l:pres_pos_end[2])
		let l:pres_pos_buffer =  l:pres_pos_start
		let l:pres_pos_start = l:pres_pos_end
		let l:pres_pos_end = l:pres_pos_buffer
	endif

	if a:back
		"going backward
		"switch pos again
		let l:pres_pos_buffer =  l:pres_pos_start
		let l:pres_pos_start = l:pres_pos_end
		let l:pres_pos_end = l:pres_pos_buffer
	endif

	"get out of visual mode
	silent! normal  

	call cursor(l:pres_pos_end[1:])
	
	let l:flag = 'Wn'
	if a:back
		let l:flag .= 'b'
	else
		let l:flag .= 'z'
	endif

	let l:cand_pos = searchpos('\((\|)\)', l:flag)
	
	let l:candstr =  matchstr(getline(l:cand_pos[0]), '\%' . l:cand_pos[1] . 'c.')

	"set default goal
	let l:goal_pos = l:pres_pos_end

	let l:target = "("
	let l:nontarget = ")"

	if a:back
		let l:target = ")"
		let l:nontarget = "("
	endif

	let l:flag = 'W'
	if a:back
		let l:flag .= 'b'
	endif

	if l:candstr == l:target 
		" Sister nodes found
		" Move cursor to ( / )
		call cursor(l:cand_pos)
		
		" find paired ) / (
		"echom getpos(".")[1] . getpos(".")[2]
		let l:match_res =  searchpair("(", "", ")",  l:flag)

		"if found
		if l:match_res
			"keep l:cand_pos
			let l:goal_pos = getpos(".")
		else
			"if not found
			" no use of l:goal_pos
			let l:goal_pos = l:pres_pos_end
		endif
	endif

	if a:visual
		"if in visual mode
		"select the area"
		call cursor(l:pres_pos_start[1:])
		silent! normal v
		call cursor(l:goal_pos[1:])
	else
		"if not in visual mode
		"move to l:cand_pos
		call cursor(l:goal_pos[1:])
	endif
endfunction
