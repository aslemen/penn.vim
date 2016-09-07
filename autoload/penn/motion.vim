function! penn#motion#sentence_all
	silent! normal! v
	let l:prev_pos=getpos(".") +  getpos("v")

	silent! normal! a(
	let l:pres_pos=getpos(".") +  getpos("v")
	
	while l:prev_pos != l:pres_pos
		silent! normal! a(

		let l:prev_pos= l:pres_pos
		let l:pres_pos= getpos(".") +  getpos("v")
	endwhile
endfunction

function! penn#motion#node_all
	silent! normal! v
	silent! normal! a(
endfunction
