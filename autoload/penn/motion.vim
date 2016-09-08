function! penn#motion#_init()
	map <silent><buffer> <plug>penn_motion_sentence_all  <SID>penn_motion_sentence_all  
	map <silent><buffer> <plug>penn_motion_sentence_inner  <SID>penn_motion_sentence_inner  
	map <silent><buffer> <plug>penn_text_obj_sentence_all <SID>penn_text_obj_sentence_all 
	map <silent><buffer> <plug>penn_text_obj_sentence_inner <SID>penn_text_obj_sentence_inner 

	map <silent><buffer> <plug>penn_motion_node_all  <SID>penn_motion_node_all  
	map <silent><buffer> <plug>penn_motion_node_inner  <SID>penn_motion_node_inner  
	map <silent><buffer> <plug>penn_text_obj_node_all <SID>penn_text_obj_node_all 
	map <silent><buffer> <plug>penn_text_obj_node_inner <SID>penn_text_obj_node_inner 

	noremap <silent><buffer> <SID>penn_motion_sentence_all  :<c-u>call penn#motion#sentence(1, 1)<cr>
	noremap <silent><buffer> <SID>penn_motion_sentence_inner  :<c-u>call penn#motion#sentence(0, 1)<cr>
	noremap <silent><buffer> <SID>penn_text_obj_sentence_all :<c-u>call penn#motion#sentence(1, 0)<cr>
	noremap <silent><buffer> <SID>penn_text_obj_sentence_inner :<c-u>call penn#motion#sentence(0, 0)<cr>

	noremap <silent><buffer> <SID>penn_motion_node_all  :<c-u>call penn#motion#node(1, 1)<cr>
	noremap <silent><buffer> <SID>penn_motion_node_inner  :<c-u>call penn#motion#node(0, 1)<cr>
	noremap <silent><buffer> <SID>penn_text_obj_node_all :<c-u>call penn#motion#node(1, 0)<cr>
	noremap <silent><buffer> <SID>penn_text_obj_node_inner :<c-u>call penn#motion#node(0, 0)<cr>
endfunction

function! penn#motion#sentence(isall, isvisual)
	if a:isvisual
		silent! normal! gv
	else
		silent! normal! v
	end

	let l:prev_pos=getpos(".") +  getpos("v")

	silent! normal! a(
	let l:pres_pos=getpos(".") +  getpos("v")

	while l:prev_pos != l:pres_pos
		silent! normal! a(

		let l:prev_pos= l:pres_pos
		let l:pres_pos= getpos(".") +  getpos("v")
	endwhile


	if !a:isall
		silent! normal! hoWhh
	endif
endfunction

function! penn#motion#node(isall, isvisual)
	if a:isvisual
		silent! normal! gv
	else
		silent! normal! v
	end
	
	if !a:isall
	" check if the selected range is already 'vis'
		let l:prev_pos=getpos(".") +  getpos("v")
	echo "prev_pos"
	echom join(l:prev_pos, ",")
		silent! normal! a(hoW
		let l:pres_pos1=getpos(".") +  getpos("v")
		let l:pres_pos2=getpos("v") +  getpos(".")
		
	echo "pres_pos1"
	echom join(l:pres_pos1, ",")
	echo "pres_pos2"
	echom join(l:pres_pos2, ",")
		if l:prev_pos == l:pres_pos1 || l:prev_pos == l:pres_pos2
			" exactly vis
			" extend it to 'vas'
			silent! normal! a(
		endif
	endif

	silent! normal! a(

	if !a:isall
		silent! normal! hoWh
	endif
endfunction


