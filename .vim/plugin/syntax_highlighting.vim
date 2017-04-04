" Fix terminal-specific settings so we get the correct colors and keybinds
"set term=xterm-256color
set t_ut=
if &term =~ '^screen'
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"
	map <Esc>[B <Down>
endif

filetype plugin indent on
colorscheme monokai
syntax enable

