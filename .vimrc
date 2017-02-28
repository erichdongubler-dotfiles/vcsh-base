"Editor behavior/keybinds
autocmd BufWritePre * %s/\s\+$//e "trim trailing whitespace on save
set autoindent
set backspace=indent,eol,start
set hlsearch
set incsearch
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set nowrap
set shiftwidth=4
set tabstop=4

"Other plugins
execute pathogen#infect()

" Syntax highlighting
colorscheme monokai
syntax enable
augroup markdown
	au!
	au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

