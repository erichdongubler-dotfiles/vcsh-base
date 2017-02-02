set backspace=indent,eol,start

execute pathogen#infect()

colorscheme monokai
syntax enable

autocmd BufWritePre * %s/\s\+$//e

set autoindent
set hlsearch
set incsearch
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set nowrap
set shiftwidth=4
set tabstop=4

augroup markdown
	au!
	au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END
