"Editor behavior/keybinds
autocmd BufWritePre * %s/\s\+$//e "trim trailing whitespace on save
filetype plugin indent on
set autoindent
set backspace=indent,eol,start
set hlsearch
set hidden
set incsearch
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<,space:·,
set nowrap
set shiftwidth=4
set splitbelow
set splitright
set tabstop=4

"Plugin loader
execute pathogen#infect()

"Kill the need to use shift for :commands
nnoremap ; :

"Alias Q to do what we really want
command! Q :q
command! Qa :qa
command! QA :qa

"Overwrite files that need sudo
cmap w!! w !sudo tee % >/dev/null

".vimrc reloading/editing
nmap <silent> <leader>ve :vsp $MYVIMRC<CR>
nmap <silent> <leader>vs :so $MYVIMRC<CR>

"Navigation
" NERDTree
map <Leader>k :NERDTreeTabsToggle<CR>
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
" NERDTreeTabs
let g:nerdtree_tabs_open_on_gui_startup = 2
" CtrlP
map <Leader>p :CtrlP<CR>
map <Leader>P :CtrlPBuffer<CR>
map <Leader>r :CtrlPBufTag %<CR>
map <Leader>R :CtrlPTag<CR>
map <Leader>/ :CtrlPLine<CR>
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_extensions = ['buffertag', 'line']
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

"delimitMate
let g:delimitMate_expand_cr = 1

"Syntax highlighting
colorscheme monokai
syntax enable
set tags=./.tags;,~/.vimtags
let g:easytags_async = 1
let g:easytags_dynamic_files = 1
let g:easytags_opts = ['--tag-relative=yes']

"Linting
let g:syntastic_always_populate_loc_list = 1
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

"Project-specific config
let g:localvimrc_persistent = 1

"Status line (vim-airline)
let g:airline#extensions#tabline#enabled = 1
set laststatus=2 "Make airline always appear

"Pane resizing
let g:winresizer_start_key = '<Leader>b'

"Markdown
augroup markdown
	au!
	au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

"Sublime files
augroup sublime
	au!
	au BufNewFile,BufRead *.sublime-project,*.sublime-build,*.sublime-snippet setlocal filetype=json
augroup END

