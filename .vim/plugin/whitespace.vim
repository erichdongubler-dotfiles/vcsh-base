" Trim trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Use Ctrl-Enter to go to a new line
imap <C-CR> <Esc>o
imap  <Esc>o

" General indentation behavior
set autoindent
set backspace=indent,eol,start
set shiftwidth=4
set tabstop=4

" Whitespace character viewing
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<,space:·,
nnoremap <Leader>l :set list!<CR>

" delimitMate
let g:delimitMate_expand_cr = 1

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

