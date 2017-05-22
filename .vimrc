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

call plug#begin('~/.vim/bundle')
let s:post_plug_config = s:create_new_post_plug_config()

" Bindings for vanilla vim
set iskeyword-=.
let maplocalleader = '|'
"   Vim config manipulation
let $VIMHOME = $HOME."/.vim"
nmap <silent> <leader>ve :vsp $VIMHOME<CR>
nmap <silent> <leader>vs :so $MYVIMRC<CR>
set directory=$HOME/.vim/.swapfiles//
set backupdir=$HOME/.vim/.backups//
"   Kill the need to use shift for :commands
nnoremap ; :
"   Alias Q to do what we really want
command! Q :q
command! Qa :qa
command! QA :qa
"   Overwrite files that need sudo
cmap w!! w !sudo tee % >/dev/null
"   Make Home go to the beginning of the indented line, not the line itself
nnoremap <Home> ^
"   Use Ctrl-Enter to go to a new line
imap <C-CR> <Esc>o
imap  <Esc>o
"   Use Shift-Delete to delete the current line
set <S-Del>=[3;2~
nmap <S-Del> dd
imap <S-Del> <Esc>ddi
"     Here, the bind only deletes the content of the lines, not the lines themselves
vmap <S-Del> ^o$d
"   Add some common line-ending shortcuts
nnoremap <Leader>; <Esc>A;
nnoremap <Leader>. <Esc>A.
Plug 'ErichDonGubler/vim-file-browser-integration'
nnoremap <Leader>e :SelectCurrentFile<CR>
nnoremap <Leader>x :OpenCurrentFile<CR>
nnoremap <Leader>E :OpenCWD<CR>
"   CLI convenience binds
fun! SilentCommand(command)
	echom 'Executing silent command: "' . a:command . '"'
	exec 'silent !' . a:command
	redraw!
endfun
function! PromptSilentCommand()
	let l:command = input('Type command:')
	if strln(l:command)
		call SilentCommand(l:command)
	else
		echo 'No command specified, doing nothing'
	endif
endfun
nmap <Leader>! :call PromptSilentCommand()<CR>
nmap <Leader>1 :call PromptSilentCommand()<CR>

" VimPlug
let g:plug_window = 'enew'
"   Helptags command: Normally Pathogen would do this, but we like VimPlug. :)
:command! Helptags call plug#helptags()

" Project configuration
Plug 'embear/vim-localvimrc'
let g:localvimrc_persistent = 1
let g:localvimrc_sandbox = 0

" UI functionalities
if has("gui_running")
	if has("gui_gtk2")
		set guifont=Inconsolata\ 12
	elseif has("gui_macvim")
		set guifont=Menlo\ Regular:h14
	elseif has("gui_win32")
		set guifont=Consolas:h13:cANSI
	endif
endif
"    Fix terminal-specific settings so we get the correct colors and keybinds
" set term=xterm-256color
set t_ut=
if &term =~ '^screen'
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"
	map <Esc>[B <Down>
	map <Esc>[5;5~ <C-PageUp>
	map <Esc>[6;5~ <C-PageDown>
endif
set t_Co=256

Plug 'crusoexia/vim-monokai'
fun! s:configure_colors()
	colorscheme monokai
endfun
call s:post_plug_config.add_task('s:configure_colors')
"   Status lines
Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
set laststatus=2 " Make airline always appear
"   Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'scrooloose/nerdtree'
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
"   Pane manipulation
set hidden
set splitbelow
set splitright
Plug 'vim-scripts/ZoomWin'
Plug 'simeji/winresizer'
let g:winresizer_start_key = '<Leader><CR>'
"   Diffs
set diffopt+=vertical
"   Notes
Plug 'mtth/scratch.vim'
"   tmux integration
Plug 'benmills/vimux'
let g:VimuxOrientation = "h"
"   Close quickfix window with q
aug QFClose
	au!
	au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END
"  Line numbers
set cursorline
set number
nnoremap <Leader>n :set number!<CR>
" Distraction-free mode
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
  call EnableWrap()
  Limelight
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  call DisableWrap()
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
nnoremap <Leader>g :Goyo<CR>

" Symbols
set tags=.tags
augroup tags
	au!
	au BufNewFile,BufRead .tags setlocal filetype=tags
augroup END
Plug 'xolox/vim-easytags' | Plug 'xolox/vim-misc'
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
Plug 'majutsushi/tagbar' | Plug 'xolox/vim-easytags'
nmap <Leader>t :TagbarToggle<CR>

" TODO: ???
Plug 'xolox/vim-shell' | Plug 'xolox/vim-misc'

" Fuzzy matching facilities
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_by_filename = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_extensions = ['buffertag', 'line']
if executable('rg')
	let g:ctrlp_user_command = 'rg %s --follow --files --color=never'
	let g:ctrlp_use_caching = 0
endif
let g:ctrlp_map = '<Leader>p'
map <Leader>p :CtrlP<CR>
map <Leader>P :CtrlPBuffer<CR>
map <Leader>o :CtrlPMRU<CR>
map <Leader>r :CtrlPBufTag %<CR>
map <Leader>R :CtrlPTag<CR>
map <Leader>/ :CtrlPLine<CR>
Plug 'ivalkeen/vim-ctrlp-tjump' | Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_tjump_only_silent = 1
nnoremap <c-]> :CtrlPtjump<CR>
vnoremap <c-]> :CtrlPtjumpVisual<CR>
Plug 'FelikZ/ctrlp-py-matcher' | Plug 'ctrlpvim/ctrlp.vim'
if has('python')
	let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
else
	echom 'python not found, using slower fuzzy finder'
endif

" Files
"   Navigation
Plug 'scrooloose/nerdtree'
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
function! s:clearFilesAndOpenNERDTree()
	echom 'Sup!'
	:bufdo bdelete
	:NERDTreeToggle
endfun
map <Leader>K call <SID>clearFilesAndOpenNERDTree()
Plug 'jistr/vim-nerdtree-tabs' | Plug 'scrooloose/nerdtree'
let g:nerdtree_tabs_open_on_gui_startup = 2
map <Leader>k :NERDTreeTabsToggle<CR>
Plug 'ErichDonGubler/nerdtree-plugin-open-in-file-browser' | Plug 'scrooloose/nerdtree'
Plug 'ErichDonGubler/nerdtree-ctrlp-root' | Plug 'ctrlpvim/ctrlp.vim' | Plug 'scrooloose/nerdtree'
"   Path/creation
Plug 'EinfachToll/DidYouMean'
Plug 'danro/rename.vim'
Plug 'pbrisbin/vim-mkdir'
Plug 'kopischke/vim-fetch'

" Text manipulation intelligence

"   Whitespace
set autoindent
set backspace=indent,eol,start
set shiftwidth=4
set tabstop=4
"     Indentation binds
nnoremap <S-Tab> <<
nnoremap <Tab> >>
inoremap <S-Tab> <C-d>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
"     Splitjoin functionality
let g:splitjoin_split_mapping = ''
nnoremap <Leader>S :SplitjoinSplit<CR>
nnoremap <Leader>J :SplitjoinJoin<CR>
"     Whitespace character viewing
set listchars=eol:�,tab:>-,trail:~,extends:>,precedes:<,space:�,
nnoremap <Leader>l :set list!<CR>
"     Wrapping behavior
set breakindentopt=shift:2
set nobreakindent
set nolinebreak
set nowrap
let s:wrapToggled = 0
fun! EnableWrap()
	echo 'Enabled word wrap'
	set wrap
	set linebreak
	set breakindent
	let s:wrapToggled = 1
endfun
fun! DisableWrap()
	echo 'Disabled word wrap'
	set nowrap
	set nolinebreak
	set nobreakindent
	let s:wrapToggled = 0
endfun
fun! ToggleWordWrap()
	if s:wrapToggled
		call DisableWrap()
	else
		call EnableWrap()
	endif
endfun
nnoremap <Leader>w :call ToggleWordWrap()<CR>
"     Trim trailing whitespace on save
function! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
"   Selection
nmap <Leader>v <C-v>^o$
"   Generic textobjs
Plug 'wellle/targets.vim'
"   Arguments
Plug 'peterrincker/vim-argumentative'
"   HTML/XML textobjs
Plug 'mattn/emmet-vim'
Plug 'whatyouhide/vim-textobj-xmlattr' | Plug 'kana/vim-textobj-user'
Plug 'thalesmello/vim-textobj-methodcall' | Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'gko/vim-coloresque'
Plug 'Valloric/MatchTagAlways'
"    Misc
Plug 'terryma/vim-multiple-cursors'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Raimondi/delimitMate'
let g:delimitMate_expand_cr = 1
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'terryma/vim-expand-region'
"     Datetime
nnoremap <F5> "=strftime("%F")<CR>P
inoremap <F5> <C-R>=strftime("%F")<CR>
nnoremap <S-F5> "=strftime("%F %T")<CR>P
inoremap <S-F5> <C-R>=strftime("%F %T")<CR>

" Buffer navigation
map <C-PageUp> :bp<CR>
map <C-PageDown> :bn<CR>
Plug 'tpope/vim-unimpaired'
Plug 'easymotion/vim-easymotion'
"   Search
set hlsearch
set ignorecase
set incsearch
set smartcase
highlight clear Search
highlight Search gui=underline cterm=underline
map <Leader>h :%s/
"   Better buffer search
Plug 'haya14busa/incsearch.vim'
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
"   Multi-file search
Plug 'dyng/ctrlsf.vim'
function! s:configure_ctrlsf()
	nnoremap <Leader>F :CtrlSF<Space>
	let g:ctrlsf_mapping = {
				\ "next": "n",
				\ "prev": "N",
				\ }
	nnoremap <Leader>f :CtrlSFToggle<CR>
endfun
call s:post_plug_config.add_task('s:configure_ctrlsf')

" Builds
map <Leader>b :make<CR>
Plug 'ErichDonGubler/ctrlp-compiler'
map <Leader>B :CtrlPCompiler<CR>

" Linting
if has('python')
	Plug 'vim-syntastic/syntastic'
	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_check_on_open = 1
	let g:syntastic_check_on_wq = 0
else
	Plug 'w0rp/ale'
endif

" Snippets
if has('python')
	Plug 'SirVer/ultisnips'
else
	Plug 'garbas/vim-snipmate' | Plug 'tomtom/tlib_vim' | Plug 'MarcWeber/vim-addon-mw-utils'
	let g:snipMate = get(g:, 'snipMate', {})
	let g:snipMate.snippet_version = 1
endif
Plug 'honza/vim-snippets'

" Expanded language support
Plug 'jtratner/vim-flavored-markdown'
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
Plug 'rust-lang/rust.vim'
let g:syntastic_rust_checkers = ['rustc']
Plug 'OrangeT/vim-csharp'
Plug 'cespare/vim-toml'
Plug 'jceb/vim-orgmode' | Plug 'tpope/vim-speeddating'
Plug 'gelguy/cmd2.vim'
Plug 'pangloss/vim-javascript'
Plug 'octol/vim-cpp-enhanced-highlight'
"   Sublime config files
augroup sublime
	au!
	au BufNewFile,BufRead *.sublime-project,*.sublime-build,*.sublime-snippet setlocal filetype=json
augroup END

call plug#end()
call s:post_plug_config.run()

