set tags=.tags
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1

" ctrlp-tjump extension
let g:ctrlp_tjump_only_silent = 1
nnoremap <c-]> :CtrlPtjump<CR>
vnoremap <c-]> :CtrlPtjumpVisual<CR>

" Tagbar
nmap <Leader>t :TagbarToggle<CR>

augroup tags
	au!
	au BufNewFile,BufRead .tags setlocal filetype=tags
augroup END

