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
map <Leader>k :NERDTreeTabsToggle<CR>
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
map <Leader>p :CtrlP<CR>
map <Leader>r :CtrlPTag<CR>
let g:ctrlp_follow_symlinks = 1

"Syntax highlighting
colorscheme monokai
syntax enable
set tags=./.tags;,~/.vimtags

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

"Markdown
augroup markdown
	au!
	au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

