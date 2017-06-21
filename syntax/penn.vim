" Vim syntax file
" Language:     Penn Treebank
" Maintainer:   Tatsuya Hayashi <net@hayashi-lin.net> 
" Last Change:  2016 Sep 2

if exists("b:current_syntax")
  finish
endif
let b:current_syntax="penn"

" Set default tags
" Terminal tags
if !exists("g:penn_tags")
	let g:penn_tags = [
		\'PRP$', 
		\'NNPS', 
		\'WP$', 
		\'WDT', 
		\'VBZ', 
		\'VBP', 
		\'VBN', 
		\'VBG', 
		\'VBD', 
		\'SYM', 
		\'RBS', 
		\'RBR', 
		\'PRP', 
		\'POS', 
		\'PDT', 
		\'NNS', 
		\'NNP', 
		\'JJS', 
		\'JJR', 
		\'WRB',
		\'WP', 
		\'VB', 
		\'UH', 
		\'TO', 
		\'RP', 
		\'RB', 
		\'NN', 
		\'MD', 
		\'LS', 
		\'JJ', 
		\'IN', 
		\'FW', 
		\'EX', 
		\'DT', 
		\'CD', 
		\'CC'] 
endif

if !exists("g:penn_traces")
	let g:penn_traces = []
endif

if !exists("g:penn_traces_in_tags")
	let g:penn_traces_in_tags = []
endif
call penn#syntax#_init()
