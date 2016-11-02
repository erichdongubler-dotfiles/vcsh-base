set backspace=indent,eol,start

execute pathogen#infect()
syntax enable
colorscheme monokai
set nowrap
set shiftwidth=4
set tabstop=4
augroup markdown
	au!
	au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END
