"Editor behavior/keybinds
autocmd BufWritePre * %s/\s\+$//e "trim trailing whitespace on save
set autoindent
set backspace=indent,eol,start
set hlsearch
set incsearch
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<,space:·,
set nowrap
set shiftwidth=4
set splitbelow
set splitright
set tabstop=4

"Plugin loader
execute pathogen#infect()

"Navigation
" NERDTree
map <Leader>k :NERDTreeTabsToggle<CR>
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
" NERDTreeTabs
let g:nerdtree_tabs_open_on_gui_startup = 2
" CtrlP
map <Leader>p :CtrlP<CR>
map <Leader>r :CtrlPTag<CR>
let g:ctrlp_follow_symlinks = 1
" Tagbar
nmap <Leader>t :TagbarToggle<CR>
" incsearch.vim
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

"Syntax highlighting
colorscheme monokai
syntax enable
set tags=./.tags;,~/.vimtags
let g:easytags_async = 1
let g:easytags_dynamic_files = 1
let g:easytags_opts = ['--tag-relative=yes']

"Linting
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_rust_checkers = ['rustc']

"GVim-specific config
if has("gui_running")
	if has("gui_gtk2")
		set guifont=Inconsolata\ 12
	elseif has("gui_macvim")
		set guifont=Menlo\ Regular:h14
	elseif has("gui_win32")
		set guifont=Consolas:h13:cANSI
	endif
endif

"Status line (vim-airline)
set laststatus=2 "Make airline always appear

"Pane resizing
let g:winresizer_start_key = '<Leader>b'

"Markdown
augroup markdown
	au!
	au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

