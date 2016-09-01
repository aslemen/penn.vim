" set default values
if !exists("g:penn_ftdetect_ext")
	let g:penn_ftdetect_ext = "psd"
endif

if !exists("g:penn_ftdetect_enabled")
	let g:penn_ftdetect_enabled = 1
endif

if !exists("g:penn_ftdetect_force")
	let g:penn_ftdetect_force = 0
endif

if g:penn_ftdetect_enabled
	if g:penn_ftdetect_force
		exec "au BufRead,BufNewFile *." . g:penn_ftdetect_ext "set filetype=penn"
	else
		exec "au BufRead,BufNewFile *." . g:penn_ftdetect_ext "setfiletype penn"
	endif
endif
