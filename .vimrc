fun! s:create_new_post_plug_config()
	let context = { 'tasks': [] }
	fun context.run() dict
		for task in self.tasks
			call function(task)()
		endfor
	endfun
	fun context.add_task(task) dict
		call add(self.tasks, a:task)
	endfun
	return context
endfun

let s:post_plug_config = s:create_new_post_plug_config()
call s:post_plug_config.run()

call plug#begin('~/.vim/bundle')

Plug 'dyng/ctrlsf.vim'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs' | Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs' | Plug 'scrooloose/nerdtree'
Plug 'aufgang001/vim-nerdtree_plugin_open' | Plug 'scrooloose/nerdtree'
Plug 'aufgang001/vim-nerdtree_plugin_open' | Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ivalkeen/vim-ctrlp-tjump' | Plug 'ctrlpvim/ctrlp.vim'
Plug 'ivalkeen/vim-ctrlp-tjump' | Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher' | Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher' | Plug 'ctrlpvim/ctrlp.vim'
Plug 'ErichDonGubler/nerdtree-ctrlp-root' | Plug 'ctrlpvim/ctrlp.vim' | Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'scrooloose/nerdtree'
Plug 'xolox/vim-easytags' | Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags' | Plug 'xolox/vim-misc'
Plug 'majutsushi/tagbar' | Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar' | Plug 'xolox/vim-easytags'
Plug 'simeji/winresizer'
Plug 'embear/vim-localvimrc'
Plug 'vim-airline/vim-airline'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'terryma/vim-expand-region'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'terryma/vim-multiple-cursors'
Plug 'EinfachToll/DidYouMean'
Plug 'danro/rename.vim'
Plug 'pbrisbin/vim-mkdir'
Plug 'vim-scripts/ZoomWin'
Plug 'xolox/vim-shell' | Plug 'xolox/vim-misc'
Plug 'xolox/vim-shell' | Plug 'xolox/vim-misc'
Plug 'mtth/scratch.vim'
Plug 'mattn/emmet-vim'
Plug 'gko/vim-coloresque'
Plug 'vim-syntastic/syntastic'
Plug 'benmills/vimux'
Plug 'peterrincker/vim-argumentative'
Plug 'wellle/targets.vim'
Plug 'kopischke/vim-fetch'

" Snippet
let g:snipMate = get(g:, 'snipMate', {})
let g:snipMate.snippet_version = 1
Plug 'garbas/vim-snipmate' | Plug 'tomtom/tlib_vim' | Plug 'MarcWeber/vim-addon-mw-utils' | Plug 'honza/vim-snippets'

" Markdown
Plug 'jtratner/vim-flavored-markdown'

" Rust
Plug 'rust-lang/rust.vim'

" C#
Plug 'OrangeT/vim-csharp'

Plug 'cespare/vim-toml'

" Orgmode
Plug 'jceb/vim-orgmode' | Plug 'tpope/vim-speeddating'
Plug 'gelguy/cmd2.vim'

" Search
Plug 'haya14busa/incsearch.vim'

" Syntax coloring: scheme and font
Plug 'pangloss/vim-javascript'

Plug 'octol/vim-cpp-enhanced-highlight'

if has("gui_running")
	if has("gui_gtk2")
		set guifont=Inconsolata\ 12
	elseif has("gui_macvim")
		set guifont=Menlo\ Regular:h14
	elseif has("gui_win32")
		set guifont=Consolas:h13:cANSI
	endif
endif
Plug 'crusoexia/vim-monokai'
fun! s:configure_colors()
	colorscheme monokai
endfun
call s:post_plug_config.add_task('s:configure_colors')

call plug#end()
call s:post_plug_config.run()

" Normally Pathogen would do this, but we like VimPlug. :)
:command Helptags call plug#helptags()

aug QFClose
	au!
	au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" Fix terminal-specific settings so we get the correct colors and keybinds
set term=xterm-256color
set t_ut=
if &term =~ '^screen'
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"
	map <Esc>[B <Down>
endif
set t_Co=256

" Buffer options
set hidden
set splitbelow
set splitright

" Kill the need to use shift for :commands
nnoremap ; :

" Alias Q to do what we really want
command! Q :q
command! Qa :qa
command! QA :qa

" Overwrite files that need sudo
cmap w!! w !sudo tee % >/dev/null

" Navigation
"  Buffer nav
map <C-PageUp> :bp<CR>
map <C-PageDown> :bn<CR>

"  Line numbers
set cursorline
set number
nnoremap <Leader>n :set number!<CR>

" Builds
map <Leader>b :make<CR>
map <Leader>B :compiler<Space>

" Diffs
set diffopt+=vertical

" CLI convenience binds
fun! SilentCommand()
	let command = input('Type command:')
	exec 'silent !' . command
	redraw!
endfun
nmap <Leader>! :call SilentCommand()<CR>
nmap <Leader>1 :call SilentCommand()<CR>

" Searches
set hlsearch
set ignorecase
set incsearch
set smartcase
highlight clear Search
highlight Search gui=underline cterm=underline
if executable('rg')
	set grepprg=rg\ --color=never\ --follow
else
	echom 'ripgrep not found, using slower file searching'
endif
map <Leader>h :%s/

let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

nnoremap <Leader>F :CtrlSF<Space>
let g:ctrlsf_mapping = {
			\ "next": "n",
			\ "prev": "N",
			\ }
nnoremap <Leader>f :CtrlSFToggle<CR>

" EDITING

" Trim trailing whitespace on save
function! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Use Ctrl-Enter to go to a new line
imap <C-CR> <Esc>o
imap  <Esc>o

" Use Shift-Delete to delete the current line
set <S-Del>=[3;2~
nmap <S-Del> dd
imap <S-Del> <Esc>ddi
" Here, the bind only deletes the content of the lines, not the lines themselves
vmap <S-Del> ^o$d

" General indentation behavior
set autoindent
set backspace=indent,eol,start
set shiftwidth=4
set tabstop=4

" Indentation binds
nnoremap <S-Tab> <<
nnoremap <Tab> >>
inoremap <S-Tab> <C-d>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Splitjoin functionality
let g:splitjoin_split_mapping = ''
nmap gj :SplitjoinSplit<CR>

nmap <Leader>v <C-v>^o$

" Whitespace character viewing
set listchars=eol:�,tab:>-,trail:~,extends:>,precedes:<,space:�,
nnoremap <Leader>l :set list!<CR>

" Wrapping behavior
set breakindentopt=shift:2
set nobreakindent
set nolinebreak
set nowrap

fun! ToggleWordWrap()
	echo 'Toggled word wrap'
	set wrap!
	set linebreak!
	set breakindent!
endfun
nnoremap <Leader>w :call ToggleWordWrap()<CR>

" File navigator
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:nerdtree_tabs_open_on_gui_startup = 2
map <Leader>k :NERDTreeTabsToggle<CR>

if has('unix') && !has("win32unix")
	if has('mac') " osx
		let g:nerdtree_plugin_open_cmd = 'open'
	else " linux, bsd, etc
		let g:nerdtree_plugin_open_cmd = 'xdg-open'
	endif
else
	let g:nerdtree_plugin_open_cmd = 'explorer'
endif

" Fuzzy searching
let g:ctrlp_by_filename = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_extensions = ['buffertag', 'line']
if executable('rg')
"	let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
"	let g:ctrlp_use_caching = 0
endif
let g:ctrlp_map = '<Leader>p'
map <Leader>p :CtrlP<CR>
map <Leader>P :CtrlPBuffer<CR>
map <Leader>o :CtrlPMRU<CR>
map <Leader>r :CtrlPBufTag %<CR>
map <Leader>R :CtrlPTag<CR>
map <Leader>/ :CtrlPLine<CR>
let g:ctrlp_tjump_only_silent = 1
nnoremap <c-]> :CtrlPtjump<CR>
vnoremap <c-]> :CtrlPtjumpVisual<CR>
if has('python')
	let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
else
	echom 'python not found, using slower fuzzy finder'
endif

" Git integration
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "M",
    \ "Staged"    : "S",
    \ "Untracked" : "U",
    \ "Renamed"   : "R",
    \ "Unmerged"  : "=",
    \ "Deleted"   : "D",
    \ "Dirty"     : "!",
    \ "Clean"     : "âï¸",
    \ 'Ignored'   : 'I',
    \ "Unknown"   : "?"
    \ }

" Tags integration
set tags=.tags
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
nmap <Leader>t :TagbarToggle<CR>

augroup tags
	au!
	au BufNewFile,BufRead .tags setlocal filetype=tags
augroup END

"Vimux prefs
let g:VimuxOrientation = "h"

" Window resizing
let g:winresizer_start_key = '<Leader>e'

" Projects functionality
let g:localvimrc_persistent = 1

let g:airline#extensions#tabline#enabled = 1
set laststatus=2 " Make airline always appear

" Code editing niceties
let g:delimitMate_expand_cr = 1

" Linting/Error reporting
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_rust_checkers = ['rustc']

let $VIMHOME = $HOME."/.vim"
nmap <silent> <leader>ve :vsp $VIMHOME<CR>
nmap <silent> <leader>vs :so $MYVIMRC<CR>

" Markdown
augroup markdown
	au!
	au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END
let g:tagbar_type_markdown = {
	\ 'ctagstype' : 'markdown',
	\ 'kinds' : [
		\ 'h:Heading_L1',
		\ 'i:Heading_L2',
		\ 'k:Heading_L3'
	\ ]
\ }

" Sublime config files
augroup sublime
	au!
	au BufNewFile,BufRead *.sublime-project,*.sublime-build,*.sublime-snippet setlocal filetype=json
augroup END

" Datetime insertion
nnoremap <F5> "=strftime("%F")<CR>P
inoremap <F5> <C-R>=strftime("%F")<CR>
nnoremap <S-F5> "=strftime("%F %T")<CR>P
inoremap <S-F5> <C-R>=strftime("%F %T")<CR>

