let g:ctrlp_follow_symlinks = 1
let g:ctrlp_extensions = ['buffertag', 'line']
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

map <Leader>p :CtrlP<CR>
map <Leader>P :CtrlPBuffer<CR>
map <Leader>r :CtrlPBufTag %<CR>
map <Leader>R :CtrlPTag<CR>
map <Leader>/ :CtrlPLine<CR>

" NERDTreeTabs
let g:nerdtree_tabs_open_on_gui_startup = 2
map <Leader>k :NERDTreeTabsToggle<CR>

" NERDTree_plugin_open
if has('unix')
	if has('mac') " osx
		let g:nerdtree_plugin_open_cmd = 'open'
	else " linux, bsd, etc
		let g:nerdtree_plugin_open_cmd = 'xdg-open'
	endif
elseif has('win32') || has('win64')
	let g:nerdtree_plugin_open_cmd = 'explorer'
endif

