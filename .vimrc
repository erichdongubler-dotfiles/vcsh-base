set encoding=utf-8
set fileencoding=utf-8

call plug#begin('~/.vim/bundle')

" Bindings for vanilla vim
set iskeyword-=.
let maplocalleader = '|'
"   Vim config manipulation
let $VIMHOME = $HOME."/.vim"
nmap <silent> <leader>ve :vsp $VIMHOME<CR>
nmap <silent> <leader>vs :so $MYVIMRC<CR>
fun! s:SetGlobalFileStore(option, name)
	exec 'set ' . a:option . '=$HOME/.vim/' . a:name. '//'
endfun
call s:SetGlobalFileStore('directory', '.swapfiles')
call s:SetGlobalFileStore('backupdir', '.backups')
call s:SetGlobalFileStore('undodir', '.undo')
set undofile
Plug 'djoshea/vim-autoread'
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
imap  <Esc>O
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
let g:plug_window = 'vnew'
"   Helptags command: Normally Pathogen would do this, but we like VimPlug. :)
:command! Helptags call plug#helptags()

" Project configuration
Plug 'embear/vim-localvimrc'
let g:localvimrc_persistent = 1
let g:localvimrc_sandbox = 0

" UI functionalities
if has("gui_running")
	set guioptions-=M " Don't source the menu bar script
	set guioptions-=m " Don't show the menu bar, either. ;)
	set guioptions-=T " Don't show the toolbar
	set guioptions-=e " Don't show GUI tabs

	if has("gui_gtk2")
		set guifont=Inconsolata\ 12
	elseif has("gui_macvim")
		set guifont=Menlo\ Regular:h14
	elseif has("gui_win32")
		set guifont=Consolas:h13:cANSI
	endif
else
	let g:default_cursor_escape = "\<Esc>[ q"
	let g:blinking_ibeam_cursor_escape = "\<Esc>[5 q"
	let g:blinking_underline_cursor_escape = "\<Esc>[3 q"
	let g:blinking_block_cursor_escape = "\<Esc>[1 q"

	let g:insert_cursor_escape = g:blinking_ibeam_cursor_escape
	let g:replace_cursor_escape = g:blinking_underline_cursor_escape
	let g:normal_cursor_escape = g:blinking_block_cursor_escape

	let &t_SI = g:insert_cursor_escape
	let &t_SR = g:replace_cursor_escape
	let &t_EI = g:normal_cursor_escape
endif

"    Fix terminal-specific settings so we get the correct colors and keybinds
" set term=xterm-256color
set lazyredraw
set fillchars=vert:\│
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
" Fix mouse stuff
set mouse=a
set ttymouse=xterm2
noremap <C-ScrollWheelDown> 3zl
noremap <C-ScrollWheelUp> 3zh

Plug 'ErichDonGubler/vim-sublime-monokai'
fun! s:configure_colors()
	colorscheme monokai
	let g:monokai_term_italic = 1
endfun
call plug#add_end_task(function('s:configure_colors'))
"   Status lines
Plug 'vim-airline/vim-airline'
set laststatus=2 " Make airline always appear
"   Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'scrooloose/nerdtree'
let g:NERDTreeIndicatorMapCustom = {
			\ "Modified"  : "M",
			\ "Staged"    : "+",
			\ "Untracked" : "_",
			\ "Renamed"   : "R",
			\ "Unmerged"  : "=",
			\ "Deleted"   : "X",
			\ "Dirty"     : "D",
			\ "Clean"     : ":D",
			\ "Ignored"   : "I",
			\ "Unknown"   : "?"
			\ }
"   Pane manipulation
set hidden
set splitbelow
set splitright
Plug 'vim-scripts/ZoomWin'
Plug 'simeji/winresizer'
let g:winresizer_start_key = '<Leader><CR>'
"   Better buffer closes with panes
Plug 'qpkorr/vim-bufkill'
" Better buffer/tab management
set sessionoptions+=tabpages,globals " Renember tabs in session
Plug 'zefei/vim-wintabs'
" let g:wintabs_display = 'statusline'
let g:wintabs_switchbuf = 'useopen'
let g:wintabs_ui_show_vimtab_name = 2
map <C-PageUp> :WintabsPrevious<CR>
map <C-PageDown> :WintabsNext<CR>
" Plug 'erichdongubler/ctrlp-wintabs'
let g:ctrlp_bufname_mod = ':t'
let g:ctrlp_bufpath_mod = ':~:.:h'

"   Diffs
set diffopt+=vertical
"   Notes
Plug 'mtth/scratch.vim'
let g:scratch_autohide = 0
let g:scratch_insert_autohide = 0
"  tmux integration
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
  call EnableWordWrap()
  Limelight
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  call DisableWordWrap()
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
nnoremap <Leader>g :Goyo<CR>

" Session management
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
let g:prosession_tmux_title = 1

" Symbols
set tags=.tags
augroup tags
	au!
	au BufNewFile,BufRead .tags setlocal filetype=tags
augroup END
if executable('ctags')
	Plug 'xolox/vim-easytags' | Plug 'xolox/vim-misc'
	let g:easytags_async = 1
	let g:easytags_dynamic_files = 2
	let g:easytags_resolve_links = 1
	Plug 'majutsushi/tagbar' | Plug 'xolox/vim-easytags'
	nmap <Leader>t :TagbarToggle<CR>
	let g:airline#extensions#tagbar#enabled = 0
endif

" Fuzzy matching facilities
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_by_filename = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_extensions = ['buffertag', 'line', 'rtscript']
if executable('rg')
	let g:ctrlp_user_command = 'rg %s --follow --files --color=never'
	let g:ctrlp_use_caching = 0
endif
let g:ctrlp_map = '<Leader>p'
map <Leader>p :CtrlP<CR>
map <Leader>P :CtrlPBuffer<CR>
map <Leader>o :CtrlPMRU<CR>
map <Leader>O :CtrlPRTS<CR>
map <Leader>r :CtrlPBufTag %<CR>
map <Leader>R :CtrlPTag<CR>
map <Leader>/ :CtrlPLine<CR>
Plug 'ivalkeen/vim-ctrlp-tjump' | Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_tjump_only_silent = 1
nnoremap <c-]> :CtrlPtjump<CR>
vnoremap <c-]> :CtrlPtjumpVisual<CR>
if has('python')
	Plug 'FelikZ/ctrlp-py-matcher' | Plug 'ctrlpvim/ctrlp.vim'
	let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif

" Files
"   Navigation
Plug 'scrooloose/nerdtree'
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
function! s:clearFilesAndOpenNERDTree()
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
Plug 'tpope/vim-eunuch'
Plug 'pbrisbin/vim-mkdir'
Plug 'kopischke/vim-fetch'

" Text manipulation intelligence
"   Whitespace
set autoindent
set backspace=indent,eol,start
set shiftwidth=4
set tabstop=4
set softtabstop=4
"     Indentation
Plug 'tpope/vim-sleuth'
Plug 'Yggdroot/indentline'
let g:indentLine_setColors = 0
let g:indentLine_char = '┆'
let g:indentLine_setConceal = 0
"     Splitjoin functionality
let g:splitjoin_split_mapping = ''
nnoremap <Leader>S :SplitjoinSplit<CR>
nnoremap <Leader>J :SplitjoinJoin<CR>
"     Whitespace character viewing
set list
fun! EnableShowWhitespace(...)
	set listchars=eol:$,tab:\├\─,trail:~,extends:>,precedes:<,space:·,
	let s:showWhitespaceToggled = 1
endfun
fun! DisableShowWhitespace(...)
	set listchars=tab:\┆\ ,precedes:<,extends:>
	let s:showWhitespaceToggled = 0
endfun
fun! ToggleShowWhitespace()
	if s:showWhitespaceToggled
		call DisableShowWhitespace()
	else
		call EnableShowWhitespace()
	endif
endfun
call DisableShowWhitespace()
nnoremap <Leader>i :call ToggleShowWhitespace()<CR>
"     Wrapping behavior
set formatoptions-=t " Disable hard breaks at textwidth boundary
set breakindentopt=shift:2 " Show soft-wrapped text with extra indent of 2 spaces
Plug 'ErichDonGubler/vim-option-bundle'
fun! DisableWordWrap()
	call g:word_wrap_bundle.SetLocalTo(0)
endfun
fun! EnableWordWrap()
	call g:word_wrap_bundle.SetLocalTo(1)
endfun
fun! BindWordWrapOptions()
	let g:word_wrap_bundle = option_bundle#create('word wrap', 0, ['wrap', 'linebreak', 'breakindent'])
	nnoremap <Leader>w :call g:word_wrap_bundle.ToggleLocal()<CR>
	nnoremap <Leader>W :call g:word_wrap_bundle.ToggleGlobal()<CR>
endfun
call plug#add_end_task(function('BindWordWrapOptions'))
"     Trim trailing whitespace on save
function! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
"   Alignment
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
"   Selection
nmap <Leader>v <C-v>^o$
"   Generic textobjs
Plug 'wellle/targets.vim'
Plug 'glts/vim-textobj-comment'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
"   Arguments
Plug 'peterrincker/vim-argumentative'
"   Prose
Plug 'reedes/vim-textobj-quote'
"   HTML/XML textobjs
Plug 'mattn/emmet-vim'
Plug 'whatyouhide/vim-textobj-xmlattr' | Plug 'kana/vim-textobj-user'
Plug 'thalesmello/vim-textobj-methodcall' | Plug 'kana/vim-textobj-user'
"   Nice highlighting plugins
Plug 'geoffharcourt/vim-coloresque'
if has('python')
	Plug 'Valloric/MatchTagAlways'
endif
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
"    Misc
Plug 'terryma/vim-multiple-cursors'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-endwise'
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
vmap <Leader>h :s/
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
Plug 'haya14busa/incsearch-easymotion.vim' | Plug 'easymotion/vim-easymotion' | Plug 'haya14busa/incsearch.vim'
map <Leader><Leader>/ <Plug>(incsearch-easymotion-/)
map <Leader><Leader>? <Plug>(incsearch-easymotion-?)
map <Leader><Leader>g/ <Plug>(incsearch-easymotion-stay)
Plug 'gelguy/cmd2.vim'
let g:Cmd2_options = {
	\ '_complete_ignorecase': 1,
	\ '_complete_uniq_ignorecase': 0,
	\ '_complete_fuzzy': 1,
	\ }
map / /<F12>
cmap <F12> <Plug>(Cmd2Suggest)
"   Multi-file search
Plug 'dyng/ctrlsf.vim'
function! s:configure_ctrlsf()
	nnoremap <Leader>F :CtrlSF<Space>

	let g:ctrlsf_mapping = {
				\ "next": "n",
				\ "prev": "N",
				\ }
	let g:ctrlsf_case_sensitive = 'smart'
	nnoremap <Leader>f :CtrlSFToggle<CR>
	if executable('rg')
		let g:ctrlsf_ackprg = 'rg'
		let g:ctrlsf_extra_backend_args = {
			\ 'rg': '--follow'
			\ }
	" else
	" 	let g:ctrlsf_ackprg = 'grep'
	endif
endfun
call plug#add_end_task(function('s:configure_ctrlsf'))

" Builds
map <Leader>b :make<CR>
Plug 'ErichDonGubler/ctrlp-compiler'
map <Leader>B :CtrlPCompiler<CR>

" Linting
if has('python')
	Plug 'w0rp/ale'
else
	Plug 'vim-syntastic/syntastic'
	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_check_on_open = 1
	let g:syntastic_check_on_wq = 0
endif

" Completion
if has('python')
	Plug 'Valloric/YouCompleteMe', { 'do': 'python2 install.py' }
	let g:ycm_key_list_select_completion = ['<C-n>']
	let g:ycm_key_list_previous_completion = ['<C-p>']
endif

" Snippets
if has('python')
	Plug 'SirVer/ultisnips'
	let g:UltiSnipsExpandTrigger = '<Tab>'
	let g:UltiSnipsJumpForwardTrigger = '<Tab>'
	let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
else
	Plug 'garbas/vim-snipmate' | Plug 'tomtom/tlib_vim' | Plug 'MarcWeber/vim-addon-mw-utils'
	let g:snipMate = get(g:, 'snipMate', {})
	let g:snipMate.snippet_version = 1
endif
Plug 'honza/vim-snippets'

" Expanded language support
Plug 'gisphm/vim-gitignore'
Plug 'plasticboy/vim-markdown'
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
let g:org_heading_highlight_colors = ['Identifier']
let g:org_heading_highlight_levels = 10 " Some arbitrary number
autocmd FileType text,org call EnableWordWrap()
Plug 'rudes/vim-java'
Plug 'pangloss/vim-javascript'
let g:tagbar_type_javascript = {
			\ 'ctagstype' : 'JavaScript',
			\ 'kinds'     : [
				\ 'o:objects',
				\ 'c:classes',
				\ 'f:functions',
				\ 'a:arrays',
				\ 'm:methods',
				\ 'n:constants',
				\ 's:strings'
				\ ]
			\ }
if executable('npm')
	Plug 'mxw/vim-jsx'
	Plug 'leafgarland/typescript-vim'
	Plug 'posva/vim-vue', { 'do': 'npm i -g eslint eslint-plugin-vue' }
endif
Plug 'leafgarland/typescript-vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'python-mode/python-mode'
"   Sublime config files
augroup sublime
	au!
	au BufNewFile,BufRead *.sublime-project,*.sublime-build,*.sublime-snippet setlocal filetype=json
augroup END

call plug#end()

function! SyntaxItem()
	return synIDattr(synID(line("."), col("."), 1), "name")
endfunction

