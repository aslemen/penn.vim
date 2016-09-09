function! penn#motion#_init()
	map <silent><buffer> <plug>penn_motion_sentence_all <SID>penn_motion_sentence_all
	map <silent><buffer> <plug>penn_motion_sentence_inner <SID>penn_motion_sentence_inner
	map <silent><buffer> <plug>penn_text_obj_sentence_all <SID>penn_text_obj_sentence_all
	map <silent><buffer> <plug>penn_text_obj_sentence_inner <SID>penn_text_obj_sentence_inner

	map <silent><buffer> <plug>penn_motion_node_all <SID>penn_motion_node_all
	map <silent><buffer> <plug>penn_motion_node_inner <SID>penn_motion_node_inner
	map <silent><buffer> <plug>penn_text_obj_node_all <SID>penn_text_obj_node_all
	map <silent><buffer> <plug>penn_text_obj_node_inner <SID>penn_text_obj_node_inner

	noremap <silent><buffer> <SID>penn_motion_sentence_all :<c-u>call penn#motion#sentence(1, 1)<cr>
	noremap <silent><buffer> <SID>penn_motion_sentence_inner :<c-u>call penn#motion#sentence(0, 1)<cr>
	noremap <silent><buffer> <SID>penn_text_obj_sentence_all :<c-u>call penn#motion#sentence(1, 0)<cr>
	noremap <silent><buffer> <SID>penn_text_obj_sentence_inner :<c-u>call penn#motion#sentence(0, 0)<cr>

	noremap <silent><buffer> <SID>penn_motion_node_all :<c-u>call penn#motion#node(1, 1)<cr>
	noremap <silent><buffer> <SID>penn_motion_node_inner :<c-u>call penn#motion#node(0, 1)<cr>
	noremap <silent><buffer> <SID>penn_text_obj_node_all :<c-u>call penn#motion#node(1, 0)<cr>
	noremap <silent><buffer> <SID>penn_text_obj_node_inner :<c-u>call penn#motion#node(0, 0)<cr>
endfunction

function! penn#motion#sentence(isall, mode)
	if a:mode == 0
		"normal mode
		silent! normal! v
	elseif a:mode == 1
		"visual mode
		silent! normal! gv
	end
	" no changing mode when called internally

	let l:prev_pos=getpos(".") +  getpos("v")

	silent! call penn#motion#node(a:isall, 2)

	let l:pres_pos=getpos(".") +  getpos("v")

	" echo "sentence: prev_pos"
	" echom join(l:prev_pos, ",")
	" echo "sentence: pres_pos"
	" echom join(l:pres_pos, ",")

	while l:prev_pos != l:pres_pos
		silent! call penn#motion#node(a:isall, 2)
		" call penn#motion#node(a:isall, 2)

		let l:prev_pos= l:pres_pos
		let l:pres_pos= getpos(".") + getpos("v")
		" echo "sentence: prev_pos"
		" echom join(l:prev_pos, ",")
		" echo "sentence :pres_pos"
		" echom join(l:pres_pos, ",")
	endwhile
endfunction

function! penn#motion#node(isall, mode)
	if a:mode == 0
		"normal mode
		silent! normal! v
	elseif a:mode == 1
		"visual mode
		silent! normal! gv
	end
	
	if !a:isall
	" check if the selected range is already 'vis'
		let l:prev_pos=getpos(".") +  getpos("v")

	" echo "prev_pos"
	" echom join(l:prev_pos, ",")
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

	let l:pres_pos= getpos(".") + getpos("v")
		" echo "node: pres_pos"
		" echom join(l:pres_pos, ",")

endfunction
