" penn Penn Treebank plugin for Vim 
"
" Maintainer: Tatsuya Hayashi <net@hayashi-lin.net>
" Last Modified: 2016 Sep 4

if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

call penn#motion#_init()

vmap <silent><buffer> as <plug>penn_motion_sentence_all
vmap <silent><buffer> is <plug>penn_motion_sentence_inner
omap <silent><buffer> as <plug>penn_text_obj_sentence_all
omap <silent><buffer> is <plug>penn_text_obj_sentence_inner

vmap <silent><buffer> an <plug>penn_motion_node_all
vmap <silent><buffer> in <plug>penn_motion_node_inner
omap <silent><buffer> an <plug>penn_text_obj_node_all
omap <silent><buffer> in <plug>penn_text_obj_node_inner

vmap <silent><buffer> n <plug>penn_motion_adjacentnode_forward
vmap <silent><buffer> N <plug>penn_motion_adjacentnode_backward
omap <silent><buffer> ]n <plug>penn_motion_adjacentnode_forward
omap <silent><buffer> [n <plug>penn_motion_adjacentnode_backward

call penn#omni#_init()
